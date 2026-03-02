extends StaticBody2D

@export var slow_object : float = 2.0

var getting_pushed : bool = false

var pushed_multiplier : float = 300.0

var player_ship : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
		



func _physics_process(delta: float) -> void:
	
	if getting_pushed == true and player_ship.is_on_wall() == false:
		pull_ship(player_ship, pushed_multiplier, delta)
	else:
		# print('NOT pushed')
		pass


func _on_static_body_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("ships"):
		
		player_ship = target_player_ship(body)
		
		# slow_ship(body)
		
		getting_pushed = true
	

func _on_static_body_2d_body_exited(body: Node2D) -> void:
	
	if body.is_in_group('ships'):
		
		# slow_ship(body)
		
		getting_pushed = false



func target_player_ship(target) -> CharacterBody2D:
	
	if is_in_group('player'):
		print('Got em')
		
	return target

	
func slow_ship(target):
	
	if target.slowed == false:
		target.slowed = true
	else:
		target.slowed = false
	
	
func pull_ship(target, push, delta_time):
	
	# changes the position accordingly but lacks fluidity since it directly changes position
	# target.position += (target.position - position).normalized() * push * delta_time
	
	if target.movement_type == 'velocity':
		# A pushed by B
		target.velocity += (target.position - position).normalized() * push * delta_time
	else:
		target.position += (target.position - position).normalized() * push * delta_time
	

