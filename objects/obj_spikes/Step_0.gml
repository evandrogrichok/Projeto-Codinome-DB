vel = lerp(vel, vel_default, 0.2)
width = lerp(width, 1, 0.2)

event_inherited();


if y <= final_y{
	y += vel;
} else{
	sprite_index = spr_spikes_destroy;
}

if obj_battle_manager.enemy_attack_duration <= 0{
	instance_destroy()
}


if sprite_index == spr_spikes_destroy && image_index == 2{
	draw_shadow = false
}



var _inst = obj_player


if place_meeting(x, y, _inst){
	scr_player_dmg(bullet_damage, 15, 1, 1)
}


