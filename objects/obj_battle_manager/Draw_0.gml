//depth = -99999;
myimage_index = scr_animar_sprite(myimage_index, myimage_speed, spr_player_portrait);



//draw_text(x,y, opt)
//draw_text(x,y+20, arrow_timer);

var _inst_player = inst_player;



//tamanho do visor da camera
//var cam_w = camera_get_view_width(view_camera[0]);
//var cam_h = camera_get_view_height(view_camera[0]);
//localizacao do obj cam
var cam_x = inst_camera.x
var cam_y = inst_camera.y
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

//desenhando setas

var arrow_x_distance = 0; 
var arrows_alpha = 1;

//INIMIGOS
var enemy_count = array_length(enemies_combo);
//var alive_enemies_count = array_length(inimigos_vivos);

var u_keys = global.UP_KEY;
var d_keys = global.DOWN_KEY;
var vertical_opt_changer = (d_keys) - (u_keys) ;

draw_set_font(fnt_tiny);
var padd = 0;

//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, width_pct[0], 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, clamp(round(((enemies_data[0].hp_max - enemies_data[0].current_hp) / enemies_data[0].hp_max) * 100), 0, 100), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, enemies_data[0].current_hp, 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, index_dmg, 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, index_dmg, 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "who's turn: " + string(party[current_party_member].id), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "Z- ação/dash X- cancelar C/esc- menu", 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "f10- andar por aí :D", 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "f11- fullscreen", 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "setas/wasd- mover", 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "BEAT: " + string(beat), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "BEAT TIME	: " + string(beat_time), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "BAR: " + string(bar), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "BPM: " + string(music_parameters.bpm), 0.5, 0.5, 0)
//padd++;
////draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "BPM: " + string(time_source_get_time_remaining(time_source_sphb)), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "DT: " + string(delta_time/16666), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "can: " + string(can_lower_dmg_txt_alpha), 0.5, 0.5, 0)
////padd++;

//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "inis vivo: " + string(inimigos_vivos), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "inis x: " + string(x_inimigo[0]), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "inis y: " + string(y_inimigo[0]), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "fade away: " + string(fade_away[0]), 0.5, 0.5, 0)
//padd++;
//draw_text_transformed(cam_x - cam_w/2, cam_y -cam_h/2 + 5*padd, "draw away: " + string(draw_away[0]), 0.5, 0.5, 0)
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


//draw_text_ext_transformed(x_inimigo[0], y_inimigo[0], "BONECO DE NEVE", 1, 1000, 1, 1, 10)
//draw_text(x_inimigo[0], y_inimigo[0], "75%")


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
	
	if (state == BATTLE_STATES.transition_enemy_turn){
		
		draw_sprite_stretched_ext(spr_barriers, 0, pos_x - largura_caixa/2, pos_y - altura_caixa/2, largura_caixa, altura_caixa, c_white, clamp(sin(sin_t * 3)/2 + fade_in_alpha, 0, 1));
	
	} else 
	if (state == BATTLE_STATES.enemy_turn){
		barrier_index = scr_animar_sprite(barrier_index, barrier_speed, spr_gradient_barriers);
		
		draw_sprite_stretched_ext(spr_barriers, 0, pos_x - largura_caixa/2, pos_y - altura_caixa/2, largura_caixa, altura_caixa, c_white, .8);
		
		draw_sprite_stretched_ext(spr_gradient_barriers, barrier_index, pos_x - largura_caixa/2, pos_y - altura_caixa/2 - altura_gradiente +3, largura_caixa, altura_gradiente, c_white, fade_in_alpha*1.5);	
		draw_sprite_stretched_ext(spr_gradient_barriers_bottom, barrier_index, pos_x - largura_caixa/2, pos_y + altura_caixa/2 - altura_gradiente, largura_caixa, altura_gradiente, c_white, fade_in_alpha*1.5);
		
	}
}




				var merge_amount =.5
var color_selec = merge_color(area_properties.ui_secondary_colors[0], area_properties.ui_secondary_colors[1], merge_amount);
//DESENHANDO O INIMIGO
seta_index = scr_animar_sprite(seta_index, seta_speed, spr_selec_ini); 
for(var i = 0; i < enemy_count; i++){
	
	//desenhando lanes
	
	draw_sprite_stretched(
		spr_barriers,
		0,
		cam_x - cam_w / 2,
		cam_y - cam_h / 2 + lane_height * i +lane_height/2,
		cam_w,
		lane_height
	);
	
	
	
	var max_hp = enemies_data[i].hp_max;
	var nome = string_upper(enemies_data[i].enemy_name);
	var off_y_arrow = 17;

	if (enemies_data[i].current_hp <= 0){
		if enemies_draw_defeat_state[i] == ENEMIES_DRAW_STATES.cursed{
			draw_hp_bar_enemy(i, max_hp, draw_away[i]*4, fade_away[i]);		
			draw_enemy_name(i, draw_away[i]*4, fade_away[i]);
			draw_enemy_percentage(i, draw_away[i]*4, fade_away[i]);
			if_enemy_is_defeated(i)

		} 
		continue;
	} else {
		
		
		
		
		define_enemy_position(i, cam_x, cam_y);
		draw_hp_bar_enemy(i, max_hp);
		
		//DESENHANDO PORCENTAGEM E NOME
		draw_enemy_name(i)
		draw_enemy_percentage(i)

	
		if state == BATTLE_STATES.enemy_turn{
			scr_shader_outline(enemies_data[i].sprite_ini_atk, enemies_index[i], color_get_red(color_selec), color_get_green(color_selec), color_get_blue(color_selec), black_bg_color_alpha);
			draw_sprite_ext(enemies_data[i].sprite_ini_atk, enemies_index[i], x_inimigo[i], y_inimigo[i], 1, 1, 0, c_white, 1);
			shader_reset();
		} else
		if shaking && i == opt{
			var shake_x = 0
			var shake_y = 0
			var shake_dir = irandom(360)

			shake_x = lengthdir_x(shake_level, shake_dir);
			shake_y = lengthdir_y(shake_level, shake_dir);
			draw_sprite_ext(enemies_data[i].sprite_ini_dmg, 0, x_inimigo[i] + shake_x, y_inimigo[i] + shake_y, 1, 1, 0, c_white, 1);
		} else {
			if (i == opt && state == BATTLE_STATES.select_enemy){

				
				draw_sprite_ext(spr_selec_ini, seta_index, x_inimigo[opt], y_inimigo[opt], 1, 1, 0, color_selec, clamp(sin(sin_t*3)/5 + 0.8, 0, 1));	
				
				
				scr_shader_outline(enemies_data[i].sprite_ini, enemies_index[i], color_get_red(color_selec), color_get_green(color_selec), color_get_blue(color_selec), clamp(sin(sin_t*3)/5 + 0.8, 0, 1));

				
				draw_sprite_ext(enemies_data[i].sprite_ini, enemies_index[i], x_inimigo[opt], y_inimigo[opt], 1, 1, 0, c_white, 1);	

				shader_reset();

				
				continue;
			}
		
			draw_sprite_ext(enemies_data[i].sprite_ini, enemies_index[i], x_inimigo[i], y_inimigo[i], 1, 1, 0, c_white, 1);

			
		}
	}
}







if state == BATTLE_STATES.arrow_pattern{
	
	
	
	//for(var k = 0; k < array_length(keys); k++){
	//	var key = keys[k]

	//	if keyboard_check(key[0]){
	//	increase_target_size = 5;
	//	}
	//}

	var unit_size_sprite =  1/sprite_get_width(spr_alvo_setas);
	
	
	//sprite_set_offset(spr_alvo_setas, (target_size - increase_target_size)/2, (target_size - increase_target_size)/2)
	var mult_tranform = 8;
	
	draw_sprite_ext(spr_alvo_setas, 0,  arrow_target_x, target_size/2 + cam_y-target_size/2,  unit_size_sprite * (target_size + increase_target_size*mult_tranform), unit_size_sprite * (target_size + increase_target_size*mult_tranform), target_rot_effect, c_white, 1)

	
	
	


}


//draw_rectangle(seta, 0, local_seta_mais_proxima+(sprite_get_width(spr_seta_up)), 300, 0)

if blink_arrow_effect_timer > 0{
	scr_shader_paint(255, 255, 255, 1);		
	blink_arrow_effect_timer--; 
}
//DESENHANDO EFEITO DE FEEDBACK NAS SETAS
if (arrow_feedback_draw[0] != "") {
    var arrow_pop_effect_mult = 0.3;
    var pop_effect = arrow_sprite_transform * arrow_pop_effect_mult;

    var draw_x = last_closest_arrow_x;
    var draw_y = last_closest_arrow_y;
    var scale_y = 1;

    if (arrow_feedback_draw[1] < param_acertar[1][0]) {
        draw_x = arrow_target_x;
        draw_y = cam_y;
        scale_y = 1 + pop_effect;
    }

    draw_sprite_ext(
        asset_get_index($"spr_seta_gray_{arrow_feedback_draw[0]}"),
        0,
        draw_x,
        draw_y,
        1 + pop_effect,
        scale_y,
        0,
        text_to_draw_color,
        alpha_feedback
    );

    if (alpha_feedback > 0) {
        alpha_feedback  = lerp(alpha_feedback, 0, .2);
    } else {
        arrow_feedback_draw = ["", ""];
    }
}

shader_reset();







// DESENHANDO O TEXTO DE ACERTO DAS SETAS

//text_to_draw[TEXTO, TIPO]
if text_to_draw[0] != ""{
	switch (text_to_draw[1]){
	case TXT_TYPES.arrow_accuracy:
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		
		
		draw_text_transformed_color(text_initial_x_position, cam_y - target_size - 5, text_to_draw[0],1,size_text,rot_text,text_to_draw_color,text_to_draw_color,text_to_draw_color,text_to_draw_color, alpha_txt_to_draw)
		
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	
	break;
	
	case TXT_TYPES.enemy_damage:
		draw_set_halign(fa_center)
		draw_set_font(fnt_bold)
		
		var col = make_colour_hsv(hue_attack_text[0], sat_attack_text[0], val_attack_text[0]);
		var col2 = make_colour_hsv(hue_attack_text[1], sat_attack_text[1], val_attack_text[1]);
		
		
		var y_correction_for_dmg = 30;
				var draw_count = min(
		    string_length(dmg_copy_string),
		    array_length(scale_pop_effect)
		);

		for (var i = 0; i < draw_count; i++){
			var wave_effect_speed = 2;
			var wave_effect_char_start_difference = 20;
			var wave_effect_multiplier = 2;
			var sin_math = (sin(sin_t*wave_effect_speed + wave_effect_char_start_difference*i)) *wave_effect_multiplier;
			var single_char = string_copy(dmg_copy_string, 1+i, 1)
			
			var char_padding = 12 *i;
			
			
		
			draw_text_transformed_color(text_initial_x_position + char_padding, 30 + y_inimigo[opt] - y_correction_for_dmg + sin_math, single_char,size_text , size_text + scale_pop_effect[i], rot_text,col,col,col2,col2,alpha_txt_to_draw)
		}
		draw_set_font(fnt_main)
		draw_set_halign(fa_left)
	
	
	break;
	case TXT_TYPES.on_beat:
		draw_set_halign(fa_center)
		draw_set_font(fnt_tiny)
		
		draw_text_transformed_color(inst_player.x, inst_player.y - 20, text_to_draw[0], 1, size_text, rot_text,highlight_color,text_to_draw_color,highlight_color,text_to_draw_color, alpha_txt_to_draw)
		
	
		draw_set_font(fnt_main)
		draw_set_halign(fa_left)
	
	
	break;
	}

}

if (state == BATTLE_STATES.attacking_power){

	
	if (power_to_cast == global.DANCE_POWERS_DATA.tap_dance){
		draw_sprite(spr_bang, bang_index, x_inimigo[opt] + random_pos_x, y_inimigo[opt]+ random_pos_y - sprite_get_height(enemies_data[opt].sprite_ini)/2);
	}
	if (power_to_cast == global.DANCE_POWERS_DATA.heal_prayer){
		draw_sprite(spr_hp_recover, hp_index, player_initial_position[0], player_initial_position[1] - sprite_get_height(spr_player_h)/2);
		
	}
}
//local_seta_mais_proxima = (spawn_setas + (sprite_get_width(spr_seta_up) + padding_between_arrows) * arrow_to_draw_from)-(sprite_get_width(spr_seta_up)/2)

show_debug_message(global.r_paint);

