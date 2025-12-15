var accept_key =  keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"));
var menu_key =   keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("C"));
var back_key =    keyboard_check_pressed(vk_shift) || keyboard_check_pressed(ord("X"));

var l_keys = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"));
var r_keys = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"));
var u_keys = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
var d_keys = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));

var _opt_changer =  (l_keys) - (r_keys);
var _opt_changer_v = (d_keys) - (u_keys) ;

var inst_gm =					  	    obj_game_manager;
var inventory_length =   array_length(inst_gm.inventory);
var inventory =					   	   inst_gm.inventory;

var i_act_length = array_length(i_options)

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
		var padding_submenu = 10
		var margin_item_boxes = 5;
		var margin_item_names = 5;
		
		var padding_item_names = 10;
		var size_box_items = (w_box/5)*3
		var size_box_info = (w_box/5)*2
		
		draw_sprite_stretched_ext(spr_box, 0, cam_x - w_box/2, cam_y - h_box/2, w_box, h_box, c_white, 1);
	
		var item_box_origin_x = cam_x - w_box/2 + margin_item_boxes
		var item_box_origin_y = cam_y - h_box/2 + margin_item_boxes + opt_height/2 + padding_submenu
		var item_box_height = h_box - margin_item_boxes*2 - opt_height/2 - padding_submenu
		draw_sprite_stretched_ext(spr_box, 0, item_box_origin_x, item_box_origin_y, size_box_items - margin_item_boxes*2, item_box_height, c_white, 1);
		
		var info_box_origin_x = cam_x - w_box/2 + size_box_items
		var info_box_origin_y = cam_y - h_box/2 +margin_item_boxes + opt_height/2 + padding_submenu
		var info_box_height = h_box - margin_item_boxes*2 - opt_height/2 - padding_submenu
		var info_box_width =  size_box_info - margin_item_boxes
		var info_box_unit = info_box_height/5
		draw_sprite_stretched_ext(spr_box, 0, info_box_origin_x, info_box_origin_y, info_box_width, info_box_height, c_white, 1);
	
		
		draw_set_font(fnt_tiny);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		
		var padd_names = 0
		var margins = margin_item_boxes + margin_item_names;


		
		var select_box_h = 14;
		var select_box_adjust = 2; // Usado para organizar a caixinha em volta do texto corretamente. visto que o ponto de origem é bugadinho.
		var y_font_padd = 2; // A fonte usada tem um alinhamento estranho. Esse parametro será usado para deixar os nomes centralizados corretamente.]
		
		for (var i = 0; i < inventory_length; i++){
			
			var item_name = inventory[i].name
			var item_info = inventory[i].info
			var item_type = inventory[i].type
			var h_item_name = string_height(item_name)
			
			var alpha_items = 1 // alpha do texto dos itens
			var col_items = c_white;
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);

			if (opt == i && item_substate == ITEM_SUBSTATES.selecting){
				col_items = highlight_color;
				
				
				//desenhando caixa seleção item. 
				draw_sprite_stretched(spr_seta_txt, selec_box_index, item_box_origin_x + margin_item_names - select_box_adjust, item_box_origin_y + padd_names + margin_item_names - h_item_name/2 - select_box_adjust + y_font_padd, size_box_items - margins * 2 + select_box_adjust, select_box_h);
				
				//desenhando as infos do item selecionado.
				
				//nome do item
				draw_text(info_box_origin_x + info_box_width/2, info_box_origin_y + info_box_unit/2, string(item_name))
				//descricao do item
				draw_text_ext_transformed_color(info_box_origin_x + info_box_width/2, info_box_origin_y + info_box_unit*2 + info_box_unit/2, string(item_info), 6, info_box_width - margin_item_names*2, 1, 1, 0, c_white, c_white, c_white, c_white, 0.6)
				
				//o que o item faz
				draw_text_color(info_box_origin_x + info_box_width/2, info_box_origin_y + info_box_unit*4 + info_box_unit/2, string(inventory[i].properties_description), highlight_color, highlight_color, highlight_color, highlight_color, 1);
				
			} 
			
			//desenhando os nomes dos itens
			
			if item_substate == ITEM_SUBSTATES.confirming{
				if (i == selected_item){
					col_items = highlight_color;
					draw_sprite_stretched(spr_seta_txt, selec_box_index, item_box_origin_x + margin_item_names - select_box_adjust, item_box_origin_y + padd_names + margin_item_names - h_item_name/2 - select_box_adjust + y_font_padd, size_box_items - margins * 2 + select_box_adjust, select_box_h);
				} else {
					alpha_items = 0.6
				}
				
				draw_text(info_box_origin_x + info_box_width/2, info_box_origin_y + info_box_unit/2, string(item_name))
			}
			
			draw_set_halign(fa_left);
			draw_text_color(item_box_origin_x + margin_item_names, item_box_origin_y + padd_names + margin_item_names + y_font_padd, item_name, col_items, col_items, col_items, col_items, alpha_items)
			padd_names += padding_item_names;
		
		}
		
		
		if item_substate == ITEM_SUBSTATES.confirming{
			
			draw_set_halign(fa_center);
			//draw_set_valign(fa_middle);
			
			var padd = -string_height(i_options[0]);
			var padd_increase = 12
				for (var j = 0; j < i_act_length; j++){
					var c_opt_items = c_white
					
					if (j == opt){
					draw_sprite_stretched(spr_seta_txt, selec_box_index, info_box_origin_x, info_box_origin_y + info_box_unit/2 + info_box_unit*2 + padd - select_box_h/2, info_box_width, select_box_h);
					c_opt_items = highlight_color;
					}
				
					draw_text_color(info_box_origin_x + info_box_width/2, info_box_origin_y + info_box_unit/2 + info_box_unit*2 + padd, string(i_options[j]), c_opt_items, c_opt_items, c_opt_items, c_opt_items, 1)
					padd += padd_increase
					
				}
				
			
			draw_text_color(info_box_origin_x + info_box_width/2, info_box_origin_y + info_box_unit*4 + info_box_unit/2, string(inventory[selected_item].properties_description), highlight_color, highlight_color, highlight_color, highlight_color, 1);
			
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
		}
		
		draw_player_hud();
		draw_options(1, state);
		draw_item_types_submenu(selected_item_type, state);
	
	draw_set_valign(fa_top);
	break;
	

}




