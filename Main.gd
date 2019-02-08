extends Node2D

export (PackedScene) var Mob
var score

func _ready():
	randomize()#	pass

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play
	
func new_game():
	score = 0
	$Player.Start($StartPosition.position)
	$StartTimer.start()
	$Music.play()
	$HUD.update_score(score)
	$HUD.show_message("Ready!")
	
		
func _on_StartTimer_timeout():
	pass # replace with function body

func _on_ScoreTimer_timeout():
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	mob.position = $MobPath/MobSpawnLocation.position
	
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	
	mob.set_linear_velocity(vector2(rand_range(mob.min_speed,mob.max_speed),0).rotated(direction))