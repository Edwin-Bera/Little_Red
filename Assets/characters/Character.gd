class_name Character
extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = Vector2(100, 140)
var gravity = ProjectSettings.get("physics/2d/default_gravity")

func _process(delta):
	velocity.y += gravity * delta
	if velocity.y > speed.y:
		velocity.y = speed.y
