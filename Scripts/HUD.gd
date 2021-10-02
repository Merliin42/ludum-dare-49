extends CanvasLayer


func update(balance) :
	var left : float = 0
	var right : float = 0
	if balance < 0 :
		left = -balance
	elif balance > 0 :
		right = balance
	$EquilibriumBar/Left.value = left
	$EquilibriumBar/Right.value = right
