extends CharacterBody2D
@onready var despawn_timer: Timer = $despawnTimer
@onready var enemy_bullet_area: Area2D = $EnemyBulletArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D



var SPEED = Global.bullet_speed_custom * 3
var despawntime = 6
var parred = 1 # 1 means false for this case

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		if parred == 1:
			Global.current_player_health -= Global.bullet_damage_custom
			queue_free()
	
	if body.is_in_group("enemies"): 
		if parred != 1:
			queue_free()
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("ParryArea"):
		parred = -1 * 2
		animated_sprite_2d.flip_h = false
		enemy_bullet_area.add_to_group("player_bullet")
		enemy_bullet_area.remove_from_group("EnemyBullet")
		remove_from_group("EnemyBullet")
		
	if area.name == "ParryAreaChecker":
			add_to_group("EnemyBulletInParryArea")
			enemy_bullet_area.add_to_group("EnemyBulletInParryArea")
		
	if area.is_in_group("enemies"): 
		if parred != 1:
			queue_free()

func _on_enemy_bullet_area_area_exited(area: Area2D) -> void:
	if area.name == "ParryAreaChecker":
		enemy_bullet_area.remove_from_group("EnemyBulletInParryArea")
		remove_from_group("EnemyBulletInParryArea")


func _ready() -> void:
	animated_sprite_2d.flip_h = true
	despawn_timer.start(despawntime)


func _physics_process(delta: float) -> void:
	# makes bullet go out of the gun forward
	position += transform.x * SPEED * delta * parred
	move_and_slide()





func _on_despawn_timer_timeout() -> void:
	queue_free()
