var is_cutscene = false;
if (instance_exists(obj_cutscene_manager)){
	is_cutscene = global.cutscene_active
}

if (moving){
	if (move_type == MOVE_TYPES.move)
	step_move_to();

	if (is_cutscene){
		if (move_type == MOVE_TYPES.walk)
		step_walk_to();
	}
}