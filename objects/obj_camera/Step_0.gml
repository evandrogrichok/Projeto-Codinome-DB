
var final_x = x;
var final_y = y;


if shaking_camera{
	if (shake_change <= 0){
	    shake_dir = irandom(360);
	    shake_change = 2;
	} else {
	    shake_change--;
	}
	
	final_x += lengthdir_x(intensity, shake_dir);
	final_y += lengthdir_y(intensity, shake_dir);
	
	
	if shake_timer > 0{
		shake_timer--;
	} else {
		intensity -= .2;
		if intensity <= 0 {
			shaking_camera = false;
		}
	}
} 



//if keyboard_check_pressed(ord("Y")){
//	fixated_camera = !fixated_camera;
//}

//if global.DEBUG_PLAYER_DRAG{
//x = obj_player.x;
//y = obj_player.y;
//}


//else
//if (!fixated_camera) && !(place_meeting(obj_player.x, obj_player.y, obj_camera_fixated_location)){ //seguir player se nao tiver em um lugar pisando no objpisar e se nao tiver fixada
//	if setup_fixated_cam == true{
//		setup_fixated_cam = false;
//	}
	
//	//if (obj_player.moving){
//	//	cam_x_frontwards = obj_player.mx * camera_x_frontwards_multiplier;
//	//	cam_y_frontwards = obj_player.my * camera_y_frontwards_multiplier;
//	//}
	
	
//	//var cam_target_x = lerp(x, obj_player.x + cam_x_frontwards, spd_camera);
//	//if (cam_target_x > cam_w/2 && cam_target_x < room_width - cam_w/2){x = cam_target_x;}
//	//var cam_target_y = lerp(y, obj_player.y + cam_y_frontwards, spd_camera);
//	//if (cam_target_y > cam_h/2 && cam_target_y < room_height - cam_h/2){y = cam_target_y;}


//} else if (fixated_camera) && !(place_meeting(obj_player.x, obj_player.y, obj_camera_fixated_location)){ // se tiver fixada, a camera fica parada onde ela tava inicialmente
	
//	//if !setup_fixated_cam{
//	//	x_fixated_camera = x
//	//	y_fixated_camera = y
//	//	setup_fixated_cam = true;
//	//}
	
//	//x = lerp(x, x_fixated_camera, spd_camera);
//	//y = lerp(y, y_fixated_camera, spd_camera);


//} else

//if (place_meeting(obj_player.x, obj_player.y, obj_camera_fixated_location)){ // se tiver pisando 
//	//x = lerp(x, obj_camera_fixated_location.x_fixated_custom_camera, spd_camera);
//	//y = lerp(y, obj_camera_fixated_location.y_fixated_custom_camera, spd_camera);
//}









switch (state){
	case CAM_STATES.follow_target:
	
	var target_fx = target.mx * camera_x_frontwards_multiplier;
	var target_fy = target.my * camera_y_frontwards_multiplier;	
	
	if (point_distance(0, 0, target.mx, target.my) > 0){
	cam_x_frontwards = lerp(cam_x_frontwards, target_fx, 0.1);
	cam_y_frontwards = lerp(cam_y_frontwards, target_fy, 0.1);
	}
	
	var cam_target_x = lerp(x, target.x + cam_x_frontwards, spd_camera);
	var cam_target_y = lerp(y, target.y + cam_y_frontwards, spd_camera);
	
	x = clamp(cam_target_x, cam_w/2, room_width - cam_w/2);
	y = clamp(cam_target_y, cam_h/2, room_height - cam_h/2);

	break;
	case CAM_STATES.focus_position:
	
	if (point_distance(x, y, x_fixated_camera, y_fixated_camera) < 0.5) {
	    x = x_fixated_camera;
	    y = y_fixated_camera;
	} else {
		x = lerp(x, x_fixated_camera, spd_camera);
		y = lerp(y, y_fixated_camera, spd_camera);
	}


	break;
	case CAM_STATES.between_targets:
		
	var mid_x = (target1.x + target2.x) / 2;
    var mid_y = (target1.y + target2.y) / 2;

    var _x = lerp(x, mid_x, spd_camera);
    var _y = lerp(y, mid_y, spd_camera);
	
	x = clamp(_x, cam_w/2, room_width - cam_w/2);	
	y = clamp(_y, cam_h/2, room_height - cam_h/2);
	
	break;
}




cam_x = final_x - cam_w / 2;
cam_y = final_y - cam_h / 2;
camera_set_view_pos(view_camera[0], cam_x, cam_y);



for(var i = 0; i < array_length(all_layers_parallax); i++){
	if layer_x_spd[i] > 0{
		layer_x_spd_acc[i] += layer_x_spd[i];
	}
	var _layer = all_layers_parallax[i];
	var _layer_initial_x = x_layers_handle[i];
	layer_x(_layer, _layer_initial_x + cam_x*parallax_factor[i] + layer_x_spd_acc[i]);


}


// coisas pra ve


//if setup_fixated_cam == true{
	//	setup_fixated_cam = false;
	//}
