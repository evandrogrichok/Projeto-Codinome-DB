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

var padd = 0;
padd++;
draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "versao exclusiva para teste", 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "BEAT: " + string(beat), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "BAR: " + string(bar), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "BPM: " + string(music_parameters.bpm), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "DT: " + string(delta_time/16666), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "can: " + string(can_lower_dmg_txt_alpha), 0.5, 0.5, 0)
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
			part_emitter_burst(part_system_stars, part_emitter_stars, part_type_stars, 20);
			
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
		individual_arrow_distance[i] -= vel_setas * global.DELTA_TIME;	
	}
	
	local_seta_mais_proxima = individual_arrow_distance[arrow_to_draw_from];
	//draw_rectangle(closest_arrow_x,closest_arrow_y,closest_arrow_x+2, closest_arrow_y+2, false)

}


//draw_rectangle(seta, 0, local_seta_mais_proxima+(sprite_get_width(spr_seta_up)), 300, 0)


//DESENHANDO EFEITO DE FEEDBACK NAS SETAS
if arrow_feedback_draw[0] != ""{
	if arrow_feedback_draw[1] < param_acertar[1][0]{
		draw_sprite_ext(asset_get_index($"spr_seta_gray_{arrow_feedback_draw[0]}"), 0, arrow_target_x, cam_y, 1, 1, 0, text_to_draw_color, alpha_feedback);
		
		if alpha_feedback > 0{
			alpha_feedback -= 0.1
			
		} else {
			arrow_feedback_draw = ["",""]
		}
	} else {
		draw_sprite_ext(asset_get_index($"spr_seta_gray_{arrow_feedback_draw[0]}"), 0, last_closest_arrow_x, last_closest_arrow_y, 1, 1, 0, text_to_draw_color, alpha_feedback);
		if alpha_feedback > 0{
			alpha_feedback -= 0.1
			
		} else {
			arrow_feedback_draw = ["",""]
		}
	}
}








// DESENHANDO O TEXTO DE ACERTO DAS SETAS

//text_to_draw[TEXTO, TIPO]
if text_to_draw[0] != ""{
	switch (text_to_draw[1]){
	case TXT_TYPES.arrow_accuracy:
		draw_set_halign(fa_center)
		draw_text_color(text_initial_x_position, cam_y - target_size - 10, text_to_draw[0],text_to_draw_color,text_to_draw_color,text_to_draw_color,text_to_draw_color, alpha_txt_to_draw)
		draw_set_halign(fa_left)
	
	break;
	
	case TXT_TYPES.enemy_damage:
		draw_set_halign(fa_center)
		draw_set_font(fnt_bold)
		
		var col = make_colour_hsv(hue_attack_text[0], sat_attack_text[0], val_attack_text[0]);
		var col2 = make_colour_hsv(hue_attack_text[1], sat_attack_text[1], val_attack_text[1]);
		
		var y_correction_for_dmg = 30;
		for (var i = 0; i < string_length(text_to_draw[0]); i++){
			var wave_effect_speed = 2;
			var wave_effect_char_start_difference = 20;
			var wave_effect_multiplier = 2;
			var sin_math = (sin(sin_t*wave_effect_speed + wave_effect_char_start_difference*i)) *wave_effect_multiplier;
			var single_char = string_copy(dmg_copy_string, 1+i, 1)
			
			var char_padding = 12 *i;
			
			
		
			draw_text_transformed_color(text_initial_x_position + char_padding, y_inimigo[opt] - y_correction_for_dmg + sin_math, single_char,size_attack_text , size_attack_text + scale_pop_effect[i], rot_attack_text,col,col,col2,col2,alpha_txt_to_draw)
		}
		draw_set_font(fnt_main)
		draw_set_halign(fa_left)
	
	
	break;
	}

}
//local_seta_mais_proxima = (spawn_setas + (sprite_get_width(spr_seta_up) + padding_between_arrows) * arrow_to_draw_from)-(sprite_get_width(spr_seta_up)/2)







//draw_text(x+40,y, dist_seta_alvo)
//desenhando vida 




