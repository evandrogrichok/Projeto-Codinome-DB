var accept_key =  keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));
var menu_key =   keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("C"));
var back_key =    keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("X"));

var l_keys = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"));
var r_keys = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"));
var u_keys = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
var d_keys = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));

var _opt_changer =  (l_keys) - (r_keys);
var _opt_changer_v = (d_keys) - (u_keys) ;


var inventory =					   	   inst_gm.inventory;



var cam_x = obj_camera.x;
var cam_y = obj_camera.y;


var ptxt =0

//draw_text_ext_transformed(cam_x, cam_y + ptxt- cam_h/2 +5, "state = " + string(state), 3, 4000,0.5,0.5,0);
//ptxt += 5;
//draw_text_ext_transformed(cam_x, cam_y + ptxt -  cam_h/2 +5, "opt = " + string(opt), 3, 4000,0.5,0.5,0);
//ptxt += 5;
//draw_text_ext_transformed(cam_x, cam_y + ptxt -  cam_h/2 +5, "draw_move = " + string(slide_move), 3, 4000,0.5,0.5,0);
//ptxt += 5;
//draw_text_ext_transformed(cam_x, cam_y + ptxt -  cam_h/2 +5, "draw_move = " + string(slide_default_value), 3, 4000,0.5,0.5,0);


//can_select = true;







switch(state){
	case MENU_STATES.main_menu:
	
	//DESENHAR FUNDO CAIXA

	
	draw_sprite_stretched_ext(spr_box, 0, cam_x - w_box/2, cam_y - h_box/2, w_box, h_box, c_white, 1);
	//desenhar opções
	draw_options(opt, state);
	
	break;
	
	case MENU_STATES.item_types_menu:
	
	
	draw_sprite_stretched_ext(spr_box, 0, cam_x - w_box/2, cam_y - h_box/2, w_box, h_box, c_white, 1);
	draw_options(1, state);
	
	draw_item_types_submenu(opt, state);
	draw_player_hud();
	
	break;
	
	case MENU_STATES.item_menu:
		
		item_box_origin_x = cam_x - w_box/2 + margin_item_boxes;
		item_box_origin_y = cam_y - h_box/2 + margin_item_boxes + opt_height/2 + padding_submenu
		
		info_box_origin_x = cam_x - w_box/2 + size_box_items
		info_box_origin_y = cam_y - h_box/2 +margin_item_boxes + opt_height/2 + padding_submenu
		info_box_height = h_box - margin_item_boxes*2 - opt_height/2 - padding_submenu
		info_box_unit = info_box_height/5
		
		draw_sprite_stretched_ext(spr_box, 0, cam_x - w_box/2, cam_y - h_box/2, w_box, h_box, c_white, 1);
		draw_sprite_stretched_ext(spr_box, 0, item_box_origin_x, item_box_origin_y, size_box_items - margin_item_boxes*2, item_box_height, c_white, 1);
		draw_sprite_stretched_ext(spr_box, 0, info_box_origin_x, info_box_origin_y, info_box_width, info_box_height, c_white, 1);
	
		
		draw_set_font(fnt_tiny);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		
		
		drawing_item_list();
		
		draw_player_hud();
		draw_options(1, state);
		draw_item_types_submenu(selected_item_type, state);

		
	draw_set_valign(fa_top);
	break;
	
	
	case MENU_STATES.item_menu_battle:
	
		y_position_battle_correction = 30;
		margin_battle_item_list = 10;
		
		item_box_origin_x = cam_x - w_box/2 + margin_item_boxes;
		item_box_origin_y = cam_y - h_box/2 + margin_battle_item_list/2 - y_position_battle_correction;
		item_box_height = h_box - margin_battle_item_list;
		
		info_box_origin_x = cam_x - w_box/2 + size_box_items
		info_box_origin_y = cam_y - h_box/2 + margin_battle_item_list/2 - y_position_battle_correction;
		info_box_height = h_box - margin_battle_item_list;
		info_box_unit = info_box_height/5
		x_item_button_correction = 135;
		
		draw_sprite_stretched_ext(spr_black, 0, cam_x - cam_w/2, cam_y - cam_h/2, cam_w, cam_h, c_white, 0.5);
		draw_sprite_stretched_ext(spr_box, 0, cam_x - w_box/2, cam_y - h_box/2 - y_position_battle_correction, w_box, h_box, c_white, 1);
		draw_sprite_stretched_ext(spr_box, 0, item_box_origin_x, item_box_origin_y, size_box_items - margin_item_boxes*2, item_box_height, c_white, 1);
		draw_sprite_stretched_ext(spr_box, 0, info_box_origin_x, info_box_origin_y, info_box_width, info_box_height, c_white, 1);
		draw_sprite_ext(spr_box_baloon_triangle, 0, cam_x - w_box/2 + x_item_button_correction, cam_y + h_box/2 - y_position_battle_correction,1, 1, 0, c_white, 1);
	
		
		draw_set_font(fnt_tiny);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		
		
		drawing_item_list();
		
	
	break;

}




