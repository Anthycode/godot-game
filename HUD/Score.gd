extends Label

var counter = 0
var updateTimer = 1.0
var labelUpdateInterval = 1.0





func _process(delta):
	updateTimer -= delta
	if updateTimer <= 0.0:
		counter += 1
		text = str(counter)
		updateTimer = labelUpdateInterval
