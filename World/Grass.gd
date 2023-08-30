extends Node2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func create_grass_effect():
	var GrassEffect = load("res://grass_effect.tscn") #for loading the grass or its effect. mayybe idk for sure.
	var grassEffect = GrassEffect.instantiate() # in this line the grass effect is joined together to each other or something similar to that, idk for sure look in video at time stamp 23:00
	var world =  get_tree().current_scene #This maybe is to load the grass and grass effect in the main game scene & the next line is also for same maybe
	world.add_child(grassEffect)
	grassEffect.global_position =  global_position # this line is for positioning the grass effect to grass wherever they are placed

#(part10 comment,old)This code made with the helpp of instruction of Heartbeast in Godot 3.2 ARPG part 10.(old comment, deleted some part of this code in part 11)
#3Aug23: part 11

func _on_hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()
