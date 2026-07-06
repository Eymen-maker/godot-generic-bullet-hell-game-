extends CharacterBody2D
@onready var bomb_particles: GPUParticles2D = $BombParticles
@onready var bomb_particle_explosion: GPUParticles2D = $BombParticleExplosion
@onready var item_bomb_damage_area: Area2D = $ItemBombDamageArea
@onready var despawn_timer: Timer = $DespawnTimer
@onready var sprite_2d: Sprite2D = $Sprite2D



var where_it_should_go # taken from outside
var where_it_was
var where_it_is 
var percent
var to_be_velocity = Vector2(0,0)
var dir
var total_distance
var once = 0
var exploded = 0
var once2 = -1
var despawn_time = 3

func _ready() -> void:
	Global.item_bomb_damage = 45 
	bomb_particles.emitting = false
	bomb_particles.one_shot = true
	
	bomb_particle_explosion.emitting = false
	bomb_particle_explosion.one_shot = true
	
	item_bomb_damage_area.process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta: float) -> void:
	if once == 0:
		where_it_is = where_it_was
		dir = (get_local_mouse_position()).normalized()
		total_distance = Vector2.ZERO.distance_to(get_local_mouse_position())
		once = 1
	
	
	if item_bomb_damage_area.process_mode == Node.PROCESS_MODE_INHERIT and once2 == 1:
		item_bomb_damage_area.process_mode = Node.PROCESS_MODE_DISABLED
	
	
	where_it_is = position
	var traveled = where_it_was.distance_to(position)
	percent = traveled / total_distance
	
	
	if percent >= 0.99:
		if once2 < 1:
			despawn_timer.start(despawn_time)
			item_bomb_damage_area.process_mode = Node.PROCESS_MODE_INHERIT
			sprite_2d.visible = false
		bomb_particles.emitting = true
		bomb_particle_explosion.emitting = true
		velocity = Vector2.ZERO
		exploded = 1
		once2 += 1
	elif percent < 0.8:
		velocity = (percent + 0.1 ) * 1000 * dir
	else:
		velocity = (1.0 - percent) * 1000 * dir
	
	
	move_and_slide()



func _on_timer_timeout() -> void:
	if exploded == 1:
		queue_free()
	else:
		despawn_timer.start(despawn_time)
