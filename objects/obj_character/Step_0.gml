index_spr = scr_animar_sprite(index_spr, spd_spr, sprite_index);

depth = DEPTH.ENTITY_BASE - y;

var is_cutscene = false;
if (instance_exists(obj_cutscene_manager)){
	is_cutscene = global.cutscene_active
}

if (moving){
	if (move_type == MOVE_TYPES.move)
	step_move_to();

	if (move_type == MOVE_TYPES.walk)
	step_walk_to();
}


if (!instance_exists(obj_cutscene_manager) && instance_exists(target)) {
	var last_index = array_length(target.walk_history) - 1 - (line_position * distance);
	last_index = clamp(last_index, 0, 512);
	
	if array_length(target.walk_history) > 0 && target.moving {
		var t_x = target.walk_history[last_index][0]
		var t_y = target.walk_history[last_index][1]
		
		walk_to(t_x, t_y, 2, "absolute");

		target_x = t_x;
		target_y = t_y;

	}
}

