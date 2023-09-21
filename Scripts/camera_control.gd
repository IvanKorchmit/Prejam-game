extends Node


@export var speed = 150.0
@onready var parent = $".."

func _process(delta):
	var dir = Input.get_vector("left","right","up","down") * speed
	
	parent.position += dir * delta
