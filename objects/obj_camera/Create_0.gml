cam_moving = false;
fixated_camera = false;
intensity = 0
shake_timer = 0
shaking_camera = false;

x = obj_player.x
y = obj_player.y


move_speed = 0;

spd_camera_default = 0.1;
spd_camera = spd_camera_default;


old_x = x;
old_y = y;

function cam_shake(_int, _time){
	intensity = _int
	shake_timer = _time
	shaking_camera = true;
}

setup_fixated_cam = false;
x_fixated_camera = 0;
y_fixated_camera = 0;



