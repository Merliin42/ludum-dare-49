extends Node2D

var balance : float = 0.0

func _process(delta):
	var player_input : float = get_input()
	balance += player_input * delta * 100
	$Sprite.position.x = balance
	print(balance)

func get_input():
	var left : float
	var right : float
	if Input.is_action_pressed("left"):
		left = Input.get_action_strength("left")
	if Input.is_action_pressed("right"):
		right = Input.get_action_strength("right")
	return right-left
