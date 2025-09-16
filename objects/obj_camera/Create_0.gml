cam_moving = false;
fixated_camera = false;
intensity = 0
time = 0
shaking_camera = false;

x = obj_player.x
y = obj_player.y

cutscene_dest_x_cam = x;
cutscene_dest_y_cam = y;

cutscene_y_vel_cam = noone;
cutscene_x_vel_cam = noone;

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

function cam_shake(_int, _time){
	intensity = _int
	time = _time
	shaking_camera = true;
}



