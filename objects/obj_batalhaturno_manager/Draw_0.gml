//depth = -99999;
myimage_index = scr_animar_sprite(myimage_index, myimage_speed, spr_player_portrait);



//draw_text(x,y, opt)
//draw_text(x,y+20, arrow_timer);

var _inst_player = obj_player;

var opt_height = sprite_get_height(spr_button_item_pt)

//tamanho do visor da camera
//var cam_w = camera_get_view_width(view_camera[0]);
//var cam_h = camera_get_view_height(view_camera[0]);
//localizacao do obj cam
var cam_x = obj_camera.x
var cam_y = obj_camera.y
//tamanho dos sprites dos botoes, para calculos de distancia e tudo

//tamanho do hudzinho de vida

var _padding = 0
var _margin = 5
var portrait_x = (cam_x - cam_w/2 + _margin) + 3
var portrait_y = (cam_y + cam_h/2 - sprite_player_hud_height - 5) + 3
var tam_hud = sprite_get_width(spr_player_hud)

var lifebar_x = (cam_x - cam_w/2 + _margin) + 22
var lifebar_y = (cam_y + cam_h/2 - sprite_player_hud_height - 5) + 11


//parte >>ESQUERDA<< do alvo setas
var arrow_target_x = cam_x;
var increase_target_size = 0;
//desenhando setas

var arrow_x_distance = 0; 
var arrows_alpha = 1;

//INIMIGOS
var enemy_count = array_length(inimigos_combo);
//var alive_enemies_count = array_length(inimigos_vivos);

var u_keys = global.UP_KEY;
var d_keys = global.DOWN_KEY;
var vertical_opt_changer = (d_keys) - (u_keys) ;

draw_set_font(fnt_tiny);


//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "opt: " + string(opt), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "last opt: " + string(last_opt), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "shake_level: " + string(shake_level), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "inis: " + string(inimigos_combo), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "inis vivo: " + string(inimigos_vivos), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "wait timer: " + string(wait_timer), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "level: " + string(_inst_player.values.level), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "exp: " + string(_inst_player.values.xp), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "dist_seta: " + string(dist_seta_alvo), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "draw_from: " + string(inventory_draw_from), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "dir: " + string(push_inventory_dir), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "enemy_timer: " + string(enemy_attack_timer), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "enemy_duration: " + string(enemy_attack_duration), 0.5, 0.5, 0)
//padd++;


draw_set_font(fnt_main);




//draw_rectangle(arrow_target_x, cam_y,arrow_target_x, cam_y+20, 0)
//draw_rectangle(x_lim_setas-5, 0,x_lim_setas, 300, 0)
//draw_line(cam_x - cam_w/2, cam_y, cam_x + cam_w/2, cam_y);
//draw_line(cam_x, cam_y - cam_h/2, cam_x, cam_y + cam_h/2);



draw_sprite_ext(spr_vignette, 0, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), 1, 1, 0, c_white, alpha_vignette);


if state == BATTLE_STATES.arrow_pattern{
	
	
	
	for(var k = 0; k < array_length(keys); k++){
		var key = keys[k]

		if keyboard_check(key[0]){
		increase_target_size = 5;
		}
	}

	var unit_size_sprite =  1/sprite_get_width(spr_alvo_setas);
	
	
	//sprite_set_offset(spr_alvo_setas, (target_size - increase_target_size)/2, (target_size - increase_target_size)/2)
	
	draw_sprite_ext(spr_alvo_setas, 0,  arrow_target_x, target_size/2 + cam_y-target_size/2,  unit_size_sprite * (target_size + increase_target_size), unit_size_sprite * (target_size + increase_target_size), target_rot_effect, c_white, 1)
	
	var quant_setas = array_length(arrow_pat)
	var start = arrow_to_draw_from
	
	for (var i = 0; i < quant_setas; i++){
		
		
		// se o i for igual ao arrow to draw from dai ele atribui o cloosest
		
	
	if arrow_to_draw_from <= i{
		
		switch arrow_pat[i]{
		
			case "right":
				draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, (cam_x) + individual_arrow_distance[i], cam_y, 1, 1, 0, c_white, arrows_alpha);
					if arrow_to_draw_from == i{
						determine_closest_arrow_xy_pos(cam_x, cam_y, individual_arrow_distance[i], 0);
					}
			break;
			case "left":
				draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, (cam_x) - individual_arrow_distance[i], cam_y, 1, 1, 0, c_white, arrows_alpha);
					if arrow_to_draw_from == i{
						determine_closest_arrow_xy_pos(cam_x, cam_y, -individual_arrow_distance[i], 0);
					}
			break;
			
			case "up":
				draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, cam_x, cam_y - individual_arrow_distance[i], 1, 1, 0, c_white, arrows_alpha);
					if arrow_to_draw_from == i{
						determine_closest_arrow_xy_pos(cam_x, cam_y, 0, -individual_arrow_distance[i]);
					}
			
			break;
			
			case "down":
				draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"), 0, cam_x, cam_y + individual_arrow_distance[i], 1, 1, 0, c_white, arrows_alpha);
				if arrow_to_draw_from == i{
						determine_closest_arrow_xy_pos(cam_x, cam_y, 0, +individual_arrow_distance[i]);
				}
			break;
			
		}
		
		arrows_alpha -= 1/quant_setas;
		}
		arrow_x_distance += sprite_get_width(spr_seta_up) + padding_between_arrows;	
		individual_arrow_distance[i] -= vel_setas		
	}
	
	local_seta_mais_proxima = individual_arrow_distance[arrow_to_draw_from];
	//draw_rectangle(closest_arrow_x,closest_arrow_y,closest_arrow_x+2, closest_arrow_y+2, false)

}


//draw_rectangle(seta, 0, local_seta_mais_proxima+(sprite_get_width(spr_seta_up)), 300, 0)


//DESENHANDO EFEITO DE FEEDBACK NAS SETAS
if arrow_feedback_draw[0] != ""{
	if arrow_feedback_draw[1] < param_acertar[1][0]{
		draw_sprite_ext(asset_get_index($"spr_seta_gray_{arrow_feedback_draw[0]}"), 0, arrow_target_x, cam_y, 1, 1, 0, cor_texto_acerto, alpha_feedback);
		
		if alpha_feedback > 0{
			alpha_feedback -= 0.1
			
		} else {
			arrow_feedback_draw = ["","",""]
		}
	} else {
		draw_sprite_ext(asset_get_index($"spr_seta_gray_{arrow_feedback_draw[0]}"), 0, last_closest_arrow_x, last_closest_arrow_y, 1, 1, 0, cor_texto_acerto, alpha_feedback);
		if alpha_feedback > 0{
			alpha_feedback -= 0.1
			
		} else {
			arrow_feedback_draw = ["","",""]
		}
	}
}

draw_sprite_stretched_ext(spr_black, 0, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), cam_w, cam_w, c_white, black_bg_color_alpha);

//DESENHANDO O INIMIGO
seta_index = scr_animar_sprite(seta_index, seta_speed, spr_selec_ini); 
for(var i = 0; i < enemy_count; i++){
		
		var max_hp = parametros_inimigos[i].hp
		var nome = parametros_inimigos[i].enemy_name
		var sprite_ini = parametros_inimigos[i].sprite
		sprite_ini = asset_get_index(sprite_ini)
	
		var off_y_arrow = 17
	 
		var sprite_ini_dmg = parametros_inimigos[i].sprite_dmg
		sprite_ini_dmg = asset_get_index(sprite_ini_dmg)
	
		var sprite_ini_atk = parametros_inimigos[i].sprite_atk
		sprite_ini_atk = asset_get_index(sprite_ini_atk)
		
		var sprite_ini_pur = parametros_inimigos[i].sprite_pur
		sprite_ini_pur = asset_get_index(sprite_ini_pur)
		
		if (hp_inimigos[i] <= 0){
		if enemies_draw_defeat_state[i] == 0{
			draw_away = lerp(draw_away, 20, 0.01);
			fade_away += -0.05;
			var vel_draw_away = 5;
			
			var x_ini = x_inimigo[i] + vel_draw_away * draw_away;
			var y_ini = y_inimigo[i] - vel_draw_away - sin(sin_t*3.5) * 5;
			
			part_emitter_region(part_system_stars, part_emitter_stars, x_ini -10, x_ini +10, y_ini -10, y_ini +10, ps_shape_rectangle, ps_distr_linear);
			part_emitter_burst(part_system_stars, part_emitter_stars, 0, 20);
			
			draw_sprite_ext(sprite_ini_pur, enemies_index[i], x_ini, y_ini, 1, 1, 0, c_white, fade_away);
			
			if fade_away <= 0{
				enemies_draw_defeat_state[i] = 1;
				draw_away = 0;
				fade_away = 2;
				 
				}
			}
			
			continue;
		}
		


	if hp_inimigos[i] >= 0{
		if state != BATTLE_STATES.enemy_turn{
			enemies_index[i] = scr_animar_sprite(enemies_index[i], enemies_speed[i], sprite_ini);
		}
		

	
		if enemy_count == 1{
		x_inimigo[i] = cam_x + cam_w/3
		y_inimigo[i] = cam_y - height_textbox_battle/2;
		} else {
			
		var x_padding = 0
		
		if (i%2 != 0 && enemy_count>2){
		x_padding = 20;
		}
		x_inimigo[i] = cam_x + cam_w/3 + x_padding;
		var padding = 10;
		var first_sprite_height = sprite_get_height(asset_get_index(parametros_inimigos[0].sprite))
		var available_y_space = cam_h - height_textbox_battle - first_sprite_height;
		
		var y_distance = ( available_y_space/enemy_count)*i;
		
		y_inimigo[i] =	(cam_y - cam_h/2) + available_y_space/(enemy_count+2) + y_distance + first_sprite_height - opt_height;

		}
	
		var larg_barra_hp = 25;
		var larg_out_hp = larg_barra_hp + 2;
		var altura_barra_hp = 3;
		var altura_out_hp = altura_barra_hp+2;
	
		if (alpha_barra_ini > 0){
			alpha_barra_ini -= 0.01;
	
		}
	
		draw_sprite_stretched_ext(spr_outline_enemy_hb,0, x_inimigo[i] - larg_out_hp/2 - larg_barra_hp, y_inimigo[i] - sprite_get_height(sprite_ini) - altura_out_hp+1, larg_out_hp, altura_out_hp, c_white,alpha_barra_ini)
		draw_sprite_stretched_ext(spr_healthbar_enemy,0, x_inimigo[i] - larg_barra_hp/2 - larg_barra_hp, y_inimigo[i] - sprite_get_height(sprite_ini) - altura_barra_hp, (hp_inimigos[i] / max_hp)*larg_barra_hp, altura_barra_hp, #54003e,alpha_barra_ini)
	
		if state == BATTLE_STATES.enemy_turn{
			
			enemies_index[i] = scr_animar_sprite(enemies_index[i], enemies_speed[i], sprite_ini_atk);
			scr_shader_outline(sprite_ini_atk, enemies_index[i], 207, 119, 255, black_bg_color_alpha);
			draw_sprite_ext(sprite_ini_atk, enemies_index[i], x_inimigo[i], y_inimigo[i], 1, 1, 0, c_white, 1);
			shader_reset();
		} else
		if shake_level > 0 && i == opt{
			var shake_x = 0
			var shake_y = 0
			var shake_dir = irandom(360)

			shake_x = lengthdir_x(shake_level, shake_dir);
			shake_y = lengthdir_y(shake_level, shake_dir);
			draw_sprite_ext(sprite_ini_dmg, 0, x_inimigo[i] + shake_x, y_inimigo[i] + shake_y, 1, 1, 0, c_white, 1);
			shake_level -= 0.1
		} else {
	
		if state == BATTLE_STATES.select_enemy{
	
		
			if (i == opt){
			scr_shader_outline(sprite_ini, enemies_index[i], 255, 219, 103, clamp(sin(sin_t*3)/5 + 0.8, 0, 1));

			draw_sprite_ext(sprite_ini, enemies_index[i], x_inimigo[opt], y_inimigo[opt], 1, 1, 0, c_yellow, 0);	

			shader_reset();

		  	draw_sprite_ext(spr_selec_ini, seta_index, x_inimigo[opt] - sprite_get_width(spr_selec_ini)/2, y_inimigo[opt] - ini_sprites_altura[opt] - off_y_arrow, 1, 1, 0, c_white, 1);			
			}
		alpha_barra_ini = 1;

		}
	
		draw_sprite_ext(sprite_ini, enemies_index[i], x_inimigo[i], y_inimigo[i], 1, 1, 0, c_white, 1);
	
		}
	}
}




// DESENHANDO O TEXTO DE ACERTO DAS SETAS
if text_to_draw[0] != ""{
	if text_to_draw[1] == "qualidade_acerto"{
		draw_set_halign(fa_center)
		draw_text_color(x_texto_acerto, cam_y - target_size - 10, text_to_draw[0],cor_texto_acerto,cor_texto_acerto,cor_texto_acerto,cor_texto_acerto, alpha_txt_acerto)
		draw_set_halign(fa_left)
	
		if alpha_txt_acerto > 0{
			alpha_txt_acerto -= 0.01;
			x_texto_acerto = x_texto_acerto  + (dest_x_texto_acerto - x_texto_acerto) * 0.1;
	
		} else {
			text_to_draw = ["",""]
		}
	}
	
	
	if text_to_draw[1] == "dano_no_inimigo"{
		draw_set_halign(fa_center)
		draw_set_font(fnt_bold)
		draw_text_color(x_texto_acerto, y_inimigo[opt] - sin(x_texto_acerto/10) - 50, text_to_draw[0],c_yellow,c_yellow,c_yellow,c_yellow,alpha_txt_acerto)
		draw_set_font(fnt_main)
		draw_set_halign(fa_left)
	
		if alpha_txt_acerto > 0{
			alpha_txt_acerto -= 0.01;
			x_texto_acerto = x_texto_acerto  + (dest_x_texto_acerto - x_texto_acerto) * 0.1;
	
		} else {
			text_to_draw = ["",""]
		}
	
	}
}
//local_seta_mais_proxima = (spawn_setas + (sprite_get_width(spr_seta_up) + padding_between_arrows) * arrow_to_draw_from)-(sprite_get_width(spr_seta_up)/2)



if (mostrar_limites_de_movimentacao){
	if fade_in_alpha < 0.5{
		fade_in_alpha += 0.05;
	}
	var current_box = variable_struct_get(caixa_valores, caixa_mov_pat)
	var altura_caixa = variable_struct_get(current_box, "caixa_altura");
	var largura_caixa = variable_struct_get(current_box, "caixa_tamanho");
	var pos_x = variable_struct_get(current_box, "caixa_posicao_x");
	var pos_y = variable_struct_get(current_box, "caixa_posicao_y");
	var altura_gradiente = sprite_get_height(spr_gradient_barriers)
	var w_bbox_p = sprite_get_bbox_right(_inst_player.sprite_index) - sprite_get_bbox_left(_inst_player.sprite_index);
	var h_bbox_p = sprite_get_bbox_bottom(_inst_player.sprite_index) - sprite_get_bbox_top(_inst_player.sprite_index);
	
	if (state == BATTLE_STATES.wait_time){
		
		draw_sprite_stretched_ext(spr_barriers, 0, pos_x - largura_caixa/2, pos_y - altura_caixa/2, largura_caixa, altura_caixa, c_white, clamp(sin(sin_t * 3)/2 + fade_in_alpha, 0, 1));
	
	} else 
	if (state == BATTLE_STATES.enemy_turn){
		barrier_index = scr_animar_sprite(barrier_index, barrier_speed, spr_gradient_barriers);
		
		draw_sprite_stretched_ext(spr_barriers, 0, pos_x - largura_caixa/2, pos_y - altura_caixa/2, largura_caixa, altura_caixa, c_white, .8);
		
		draw_sprite_stretched_ext(spr_gradient_barriers, barrier_index, pos_x - largura_caixa/2, pos_y - altura_caixa/2 - altura_gradiente +3, largura_caixa, altura_gradiente, c_white, fade_in_alpha*1.5);	
		draw_sprite_stretched_ext(spr_gradient_barriers_bottom, barrier_index, pos_x - largura_caixa/2, pos_y + altura_caixa/2 - altura_gradiente, largura_caixa, altura_gradiente, c_white, fade_in_alpha*1.5);
		
	}
}



//draw_text(x+40,y, dist_seta_alvo)
//desenhando vida 


		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		draw_set_font(fnt_tiny);
		
		//var cam_x = obj_camera.x;
		//var cam_y = obj_camera.y;		
	
		var player_hud_x = cam_x - cam_w/2 + _margin;
		var player_hud_y = cam_y + cam_h/2 - player_hud_height - _margin - height_textbox_battle;
				
		var hud_padding = 3;
		var hud_margin_y = 2;
				
		var hp_x_offset = 16;
		var hp_count_x_offset = hp_x_offset - 10;
		var portrait_offset = 3;
				
		var hp_bar_size = 43;
		var hp_bar_height = 7;
				
		var hp_bar_y_offset = 11
		var hp_bar_x_correction = 1;
			
				

		
		draw_sprite(spr_player_hud, 0, player_hud_x, player_hud_y);
		draw_sprite(spr_player_portrait, myimage_index, player_hud_x + portrait_offset, player_hud_y + portrait_offset);
				
				
		draw_text(player_hud_x + portrait_offset + portrait_width + hud_padding, player_hud_y + portrait_offset + hud_margin_y, "Cael");
		draw_text_color(player_hud_x - portrait_offset + player_hud_width - hp_x_offset, player_hud_y + portrait_offset + hud_margin_y, "hp:", c_white, c_white, c_white, c_white, medium_alpha);
		draw_text_color(player_hud_x - portrait_offset + player_hud_width - hp_count_x_offset, player_hud_y + portrait_offset + hud_margin_y, string(obj_player.values.hp), highlight_color, highlight_color, highlight_color, highlight_color, 1);
				
		draw_sprite_stretched(spr_healthbar, 0, player_hud_x + portrait_width + portrait_offset + hud_padding + hp_bar_x_correction, player_hud_y + hp_bar_y_offset,(obj_player.values.hp / obj_player.values.max_hp)*hp_bar_size, hp_bar_height)
				
		draw_set_valign(fa_top);
		draw_set_font(fnt_main);
		

//var hp_bar_size = 43;
//var hp_bar_height = 7;

//draw_sprite_ext(spr_player_hud, b_subimage[0], cam_x - cam_w/2 + _margin, cam_y + cam_h/2 - sprite_player_hud_height - 5,1,1,0,c_white,1)
//draw_sprite(spr_player_portrait,myimage_index,portrait_x,portrait_y)
//draw_sprite_stretched(spr_healthbar,0,lifebar_x,lifebar_y, (_inst_player.values.hp / max_health)*hp_bar_size, hp_bar_height)

//draw_set_font(fnt_tiny)
//draw_text(portrait_x + 18, portrait_y-3,"Cael")
//draw_text_colour(portrait_x + sprite_get_width(spr_player_hud) - 23, portrait_y-3,"hp:",c_white,c_white,c_white,c_white,.5)
//draw_text_colour(portrait_x + sprite_get_width(spr_player_hud) - 13, portrait_y-3,string(_inst_player.values.hp),c_yellow,c_yellow,c_yellow,c_yellow,1)
//draw_set_font(fnt_main)


if state == BATTLE_STATES.item_menu {
	
	var inst_gm = obj_game_manager;
	
	var width_inventory = 100;
	var height_inventory = 55;
	
	
	
	var padding_opt_inventory = 2;
	var y_offset = cam_h/2 - height_inventory - _margin - opt_height
	var dist_item_center = 50;
	
	var x_inventory = cam_x + dist_item_center - width_inventory/2 
	var y_inventory = cam_y + y_offset - padding_opt_inventory
	
	draw_sprite_stretched(spr_box, 0, x_inventory, y_inventory, width_inventory, height_inventory);
	
	var padding_text = 0;
	var padding_text_increase = 10;
	var margin_text = 2
	
	draw_set_font(fnt_tiny);
	
	var width_selection_box = width_inventory/2
	var heigth_selection_box = 12
	
	var x_text =  x_inventory + margin_text * 2
	var y_text_info = y_inventory + height_inventory / 2 
	var y_text_options_question = y_inventory + (height_inventory / 5) * 2
	var y_text_options = y_inventory + (height_inventory / 5) * 4
	
	
	var items_total_height = 0;
	var iteration_num = 0
	var item_amount = array_length(inst_gm.inventory);
	inventory_arrow_index = scr_animar_sprite(inventory_arrow_index, inventory_arrow_speed, spr_arrow_up);
	
	for (var i = 0 + inventory_draw_from; i < array_length(inst_gm.inventory); i++){
		iteration_num++;
		
		var item = inst_gm.inventory[i]
		var item_name = item.name;
	
		var y_text = y_inventory + padding_text + margin_text;
		
		var correction_x_selection = 1
		var color_text = c_white
		var alpha_text = 1;
		if (inventory_draw_from > 0 && iteration_num == 1){	
			draw_sprite(spr_arrow_up, inventory_arrow_index, x_text, y_text);
			padding_text += padding_text_increase;
			continue;
		}
		
		if !draw_inventory_actions {
			if (i - inventory_draw_from == opt - inventory_draw_from){
				draw_sprite_stretched(spr_seta_txt, 0, x_text - correction_x_selection, y_text - correction_x_selection * 1.5, width_selection_box - margin_text*2, heigth_selection_box);
				color_text = highlight_color;
				var item_info = item.properties_description
			
				//desenhando info do item
				draw_set_valign(fa_middle);
				draw_set_halign(fa_center);
				var y_correction = 3;
				draw_text_ext_color(x_inventory + (width_inventory/4) * 3, y_text_info - y_correction, item_info, 6, width_inventory/2 - margin_text*2, c_white, c_white, c_white, c_white, medium_alpha)
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
			}
		} else {
			alpha_text = medium_alpha;
			if (i - inventory_draw_from) == (selected_item - inventory_draw_from){
				alpha_text = 1;
				color_text = highlight_color;
				draw_sprite_stretched(spr_seta_txt, 0, x_text - correction_x_selection, y_text - correction_x_selection * 1.5, width_selection_box - margin_text*2, heigth_selection_box);
				
				draw_set_valign(fa_middle);
				draw_set_halign(fa_center);
				var y_correction = 3;
				var padding = -string_height(inventory_options[0]);
				var padding_increase = 12;
				draw_text_ext_color(x_inventory + (width_inventory/4) * 3, y_text_options_question - y_correction + padding, "Usar " + string(inst_gm.inventory[selected_item].name) + "?", 6, width_inventory/2 - margin_text*2, c_white, c_white, c_white, c_white, alpha_text)
				for (var j = 0; j < array_length(inventory_options); j++){
					draw_text_ext_color(x_inventory + (width_inventory/4) * 3, y_text_options - y_correction + padding, inventory_options[j], 6, width_inventory/2 - margin_text*2, c_white, c_white, c_white, c_white, alpha_text)
					
					if (opt == j){
						var string_h = string_height(inventory_options[j])
						draw_sprite_stretched(spr_seta_txt, 0,x_inventory + (width_inventory/4) * 2,  y_text_options - y_correction + padding - string_h/2, width_selection_box - margin_text, heigth_selection_box);
					}
					
					
					
					
					padding += padding_increase;
				}
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
			}
		}
	
		
		if ((i - inventory_draw_from == item_draw_count) && (i + 1 < item_amount)){
			draw_sprite(spr_arrow_down, inventory_arrow_index, x_text, y_text);
			break;
		}
			

		
		draw_text_color(x_text, y_text, item_name, color_text, color_text, color_text, color_text, alpha_text);
		
		
	
		padding_text += padding_text_increase;
	}
	
	draw_sprite_stretched(spr_dot, 0, x_inventory, y_inventory, 2, items_total_height )
}




if (state == BATTLE_STATES.item_menu || state == BATTLE_STATES.hope_menu || state == BATTLE_STATES.main_menu ){
	
	
	
	
	for(var i = 0; i < option_count; i++){
			var option = options[i]
			draw_sprite_ext(option[1], b_subimage[i], cam_x + _padding - tam_hud/2 - _margin, cam_y + cam_h/2 - height_textbox_battle - arrow_sprite_height - _margin,1,1,0,c_white,1)
			_padding += 2 + sprite_get_width(option[1]);
	}
	
	

	
}

var alt_focus_points = 2;
var padding_hud = 5;
var alt_hud = sprite_get_height(spr_player_hud);
draw_set_font(fnt_tiny);
var width_texto_fp = string_width("FP");
var x_base_info = cam_x - cam_w / 2 + _margin;
var y_base_info = cam_y + cam_h/2 - alt_hud - padding_hud - _margin - height_textbox_battle;

draw_text( x_base_info, y_base_info - string_height("A")/2, "FP:");

draw_sprite_stretched_ext(spr_hopebar, 0,x_base_info + width_texto_fp + padding_hud, y_base_info, tam_hud - width_texto_fp - padding_hud, alt_focus_points, c_black, 0.5);
draw_sprite_stretched(spr_hopebar, 0, x_base_info + width_texto_fp + padding_hud, y_base_info, (focus_points_draw / max_focus_points) * (tam_hud - width_texto_fp - padding_hud), alt_focus_points);


//	var range = 10;
	
//	part_emitter_region(part_system_hope, part_emitter_hope, _inst_player.x-10 - range, _inst_player.x-10 + range, _inst_player.y - range, _inst_player.y + range, ps_shape_rectangle, ps_distr_linear);
//	if global.UP_KEY or global.DOWN_KEY or global.LEFT_KEY or global.RIGHT_KEY
//	part_emitter_burst(part_system_hope, part_emitter_hope, 0, 220);
	
//	var padd = 0;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "hoepdir: " + string(obj_player.hope_dir), 0.5, 0.5, 0)