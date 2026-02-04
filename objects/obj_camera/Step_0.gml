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

if global.DEBUG_PLAYER_DRAG{
x = obj_player.x
y = obj_player.y
}
else
if (!fixated_camera) && !(place_meeting(obj_player.x, obj_player.y, obj_camera_fixated_location)){
	if setup_fixated_cam == true{
		setup_fixated_cam = false;
	}
	
	if (obj_player.moving){
		cam_x_frontwards = obj_player.mx * camera_x_frontwards_multiplier;
		cam_y_frontwards = obj_player.my * camera_y_frontwards_multiplier;
	}
	
	
	var cam_target_x = lerp(x, obj_player.x + cam_x_frontwards, spd_camera);
	if (cam_target_x > cam_w/2 && cam_target_x < room_width - cam_w/2){x = cam_target_x;}
	var cam_target_y = lerp(y, obj_player.y + cam_y_frontwards, spd_camera);
	if (cam_target_y > cam_h/2 && cam_target_y < room_height - cam_h/2){y = cam_target_y;}


} else if (fixated_camera) && !(place_meeting(obj_player.x, obj_player.y, obj_camera_fixated_location)){
	
	if !setup_fixated_cam{
		x_fixated_camera = x
		y_fixated_camera = y
		setup_fixated_cam = true;
	}
	
	x = lerp(x, x_fixated_camera, spd_camera);
	y = lerp(y, y_fixated_camera, spd_camera);


} else

if (place_meeting(obj_player.x, obj_player.y, obj_camera_fixated_location)){
	x = lerp(x, obj_camera_fixated_location.x_fixated_custom_camera, spd_camera);
	y = lerp(y, obj_camera_fixated_location.y_fixated_custom_camera, spd_camera);
}

cam_x = x - camera_get_view_width(view_camera[0]) / 2;
cam_y = y - camera_get_view_height(view_camera[0]) / 2;

camera_set_view_pos(view_camera[0], cam_x, cam_y);



for(var i = 0; i < array_length(all_layers_parallax); i++){
	if layer_x_spd[i] > 0{
		layer_x_spd_acc[i] += layer_x_spd[i];
	}
	var _layer = all_layers_parallax[i];
	var _layer_initial_x = x_layers_handle[i];
	layer_x(_layer, _layer_initial_x + cam_x*parallax_factor[i] + layer_x_spd_acc[i]);


}


