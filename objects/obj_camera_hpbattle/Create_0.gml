cam_moving = false;

x = obj_playerhope_hb.x
y = obj_playerhope_hb.y

cutscene_dest_x_cam = x;
cutscene_dest_y_cam = y;

cutscene_y_vel_cam = undefined;
cutscene_x_vel_cam = undefined;

move_speed = 0;

old_x = x;
old_y = y;

function camera_move_to(_axis, _destination, _speed){
	
	if (_axis == "y"){
			cutscene_dest_y_cam += _destination;
			cutscene_y_vel_cam = _speed;
	}
	if (_axis == "x"){
			cutscene_dest_x_cam += _destination;
			cutscene_x_vel_cam = _speed;
	}
	cam_moving = true;
}