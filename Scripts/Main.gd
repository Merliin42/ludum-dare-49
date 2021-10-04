extends Node2D


var balance : float = 0.0 # Balance of the character

var right_left : Array = [-1, 1]
var weights : Array = [0, 0] # Total of the weights on the pole
var counter : Array = [0, 0] # Counter of objects on the pole
var total_bird : int = 0
var player_capacity : int = 50

onready var lines : Array = [$Node_Oiseau/Line, $Node_Oiseau/Line2, $Node_Oiseau/Line3, $Node_Oiseau/Line4, $Node_Oiseau/Line5, $Node_Oiseau/Line6]

var object_weight := preload("res://Scenes/Weights/Bird.tscn")

func _ready():
	$CameraAnimation.play("pan_in")
	$CharacterAnimation.play("fall-left")
	randomize()

func _process(delta):
	var player_input : float = get_input()

	balance = (balance + (weights[1] - weights[0] + (player_input*player_capacity)) * delta) * 1.02
	$HUD.update(balance)
	
	if(balance < -100 or balance > 100) :
		$CameraAnimation.play("pan_out")
	
	$Camera2D.zoom += Vector2(0.01 * delta, 0.01 * delta)

func get_input():
	var left : float
	var right : float
	if Input.is_action_pressed("left"):
		left = Input.get_action_strength("left")
	if Input.is_action_pressed("right"):
		right = Input.get_action_strength("right")
	return right-left


func _on_Timer_timeout():
	var side : int = randi() % 2
	var weight : = object_weight.instance()
	
	var index : int = randi() % 3 if side == 0 else randi() % 3 + 3
	
	lines[index].counter += 1
	weight.position.y -= lines[index].counter * 64 - 50
	weight.side = side
	weight.connect("on_landing", self, "on_bird_landing")
	$BirdAudio.pitch_scale = 1 + rand_range(-0.5, 0.5)
#	print($BirdAudio.pitch_scale)
	$BirdAudio.play()
	lines[index].add_child(weight)
	total_bird += 0.5
	player_capacity += 1

func on_bird_landing(weight) :
	weights[weight.side] += weight.weight + total_bird
	counter[weight.side] += 1


func _on_CameraAnimation_animation_finished(anim_name):
	if anim_name == "pan_out" :
		get_tree().change_scene("res://Scenes/Menu.tscn")
