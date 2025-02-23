extends Character

onready var sprite = $Sprite
onready var hitBox = $HitBox/hitBox
var is_jumping = false
func _ready():
	hitBox.set_disabled(true)
func get_direction():
	return Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), -1.0 if Input.is_action_just_pressed("ui_up") and is_on_floor() else 1.0)

func calculate_move_velocity(Direction):
	var return_velocity = velocity
	return_velocity.x = Direction.x * speed.x
	if Direction.y == -1:
		
		return_velocity.y = Direction.y * speed.y
	else:
		return_velocity.y += gravity * get_physics_process_delta_time()
	return return_velocity

func _physics_process(_delta):
	var direction = get_direction()
	
	velocity = calculate_move_velocity(direction)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	animationHandler(direction)

func animationHandler(direction):
	if !(sprite.get_animation() == "Attack1" and !sprite.get_frame() == 6) :
		if !hitBox.disabled:
			hitBox.set_disabled(true)
		if is_on_floor():
			if direction.x != 0:
				sprite.play("Run")
				if direction.x > 0:
					sprite.flip_h = true
					hitBox.position.x = 20
				else:
					sprite.flip_h = false
					hitBox.position.x = -17
			else:
				sprite.play("Idle")
		elif direction.y < 0:
			sprite.play("Jump")
func _input(event):
	if event.is_action_pressed("attack"):
		sprite.play("Attack1")
		hitBox.set_disabled(false)
