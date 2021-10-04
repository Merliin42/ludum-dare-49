extends Node2D

signal on_landing(weight)
export var weight : int = 1
var side : int = 0

func _ready():
	$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 2, Tween.TRANS_LINEAR)
	$Tween.start()
	

func _on_Tween_tween_completed(object, key):
	$AnimatedSprite.play("bird_still")
	emit_signal("on_landing", self)
