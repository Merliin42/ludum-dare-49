extends Node2D


var balance : float = 0.0 # Balance of the character

var landing_positions : Array = [1, 2, 3] # Position where the bird can land
var right_left : Array = [-1, 1]
var weights : Array = [0, 0] # Total of the weights on the pole
var counter : Array = [0, 0] # Counter of objects on the pole

var object_weight := preload("res://Scenes/Weight.tscn")

func _ready():
	randomize()

func _process(delta):
	var player_input : float = get_input()
	balance = (balance + (weights[0] + weights[1] + (player_input*200)) * delta) * 1.02
	
	print(balance)
	$Sprite.position.x = balance
	$HUD.update(balance)

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
	var new_position : int = right_left[side]
	var weight := object_weight.instance()
	
	weight.position.x = weight.position.x * new_position
	weight.position.y -= counter[side] * 64
	weight.weight *= new_position
	weights[side] += weight.weight
	counter[side] += 1
	add_child(weight)
