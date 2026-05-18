var inside = place_meeting(x, y, obj_player);

if (was_inside && !inside){
	obj_camera.set_follow_target(obj_player);
}

if (!was_inside && inside){
	obj_camera.set_focus_position(x_fixated_custom_camera, y_fixated_custom_camera);
}


was_inside = inside;
