extends StaticBody2D

@export var slow_object : float = 2.0

var getting_pulled : bool = false

var pulled_multiplier : float = 300.0

var player_ship : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
		



func _physics_process(delta: float) -> void:
	
	if getting_pulled == true and player_ship.is_on_wall() == false:
		pull_ship(player_ship, pulled_multiplier, delta)
	else:
		# print('NOT pulled')
		pass


func _on_static_body_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("ships"):
		
		player_ship = target_player_ship(body)
		
		# slow_ship(body)
		
		getting_pulled = true
	

func _on_static_body_2d_body_exited(body: Node2D) -> void:
	
	if body.is_in_group('ships'):
		
		# slow_ship(body)
		
		getting_pulled = false



func target_player_ship(target) -> CharacterBody2D:
	
	if is_in_group('player'):
		print('Got em')
		
	return target

	
func slow_ship(target):
	
	if target.slowed == false:
		target.slowed = true
	else:
		target.slowed = false
	
	
func pull_ship(target, pull, delta_time):
	
	# changes the position accordingly but lacks fluidity since it directly changes position
	# target.position += (position - target.position).normalized() * pull * delta_time
	if target.movement_type == 'velocity':
		# A is the ship
		# B is the astroid
		# B pulls A
		target.velocity += (position - target.position).normalized() * pull * delta_time
	else:
		target.position += (position - target.position).normalized() * pull * delta_time
	
	

