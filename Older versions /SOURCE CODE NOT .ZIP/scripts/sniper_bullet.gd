extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sniper_bullet_area: Area2D = $SniperBulletArea

var touching_body = false
var SPEED = 3000
var parred = 1
# Global.sniper_bullet_damage = 50


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") : 
		Global.current_player_health -= Global.sniper_bullet_damage
		queue_free()
	
	if body.is_in_group("enemies"):
		if parred != 1:
			queue_free()

func _on_sniper_bullet_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("ParryArea"):
		parred = -1 * 2
		sprite_2d.flip_h = true
		sniper_bullet_area.add_to_group("player_bullet")
		sniper_bullet_area.remove_from_group("EnemyBullet")
		add_to_group("player_bullet")
		remove_from_group("EnemyBullet")
	
	if area.name == "ParryAreaChecker":
		add_to_group("EnemyBulletInParryArea")
		sniper_bullet_area.add_to_group("EnemyBulletInParryArea")
	
	if area.is_in_group("enemies"):
		if parred != 1:
			queue_free()

func _on_sniper_bullet_area_area_exited(area: Area2D) -> void:
	if area.name == "ParryAreaChecker":
		remove_from_group("EnemyBulletInParryArea")
		sniper_bullet_area.remove_from_group("EnemyBulletInParryArea")


func _process(delta: float) -> void:
	
	# makes bullet go out of the gun forward
	position += transform.x * SPEED * delta * parred 
	
	move_and_slide()

func _on_timer_timeout() -> void:
	queue_free()
