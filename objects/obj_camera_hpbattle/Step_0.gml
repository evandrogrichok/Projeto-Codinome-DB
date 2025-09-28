if (cam_moving == false){
x = lerp(x, obj_playerhope_hb.x, 0.3);
y = lerp(y, obj_playerhope_hb.y, 0.3);
cutscene_dest_x_cam = x;
cutscene_dest_y_cam = y;

cutscene_y_vel_cam = undefined;
cutscene_x_vel_cam = undefined;
}


else {
	if cutscene_dest_y_cam < y{
		y -= cutscene_y_vel_cam;
	} else
	if cutscene_dest_y_cam > y{
		y += cutscene_y_vel_cam;
	}
	
	if cutscene_dest_x_cam < x{
		x -= cutscene_x_vel_cam;
	} else
	if cutscene_dest_x_cam > x{
		x += cutscene_x_vel_cam;
	}
	
	if !instance_exists(obj_cutscene_manager){
		y = obj_player.y;
		x = obj_player.x;
		cam_moving = false;
		
	}
}



cam_x = x - camera_get_view_width(view_camera[0]) / 2;
cam_y = y - camera_get_view_height(view_camera[0]) / 2;
camera_set_view_pos(view_camera[0], cam_x, cam_y);