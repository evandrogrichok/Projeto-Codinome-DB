

if ((y < obj_player.y + y_camera_tolerance &&  y > obj_player.y)
&& (x > obj_player.x - x_camera_tolerance
&& x < obj_player.x + x_camera_tolerance)){
	alpha_target = 0.3;
} else{
	alpha_target = 1;
}

alpha = lerp (alpha, alpha_target, 0.2)
