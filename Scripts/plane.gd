extends CharacterBody2D


@export var speed: float = 300

@onready var nav = $NavigationAgent2D
@onready var visual = $Visual

func _ready():
	nav.velocity_computed.connect(_computed_velocity)

func _physics_process(delta):
	nav.velocity = position.direction_to(nav.get_next_path_position()) * speed
	
	_rotate_plane()
	
	move_and_slide()
	
func _rotate_plane():
	visual.rotation_degrees = rad_to_deg(velocity.angle()) + 90
	
func select():
	print("selected")
func unselect():
	print("unselected")

func _computed_velocity(safe_velocity: Vector2):
	velocity = safe_velocity

func move(pos: Vector2):
	nav.target_position = pos
