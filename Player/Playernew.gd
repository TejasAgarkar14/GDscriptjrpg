extends CharacterBody2D

const ACCELERATION=500
const MAX_SPEED=70
const ROLL_SPEED=80
const FRICTION=500


enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var roll_vector = Vector2.DOWN

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationstate = animationTree.get("parameters/playback")
@onready var SwordHitbox = $HitboxPivot/SwordHitbox

func _ready():
	animationTree.active = true
	SwordHitbox.knockback_vector = roll_vector

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)
			
func move_state(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		SwordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationstate.travel("Run")
		velocity=velocity.move_toward(input_vector*MAX_SPEED, ACCELERATION*delta)
	else:
		animationstate.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	if Input.is_action_just_pressed("Roll"):
		state = ROLL
		
	move()
func roll_state(_delta):
	velocity = roll_vector * ROLL_SPEED
#pass #state = MOVE(just for copy paste purpose)
	animationstate.travel("Roll")
	move()

func attack_state(_delta):
	velocity = Vector2.ZERO
	animationstate.travel("attack")
	
func move():
	move_and_slide()
	
func roll_animation_finished():
	velocity = Vector2.ZERO
	state = MOVE
	
func attack_animation_finished():
	state = MOVE 
