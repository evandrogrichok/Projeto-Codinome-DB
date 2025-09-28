if shaking_camera{
	var shake_x = 0
	var shake_y = 0
	var shake_dir = irandom(360)

	shake_x = x + lengthdir_x(intensity, shake_dir);
	shake_y = y + lengthdir_y(intensity, shake_dir);
	
	x = shake_x 
	y = shake_y
	if intensity > 0{
	intensity -= .05
	} else {
	shaking_camera = false
	}
} 

if keyboard_check_pressed(ord("Y")){
	fixated_camera = !fixated_camera;
}

if (cam_moving == false && !fixated_camera){
x = lerp(x, obj_player.x, 0.3);
y = lerp(y, obj_player.y, 0.3);

cutscene_dest_x_cam = x;
cutscene_dest_y_cam = y;
cutscene_y_vel_cam = undefined;
cutscene_x_vel_cam = undefined;
}


else
	if (cam_moving) && !fixated_camera{
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
} else
if (fixated_camera){

}


cam_x = x - camera_get_view_width(view_camera[0]) / 2;
cam_y = y - camera_get_view_height(view_camera[0]) / 2;
camera_set_view_pos(view_camera[0], cam_x, cam_y);