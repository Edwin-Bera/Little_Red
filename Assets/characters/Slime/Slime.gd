extends Character

export var attackrange = 15
onready var FloorDetector = $FloorDetector
onready var PlayerDetector = $PlayerDetector
onready var hitbox =$HitBox/collision
var isPlayerDetected = false
var playerBody


func _ready():
	hitbox.set_disabled(true)
	$Sprite.play("Walk")
	speed.x = 20

var direction = 1

func animation(Direction):
	if ($Sprite.get_animation() == "Attack" and $Sprite.get_frame() == 5):
		if !(hitbox.is_disabled()):
			hitbox.set_disabled(true)
			$Sprite.play("Walk")
	if Direction == 1:
		$Sprite.flip_h = true
		PlayerDetector.rotation_degrees = -90
	else :
		$Sprite.flip_h = false
		PlayerDetector.rotation_degrees = 90
	if isPlayerDetected :
		 rangeCheck(playerBody)

func _physics_process(delta):
	if !(isPlayerDetected):
		if is_on_wall() or  !(FloorDetector.is_colliding()):
			direction *= -1
			
	else:
		if playerBody.position.x > position.x:
			direction = 1
		else:
			direction = -1
	animation(direction)
		
	velocity.x = direction * speed.x
	
	velocity = move_and_slide(velocity, Vector2.UP)



func Attack():
	$Sprite.play("Attack")
	hitbox.set_disabled(false)



func PlayerDetected(body):
	isPlayerDetected = true
	playerBody = body

func rangeCheck(body):
	var d
	if position.x > body.position.x :
		d = position.x - body.position.x
	else :
		d = body.position.x - position.x
	if d <= attackrange:
		Attack()
