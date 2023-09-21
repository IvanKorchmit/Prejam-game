extends Node


@export var zoom_min = 0.5
@export var zoom_max = 2
@export var sensitivity: float

@onready var z_min = Vector2.ONE * self.zoom_min
@onready var z_max = Vector2.ONE * self.zoom_max
@onready var z_sens = Vector2.ONE * self.sensitivity
@onready var camera = $".."

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				camera.zoom -= z_sens
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				camera.zoom += z_sens
				
			camera.zoom = camera.zoom.clamp(z_min, z_max)
