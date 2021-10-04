extends Control


func _ready():
	$AnimationPlayer.play("pan_in")

func _on_Start_pressed():
	$AnimationPlayer.play("pan_out")



func _on_Quit_pressed():
	get_tree().quit()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "pan_out" :
		get_tree().change_scene("res://Scenes/Main.tscn")
