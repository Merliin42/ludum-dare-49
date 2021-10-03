extends Position2D

export var counter : int = 0

func _to_string():
	print("name : " + self.name + "\n" + "counter : " + str(self.counter))
