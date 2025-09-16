

if shake_level >= 0{
	var shake_x = 0
	var shake_y = 0
	var shake_dir = irandom(360)

	shake_x = x + lengthdir_x(shake_level, shake_dir);
	shake_y = y + lengthdir_y(shake_level, shake_dir);
		
	draw_sprite(sprite_index, image_index, shake_x, shake_y);
	
	
	if fog_timer > 0{
		gpu_set_fog(true, c_white, 0, 0);
		draw_sprite_ext(sprite_index, image_index, shake_x, shake_y, 1, 1, 0, c_white, 1);
		gpu_set_fog(false, c_white, 0, 0);
	}

} else {
	draw_self();
}





if dec == overworld_decisions.purified{
	draw_sprite_ext(sprite_index, -1, x, y, 1, 1, 0, c_white, 1);
}
draw_text(x-5, y-70, "decision: " + string(dec))
draw_text(x-5, y-60, "resistencia: " + string(values.hp))
draw_text(x-5, y-50, "cooldown: " + string(cooldown))
draw_text(x-5, y-40, "stunned timer: " + string(stunned_timer))
draw_text(x-5, y-30, "distance to player: " + string(distance_to_player))