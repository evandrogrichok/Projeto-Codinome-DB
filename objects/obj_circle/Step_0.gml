var inst_player = obj_player


x = lerp(x, inst_player.x,0.01)
y = lerp(y, inst_player.y,0.01)



sin_t_1 += 0.1
sin_t_2 += 0.1

var inst = collision_circle(x, y, 60, obj_player,false, false)
var instint = collision_circle(x, y, 55, obj_player,false, false)

if inst != noone && instint == noone{
	if inst_player.cooldown <= 0{
	obj_player.values.hp -= dano;
	inst_player.cooldown = 5
	}
}

if obj_batalhaturno_manager.battle_timer <= 0{
	instance_destroy()
}
