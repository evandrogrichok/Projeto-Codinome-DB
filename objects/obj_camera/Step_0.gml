if shaking_camera{
	spd_camera = 1;
	
	var shake_x = 0
	var shake_y = 0
	var shake_dir = irandom(360)

	shake_x = x + lengthdir_x(intensity, shake_dir);
	shake_y = y + lengthdir_y(intensity, shake_dir);
	
	x = shake_x 
	y = shake_y
	
	
	
	if shake_timer > 0{
	shake_timer--;
	} else {
		intensity -= .2;
		spd_camera = spd_camera_default;
		if intensity <= 0 {
			shaking_camera = false
		}
	}


} 



if keyboard_check_pressed(ord("Y")){
	fixated_camera = !fixated_camera;
}

if (!fixated_camera){
	if setup_fixated_cam == true{
		setup_fixated_cam = false;
	}
	
	x = lerp(x, obj_player.x, spd_camera);
	y = lerp(y, obj_player.y, spd_camera);

} else {
	
	if !setup_fixated_cam{
		x_fixated_camera = x
		y_fixated_camera = y
		setup_fixated_cam = true;
	}
	
	x = lerp(x, x_fixated_camera, spd_camera);
	y = lerp(y, y_fixated_camera, spd_camera);


}


cam_x = x - camera_get_view_width(view_camera[0]) / 2;
cam_y = y - camera_get_view_height(view_camera[0]) / 2;

camera_set_view_pos(view_camera[0], cam_x, cam_y);

//if obj_player.dashing == true{
//	spd_camera = lerp(spd_camera, 1, 0.2);
//} else {
//	spd_camera = lerp(spd_camera, spd_camera_default, 0.2)
//}
