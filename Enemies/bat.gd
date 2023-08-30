extends CharacterBody2D

var Knockback = Vector2.ZERO

func _physics_process(delta):
	Knockback = Knockback.move_toward(Vector2.ZERO, 200 * delta)
	move_and_collide(Knockback)


func _on_hurtbox_area_entered(area):
	if area.name == "SwordHitbox": #This was with the help of a discord person.
		Knockback = area.knockback_vector * 15
		
