extends Node2D
@onready var AnimatedSprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	AnimatedSprite.frame=0
	AnimatedSprite.play("Animate")



func _on_animated_sprite_2d_animation_finished():
	queue_free()
