
if y <= final_y-10{
	mask_index = spr_empty;
	depth = -16000
	
} else {
	mask_index = spr_spikes
	depth = -bbox_bottom;
	if fade_in_alpha < 1{
		fade_in_alpha += 0.1
	}
	
}


event_inherited();


if y <= final_y{
	y += vel;
} else{
	sprite_index = spr_spikes_destroy;
}

if obj_batalhaturno_manager.battle_timer <= 0{
	instance_destroy()
}


if sprite_index == spr_spikes_destroy && image_index == 2{
	draw_shadow = false
}



var _inst = obj_player


if place_meeting(x, y, _inst) && _inst.cooldown <= 0{
	audio_play_sound(snd_dmg, 3, 0, 1);
	_inst.values.hp -= bullet_damage;
	_inst.cooldown = 15
}

show_debug_message(mask_index)

