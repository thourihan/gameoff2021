extends KinematicBody2D

var velocity = Vector2()
var falling_speed = 300
var speed = 220

var total_bananas = 0

# define bounds
var up = 520
var db = 150
var rb = 950
var lb = 75

var particles_scene = load("res://Scenes/BananaParticles.tscn")
var gameover_scene = load("res://Scenes/GameOverMenu.tscn")
var banana_sound = load("res://Scenes/BananaSound.tscn")
var rock_sound = load("res://Scenes/RockSound.tscn")

onready var game_manager = get_node("/root/GameManager")
onready var anim_speed = $AnimatedSprite.speed_scale
onready var UI = get_node("/root/Main/UI")

func _ready():
	get_parent().get_node("Music").playing = true

func _physics_process(_delta):
	if game_manager.game_running:
		anim_speed = 1.2
		get_input()
		# Check the player's bounds and then let them move
		check_bounds()
		velocity = move_and_slide(velocity)
	else:
		velocity = Vector2()
		velocity.y += falling_speed
		velocity = move_and_slide(velocity)
		pass
		
func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("right"):
		velocity.x += 0.35
		anim_speed = 1.5
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		anim_speed = 1.0
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1

	velocity *= speed

func check_bounds():
	# Check if the player is near any boundaries. If they are, bump their position to be within the flying area
	if position.x > rb:
		position.x = rb - 1
	elif position.x < lb:
		position.x = lb + 1
	if position.y < db:
		position.y = db + 1
	elif position.y > up:
		position.y = up - 1

func _on_Area2D_area_entered(area):
	if "Fruit" in area.name:
		var particles = particles_scene.instance()
		particles.position = area.position
		get_parent().add_child(particles)
		area.queue_free()
		var sound = banana_sound.instance()
		get_parent().add_child(sound)
		total_bananas += 1
	elif "Stal" in area.name:
		print("GAME OVER")
		$AnimatedSprite.animation = "death"
		game_manager.game_running = false
		var sound = rock_sound.instance()
		get_parent().add_child(sound)
		# Create the game over menu
		var gameover_menu = gameover_scene.instance()
		gameover_menu.get_node("VBox").get_node("InfoLabel").text = "Your distance: " + str(round(UI.dist_traveled)) + "\nYour Bananas: " + str(total_bananas) + "\nTotal Score: " + str(round(UI.dist_traveled * (total_bananas * 0.2))) 
		get_parent().add_child(gameover_menu)
		get_parent().get_node("Music").playing = false
		

		
