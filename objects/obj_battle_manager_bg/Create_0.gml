depth = DEPTH.LOGIC_BEHIND



with(obj_battle_manager){

setup_bg = false
bg_index = [0, 0, 0];


enum BACKGROUNDS_BATTLE{
	great_entrance
}

function draw_bg(bg){
	switch(bg){
		case BACKGROUNDS_BATTLE.great_entrance:
			draw_bg_great_entrance();
		break;
	}
}

function draw_bg_great_entrance(){

	bg_speed = [1, 1, 1];
	
	var index = 0;
	
	bg_index[index] = scr_animar_sprite(bg_index[index], bg_speed[index], spr_bg_great_entrance_battle);
	draw_sprite_ext(spr_bg_great_entrance_battle, bg_index[index], obj_camera.x, obj_camera.y, 1, 1, 0, c_white, 1);
	
	index++
	
	bg_index[index] = scr_animar_sprite(bg_index[index], bg_speed[index], spr_bg_great_entrance_battle_light);
	
	gpu_set_blendmode(bm_add)
	draw_sprite(spr_bg_great_entrance_battle_light, bg_index[index], obj_camera.x-1, obj_camera.y + camera_get_view_height(view_camera[0])/2);
	gpu_set_blendmode(bm_normal)
	
	
	if setup_bg{
		return;
	}
	
	setup_bg = true;
	var lay_id = layer_create(240000, "bg_bat");
	layer_x(lay_id, obj_camera.x - camera_get_view_width(view_camera[0])/2)
	layer_y(lay_id, obj_camera.y - camera_get_view_height(view_camera[0])/2)

	layer_hspeed(lay_id, -.05)
	var back_id = layer_background_create(lay_id, spr_bg_great_entrance_battle_bg)
	layer_background_htiled(back_id, true);
	layer_background_vtiled(back_id, true);
	layer_background_speed(back_id, 6);
	
	
	

	
	
	
}

}