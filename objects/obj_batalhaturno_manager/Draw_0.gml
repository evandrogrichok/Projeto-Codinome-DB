//depth = -99999;
myimage_index = scr_animar_sprite(myimage_index, myimage_speed, spr_player_portrait);



//draw_text(x,y, opt)
//draw_text(x,y+20, arrow_timer);

var _inst_player = obj_player;

//tamanho do visor da camera
var _cam_w = camera_get_view_width(view_camera[0]);
var _cam_h = camera_get_view_height(view_camera[0]);
//localizacao do obj cam
var _cam_x = obj_camera.x
var _cam_y = obj_camera.y
//tamanho dos sprites dos botoes, para calculos de distancia e tudo
var _sprite_w = sprite_get_width(spr_button_fight_pt);
var _sprite_h = sprite_get_height(spr_button_fight_pt);
//tamanho do hudzinho de vida
var _sprite_h_hud = sprite_get_height(spr_player_hud);

var _padding = 0
var _margin = 5
var portrait_x = (_cam_x - _cam_w/2 + _margin) + 3
var portrait_y = (_cam_y + _cam_h/2 - _sprite_h_hud - 5) + 3
var tam_hud = sprite_get_width(spr_player_hud)

var lifebar_x = (_cam_x - _cam_w/2 + _margin) + 22
var lifebar_y = (_cam_y + _cam_h/2 - _sprite_h_hud - 5) + 11
var tam_alvo = 20
//parte >>ESQUERDA<< do alvo setas
var x_alvo_setas = (_cam_x-20)-tam_alvo
var x_dist = 10;
var aumentar_alvo = 0;
//desenhando setas

var arrow_x_distance = 0; 
var alpha = 1;

//INIMIGOS
var quant_inimigos = array_length(inimigos_combo);
var quant_inimigos_vivos = array_length(inimigos_vivos);

var quant_opc = array_length(options)

var u_keys = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
var d_keys = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));
var _opt_changer_v = (d_keys) - (u_keys) ;


draw_set_halign(fa_center);
var padd = 0;
draw_text(_cam_x, _cam_y -_cam_h/2 + 10*padd, "battle_state: " + string(state))
padd++;
draw_text(_cam_x, _cam_y -_cam_h/2 + 10*padd, "opt: " + string(opt))
padd++;
draw_text(_cam_x, _cam_y -_cam_h/2 + 10*padd, "last opt: " + string(last_opt))
padd++;
draw_text(_cam_x, _cam_y -_cam_h/2 + 10*padd, "shake_level: " + string(shake_level))
padd++;
draw_text(_cam_x, _cam_y -_cam_h/2 + 10*padd, "inis: " + string(inimigos_combo))
padd++;
draw_text(_cam_x, _cam_y -_cam_h/2 + 10*padd, "inis vivo: " + string(inimigos_vivos))
padd++;
draw_set_halign(fa_left);
draw_set_font(fnt_main);



//draw_rectangle(x_alvo_setas, _cam_y,x_alvo_setas, _cam_y+20, 0)
//draw_rectangle(x_lim_setas-5, 0,x_lim_setas, 300, 0)
//draw_rectangle(local_seta_mais_proxima, 0, local_seta_mais_proxima+(sprite_get_width(spr_seta_up)), 300, 0)


dist_seta_alvo = point_distance(x_alvo_setas, _cam_y, local_seta_mais_proxima, _cam_y)

if state == BATTLE_STATES.arrow_pattern{
		for(var k = 0; k < array_length(keys); k++){
		var key = keys[k]

		if keyboard_check(key[0]){
		aumentar_alvo = 5;
		}
	}



	draw_sprite_stretched(spr_alvo_setas, 0, x_alvo_setas - aumentar_alvo/2, _cam_y-tam_alvo/2 - aumentar_alvo/2, tam_alvo + aumentar_alvo, tam_alvo + aumentar_alvo)
	
	var quant_setas = array_length(arrow_pat)
	var start = arrow_to_draw_from
	
	for (var i = 0; i < quant_setas; i++){
		if arrow_to_draw_from <= i{
		draw_sprite_ext(asset_get_index($"spr_seta_{arrow_pat[i]}"),0,spawn_setas + arrow_x_distance, _cam_y, 1, 1, 0, c_white, alpha);
		alpha -= 1/quant_setas;
		}
		arrow_x_distance += sprite_get_width(spr_seta_up) + x_dist;	
			
	}
	

	
	spawn_setas -= vel_setas;
}


//DESENHANDO EFEITO DE FEEDBACK NAS SETAS
if arrow_feedback_draw[0] != ""{
	if arrow_feedback_draw[1] < param_acertar[1][0]{
		draw_sprite_ext(asset_get_index($"spr_seta_gray_{arrow_feedback_draw[0]}"), 0, x_alvo_setas + tam_alvo/2, _cam_y, 1, 1, 0, cor_texto_acerto, alpha_feedback);
		
		if alpha_feedback > 0{
			alpha_feedback -= 0.1
			
		} else {
			arrow_feedback_draw = ["","",""]
		}
	} else {
		draw_sprite_ext(asset_get_index($"spr_seta_gray_{arrow_feedback_draw[0]}"), 0, arrow_feedback_draw[2] + sprite_get_width(spr_seta_gray_left)/2, _cam_y, 1, 1, 0, cor_texto_acerto, alpha_feedback);
		if alpha_feedback > 0{
			alpha_feedback -= 0.1
			
		} else {
			arrow_feedback_draw = ["","",""]
		}
	}
}



//DESENHANDO O INIMIGO
seta_index = scr_animar_sprite(seta_index, seta_speed, spr_selec_ini); 
sin_t += 0.05
for(var i = 0; i < quant_inimigos; i++){
	
		draw_text(_cam_x, _cam_y -_cam_h/2 + 10*padd, "i" + string(0 + abs(quant_inimigos_vivos-quant_inimigos)))
		padd++;
		

		

		
	

		
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
			draw_away = lerp(draw_away, 20, 0.01)
			fade_away += -0.05
			var vel_draw_away = 5;
			
			var x_ini = x_inimigo[i] + vel_draw_away * draw_away
			var y_ini = y_inimigo[i] - vel_draw_away - sin(sin_t) * 5
			
		
			part_emitter_region(part_system_stars, part_emitter_stars, x_ini -10, x_ini +10, y_ini -10, y_ini +10, ps_shape_rectangle, ps_distr_linear);
			part_emitter_burst(part_system_stars, part_emitter_stars, 0, 20);
			
			draw_sprite_ext(sprite_ini_pur, enemies_index[i], x_ini, y_ini, 1, 1, 0, c_white, fade_away);
			
			if fade_away <= 0{
				enemies_draw_defeat_state[i] = 1;
				draw_away = 0
				fade_away = 2
				 
				}
			}
			
			
		}
		
		if(hp_inimigos[i] <= 0){
			continue;
		}
		
		
	if hp_inimigos[i] >= 0{
		if state != BATTLE_STATES.enemy_turn{
			enemies_index[i] = scr_animar_sprite(enemies_index[i], enemies_speed[i], sprite_ini);
		}
	
		if quant_inimigos == 1{
		x_inimigo[i] = _cam_x + _cam_w/3
		y_inimigo[i] = _cam_y 
		} else {
		x_inimigo[i] = _cam_x + _cam_w/3
		y_inimigo[i] = (_cam_y - _cam_h / 2 + ini_sprites_altura[i]/2) + (_cam_h / (quant_inimigos+1)) * (i + 1);

		}
	
		var larg_barra_hp = 25;
		var larg_out_hp = larg_barra_hp + 2;
		var altura_barra_hp = 3;
		var altura_out_hp = altura_barra_hp+2;
	
		if (alpha_barra_ini>0 && state == BATTLE_STATES.enemy_turn){
			alpha_barra_ini -= 0.01;
	
		}
	
		draw_sprite_stretched_ext(spr_outline_enemy_hb,0, x_inimigo[i] - larg_out_hp/2, y_inimigo[i] - sprite_get_height(sprite_ini) - altura_out_hp+1, larg_out_hp, altura_out_hp, c_white,alpha_barra_ini)
		draw_sprite_stretched_ext(spr_healthbar_enemy,0, x_inimigo[i] - larg_barra_hp/2, y_inimigo[i] - sprite_get_height(sprite_ini) - altura_barra_hp, (hp_inimigos[i] / max_hp)*larg_barra_hp, altura_barra_hp, #54003e,alpha_barra_ini)
	
		if state == BATTLE_STATES.enemy_turn{
			enemies_index[i] = scr_animar_sprite(enemies_index[i], enemies_speed[i], sprite_ini_atk);
			draw_sprite_ext(sprite_ini_atk, enemies_index[i], x_inimigo[i], y_inimigo[i], 1, 1, 0, c_white, 1);
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
		
				if (_opt_changer_v != 0){
				sin_t = pi/2;
			}
		
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
		draw_text_color(x_texto_acerto, _cam_y - tam_alvo - 10, text_to_draw[0],cor_texto_acerto,cor_texto_acerto,cor_texto_acerto,cor_texto_acerto, alpha_txt_acerto)
		draw_set_halign(fa_left)
	
		if alpha_txt_acerto > 0{
			alpha_txt_acerto -= 0.01;
			x_texto_acerto = x_texto_acerto  + (dest_x_texto_acerto - x_texto_acerto) * 0.1;
	
		} else {
			text_to_draw = ["","",""]
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
			text_to_draw = ["","",""]
		}
	
	}
}
local_seta_mais_proxima = (spawn_setas + (sprite_get_width(spr_seta_up) + x_dist) * arrow_to_draw_from)-(sprite_get_width(spr_seta_up)/2)

if (mostrar_limites_de_movimentacao){
	sin_t += 0.05
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
		sin_t += 0.05
		
		draw_sprite_stretched_ext(spr_barriers, 0, pos_x - largura_caixa/2, pos_y - altura_caixa/2, largura_caixa, altura_caixa, c_white, clamp(sin(sin_t)/2 + fade_in_alpha, 0, 1));
	
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


draw_sprite_ext(spr_player_hud, b_subimage[0], _cam_x - _cam_w/2 + _margin, _cam_y + _cam_h/2 - _sprite_h_hud - 5,1,1,0,c_white,1)
draw_sprite(spr_player_portrait,myimage_index,portrait_x,portrait_y)
draw_sprite_stretched(spr_healthbar,0,lifebar_x,lifebar_y, (_inst_player.values.hp / max_health)*43, 7)

draw_set_font(fnt_tiny)
draw_text(portrait_x + 18, portrait_y-3,"Cael")
draw_text_colour(portrait_x + sprite_get_width(spr_player_hud) - 23, portrait_y-3,"hp:",c_white,c_white,c_white,c_white,.5)
draw_text_colour(portrait_x + sprite_get_width(spr_player_hud) - 13, portrait_y-3,string(_inst_player.values.hp),c_yellow,c_yellow,c_yellow,c_yellow,1)
draw_set_font(fnt_main)




if (state == BATTLE_STATES.item_menu || state == BATTLE_STATES.hope_menu || state == BATTLE_STATES.main_menu ){
	
	
	
	
	for(var i = 0; i < quant_opc; i++){
			var option = options[i]
			draw_sprite_ext(option[1], b_subimage[i], _cam_x + _padding - tam_hud/2 - _margin, _cam_y + _cam_h/2 - _sprite_h - _margin,1,1,0,c_white,1)
			_padding += 2 + sprite_get_width(option[1]);
	}

	
}

var alt_focus_points = 2;
var padding_hud = 5;
var alt_hud = sprite_get_height(spr_player_hud);
draw_set_font(fnt_tiny);
var width_texto_fp = string_width("FP");
draw_text( _cam_x - _cam_w / 2 + _margin, _cam_y + _cam_h/2 - alt_hud - padding_hud - _margin - string_height("A")/2, "FP:");

draw_sprite_stretched_ext(spr_hopebar, 0, _cam_x - _cam_w / 2 + _margin + width_texto_fp + padding_hud, _cam_y + _cam_h/2 - alt_hud - padding_hud - _margin, tam_hud - width_texto_fp - padding_hud, alt_focus_points, c_black, 0.5);
draw_sprite_stretched(spr_hopebar, 0, _cam_x - _cam_w / 2 + _margin + width_texto_fp + padding_hud, _cam_y + _cam_h/2 - alt_hud - padding_hud - _margin, (focus_points_draw / max_focus_points) * (tam_hud - width_texto_fp - padding_hud), alt_focus_points);


