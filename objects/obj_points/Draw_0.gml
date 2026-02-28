

switch (point_type){
	case POINT_TYPES.tiny:
	draw_sprite_ext(sprite_index, image_index, x, y + sin(global.sin_t_points/10)*.5, 1, 1, 0 + sin(global.sin_t_points/20)*5, c_white, alpha);
	if (state == POINT_STATES.collected){
		 fx_pickup()
	}
	break;
	case POINT_TYPES.big:
	draw_sprite_ext(sprite_index, image_index, x, y + sin(global.sin_t_points/10)*.5, 1, 1, 0 + sin(global.sin_t_points/20)*5, c_white, alpha);
		if (state == POINT_STATES.collected){
		 fx_pickup()
	}
	break;
	case POINT_TYPES.breakable:
	draw_sprite_ext(sprite_index, image_index, x, y + sin(global.sin_t_points/10)*.5, 1, 1, 0 + sin(global.sin_t_points/20)*5, c_white, alpha);
	break;
}