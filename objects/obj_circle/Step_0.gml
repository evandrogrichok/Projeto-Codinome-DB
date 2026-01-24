var inst_player = obj_player


x = lerp(x, inst_player.x,0.01)
y = lerp(y, inst_player.y,0.01)



sin_t += 0.1
range = lerp(range, range + 8*sin(sin_t/4), 0.1)

var inst = collision_circle(x, y, range, obj_player,false, false)
var instint = collision_circle(x, y, range-10, obj_player,false, false)

if inst != noone && instint == noone{

    inst_player.values.take_dmg(5, 5, 1, 1);
	

}

if obj_battle_manager.enemy_attack_duration <= 0{
	instance_destroy()
}
