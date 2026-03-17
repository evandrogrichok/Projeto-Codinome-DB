


switch(point_type){
	case POINT_TYPES.breakable:
	if obj_player.dashing{solid = false;} else {solid = true;}
	
	if (place_meeting(x, y, obj_player) && state == POINT_STATES.normal){
		fx_particle(point_type_size);
		audio_play_sound(point_type_sound, 2, false, 1, 0, random_range(0.8, 1.2));
		state = POINT_STATES.collected;
		can_disappear = true;
		image_index = 0;
		image_speed = 0;
		obj_camera.cam_shake(1, 1)
		obj_battle_manager.add_dance_points(dp_value);
	}
	break;
	default:
	if ((place_meeting(x, y, obj_player)) && state == POINT_STATES.normal){
		
		audio_play_sound(point_type_sound, 2, false, 1, 0, random_range(0.8, 1.2));
		fx_particle(point_type_size);
		state = POINT_STATES.collected;
		time_source_start(ts);
		image_index = 0;
		image_speed = 0;
		obj_battle_manager.add_dance_points(dp_value);
	}
	break;
}
	
if (state == POINT_STATES.collected && can_disappear){
	alpha_changer();

	if alpha <= 0 {
		instance_destroy();
	}
}