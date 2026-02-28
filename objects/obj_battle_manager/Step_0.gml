if keyboard_check(vk_f10){
room_goto(rm_downes_lawn_01);
obj_camera.fixated_camera = false;
scr_can_move_tweaker(+1);
audio_stop_sound(mus);
audio_play_sound(snd_something_started_to_change, 5, true);
obj_player.mask_index = obj_player.sprite_index;
}
var l_keys = global.LEFT_KEY
var r_keys = global.RIGHT_KEY;
var u_keys = global.UP_KEY;
var d_keys = global.DOWN_KEY;
var accept_key = global.ACCEPT_KEY;
var deny_key = global.BACK_KEY;

var opt_changer =  (r_keys) - (l_keys);
var vertical_opt_changer = (d_keys) - (u_keys) ;

var inst_player = obj_player;
var opt_count = array_length(options);
var spd_fp_draw = 0.25;

if focus_points_draw != focus_points {
	focus_points_draw = lerp(focus_points_draw, focus_points, spd_fp_draw);
}

if height_textbox_battle != dest_height_textbox_battle{
	var lerp_speed = 0.2
	
	height_textbox_battle = lerp(height_textbox_battle, dest_height_textbox_battle, lerp_speed)
}

if (instance_exists(obj_game_manager) && setted_up_lang = false){
setup_lang();
setted_up_lang = true;
}

pattern_start_time = audio_sound_get_track_position(mus);

var last_beat = beat;
beat = floor(audio_sound_get_track_position(mus)/bpm_seconds);

if (last_beat != beat){
	screen_effects();
}

//show_debug_message(focus_points_draw);

//localizacao do obj cam
var cam_x = obj_camera.x
var cam_y = obj_camera.y;



//inimigos
var enemy_count = array_length(inimigos_combo);
var enemy_count_alive = array_length(inimigos_vivos);

//show_debug_message(global.can_move)

if alpha_options != [1, 1, 1, 1] && state != BATTLE_STATES.item_menu{
	alpha_options = array_create(option_count, 1);
}


if text_to_draw[0] != ""{

	switch (text_to_draw[1]){
	case TXT_TYPES.arrow_accuracy:
	rot_text = lerp(rot_text, rot_text_dest, 0.2);
	size_text = lerp(size_text, size_text_big, 0.2);
	if alpha_txt_to_draw > 0{
		alpha_txt_to_draw -= 0.01;
		text_initial_x_position = text_initial_x_position  + (text_final_x_position - text_initial_x_position) * 0.1;
	} else {
		reset_text_to_draw(TXT_TYPES.arrow_accuracy);
	}

	break;
	
	case TXT_TYPES.enemy_damage:
	if alpha_txt_to_draw > 0{
		if index_dmg < string_length(text_to_draw[0]){
			if !time_source_exists(ts_index_increase){
			ts_index_increase = time_source_create(time_source_game, 10, time_source_units_frames, function(){with(self){index_dmg++; show_debug_message(index_dmg)}}, [undefined], string_length(text_to_draw[0]))
			time_source_start(ts_index_increase);
			}
		}
		
		for (var i = 0; i < index_dmg; i++){
			if scale_pop_effect[i] != 0{
				scale_pop_effect[i] = lerp(scale_pop_effect[i], 0, 0.5)
			}
		
		}
		
		dmg_copy_string = string_copy(text_to_draw[0], 1, index_dmg);

		
		if can_lower_dmg_txt_alpha{
			alpha_txt_to_draw -= 0.1
		}
		text_initial_x_position = text_initial_x_position  + (text_final_x_position - text_initial_x_position) * 0.1;
		
		size_text = lerp(size_text, size_text_big, 0.2);
		
	
		hue_attack_text[0] = lerp(hue_attack_text[0], dest_attack_text_hsv[0][0], .1)
		hue_attack_text[1] = lerp(hue_attack_text[1], dest_attack_text_hsv[1][0], .2)
	
		if !blink_dmg{
		sat_attack_text[0] = dest_attack_text_hsv[0][1];
		sat_attack_text[1] = dest_attack_text_hsv[1][1];
		}
	} else {
		reset_text_to_draw(TXT_TYPES.enemy_damage)
	}
	
	break;
	}

}

sin_t += 0.05

if alpha_vignette_beat > 0 {
alpha_vignette_beat = lerp(alpha_vignette_beat, .5, 0.2);
}

if target_rot_effect != 0 {
	target_rot_effect = lerp(target_rot_effect, 0, 0.3);
}

can_use = true;

switch (state){
	case (BATTLE_STATES.main_menu):
	alpha_vignette = lerp(alpha_vignette, alpha_vignette_low, 0.1);
	
	//===== CONTROLADOR DE OPÇÕES
	opt += opt_changer;
	opt = (opt + opt_count) mod opt_count;
	
	if opt_changer != 0{
		audio_play_sound(snd_key, 3, false);
	}
		
	b_subimage = array_create(opt_count, 0)
	b_subimage[opt] = 1;

	//ENVIAR OPCAO		
	if accept_key{
	run_command(opt)
	opt = 0;
	}
	
	//CONTROLAR LOCAL DO JOGADOR
	if !inst_player_tweak{
	inst_player.x = position_player[0][0]
	inst_player.y = position_player[0][1]
	
	inst_player_tweak = true;
	}
		
	break;
	
	case (BATTLE_STATES.item_menu):
	var state_inventory = obj_game_menu.state;
	var substate_inventory = obj_game_menu.item_substate;
	alpha_vignette = lerp(alpha_vignette, alpha_vignette_high, 0.1);
	
	
	
	
	
	break;
	
	case (BATTLE_STATES.select_enemy):
	if alpha_barra_ini != 1{
		alpha_barra_ini = 1;
	}
	
	if hp_inimigos[opt] <= 0{
		var tentativas = 0; 
		var prox_ini = opt; // um apontador para procurar pelo prox inimigo, como se fosse um opt temporario falso
			
		do{
			prox_ini = (prox_ini + 1) % enemy_count; 
			tentativas ++; 
			   
			if (hp_inimigos[prox_ini] > 0){
				opt = prox_ini;
				break; 
			}
			
		} until (tentativas >=  enemy_count); // isso continua ate a quantidade de tentativas ser igual a quant inimigos
	}
	

	if d_keys{
		var tentativas = 0; // contador para ver quantas vezes ele ja procurou por um inimigo com vida
		var prox_ini = opt; // um apontador para procurar pelo prox inimigo, como se fosse um opt temporario falso
			
		do{
			prox_ini = (prox_ini + 1) % enemy_count; // procura pelo proximo inimigo com vida
			tentativas ++; //quando ele procurar por um ele aumenta a quantidade de tentativas 
			   
			if (hp_inimigos[prox_ini] > 0){
				opt = prox_ini;
				break; // se ele achar, quebra e dai atribui o opt temporario para opt e quebra o loop
			}
			
		} until (tentativas >=  enemy_count); // isso continua ate a quantidade de tentativas ser igual a quant inimigos
			
	}
	
	if u_keys{
			
		var tentativas = 0;
		var prox_ini = opt;
			
		do{
			prox_ini = (prox_ini - 1 + enemy_count) % enemy_count;
			tentativas ++;
			   
			if (hp_inimigos[prox_ini] > 0){
				opt = prox_ini;
				break;
			}
			
		} until (tentativas >=  enemy_count);

	}
		

	
	if accept_key{
		next_enemy_to_attack = opt;
		toggle_textbox(TEXTBOX_PROPERTIES.is_created, false);
		state = BATTLE_STATES.arrow_pattern;

	}
		
	if deny_key{
		focus_points -= focus_points_amnt_incr
		state = BATTLE_STATES.main_menu;
	}
	
	break;
	
	case (BATTLE_STATES.arrow_pattern):
	
	alpha_vignette = lerp(alpha_vignette, alpha_vignette_high, 0.1);
	
	dist_seta_alvo = point_distance(arrow_target_x, cam_y, closest_arrow_x, closest_arrow_y);	
	
	if alpha_barra_ini != 1{
		alpha_barra_ini = 1;
	}
	
	can_draw_texto_acerto = true
	
	var quant_setas = array_length(arrow_pat);
	var dist_alvo = dist_seta_alvo;
	

	for(var k = 0; k < array_length(keys); k++){
		var key = keys[k]
		var range_text = 5;
		
		if (keyboard_check_pressed(key[0]) && array_length(player_arrow_pat) < quant_setas){
			array_push(player_arrow_pat, [key[1], dist_alvo])
			if dist_alvo <= 5 {
				play_arrow_sfx()
			}
			
		
		target_rot_effect = choose(20, -20);

		if (key[1] == arrow_pat[arrow_to_draw_from]){
			
			draw_arrow_feedback(dist_alvo);
			var params = search_for_param_accuracy(dist_alvo);
			setup_text_draw(params[2],TXT_TYPES.arrow_accuracy,params[1]);
			//procurando o parametro certo para desenhar
		} else {
			//var params sempre recebe a ultima linha do array pra pegar os parametros de erro, só por organizacao
			
			draw_arrow_feedback(dist_alvo);
			var params = search_for_param_accuracy(dist_alvo, true)			
			setup_text_draw(params[2],TXT_TYPES.arrow_accuracy, params[1])
			
			
		}
		
		arrow_to_draw_from ++
		
		}
	}

	
	if ((local_seta_mais_proxima < x_lim_setas) && array_length(player_arrow_pat) < quant_setas){
		draw_arrow_feedback(max_distance_arrow);
		var params = search_for_param_accuracy(max_distance_arrow, true);
		setup_text_draw(params[2],params[1], TXT_TYPES.arrow_accuracy)
		arrow_to_draw_from ++;
		array_push(player_arrow_pat, ["miss", max_distance_arrow])
	}
	
	if (quant_setas == array_length(player_arrow_pat)){
		
		dmg = calculate_damage(quant_setas)
		reset_arrow_pattern_vars(quant_setas);
		
		state = BATTLE_STATES.attacking
		flag_atacando = true;
	}
	
	break;
	
	case BATTLE_STATES.attacking:
	
	
	
		if alpha_barra_ini != 1{
			alpha_barra_ini = 1;
		}
	
		if flag_atacando{
			inst_player.sprite_index = spr_player_attack_horizontal;
			inst_player.image_index = 0;
			flag_atacando = false;
		}
		
		if inst_player.image_index >= inst_player.image_number-1 {
			var range_text = 10;
			
			if (hp_inimigos[opt] - dmg <= 0){
				audio_play_sound(snd_glitter, 3, false);
			}
			
			hp_inimigos[opt] -= dmg;
			
			
			setup_text_draw(dmg, TXT_TYPES.enemy_damage)
			
			
			if hp_inimigos[opt] > 0{
				shake_level = 3
			}
			

			
			//ATUALIZANDO ARRAY DE INIMIGOS VIVOS
		
			//deleta os inimigos que tinha antes
			reload_alive_enemies_array()
			
			enemy_count_alive = array_length(inimigos_vivos);
			
			if enemy_count_alive > 0{
				go_to_wait_time_state(BATTLE_STATES.enemy_turn);
				load_enemy_attack();
				state = BATTLE_STATES.wait_time;
				inst_player.sprite_index = spr_player_idle_battle;
			} else {
				go_to_wait_time_state(BATTLE_STATES.battle_won);
				inst_player.sprite_index = spr_player_finish;
			}
		}
	break;
	
	case BATTLE_STATES.wait_time:
	wait_timer --;
	
	switch(next_state){
		case BATTLE_STATES.enemy_turn:
		alpha_vignette = lerp(alpha_vignette, alpha_vignette_low, 0.1);
		
		
		if wait_timer > 0{
			mostrar_limites_de_movimentacao = true;
		} else {
			state = next_state
			global.can_move += 1;
			inst_player.facing_x = 1
			fade_in_alpha = 0;
			sin_t = 0
		}
		break;
		case BATTLE_STATES.main_menu:
		if wait_timer <= 0{
			global.sin_t_points = 0;
			state = next_state
			inst_player_tweak = false;
			tempo_inicio = 0;
			duracao = 0;
			opt = 0;
			toggle_textbox(TEXTBOX_PROPERTIES.is_created, true);
			
		} else {
			var t = clamp((current_time - tempo_inicio) / duracao, 0, 1);
			inst_player.move_player_towards_point(position_player[0][0], position_player[0][1], t);
			
			black_player_col_enemy_turn = lerp(black_player_col_enemy_turn, 255, t);	
			black_bg_color_alpha = lerp(black_bg_color_alpha, 0, t);	
			scr_update_player_blend_color(black_player_col_enemy_turn, black_player_col_enemy_turn, black_player_col_enemy_turn);
			
			global.ALPHA_PLAYER = lerp(global.ALPHA_PLAYER, 1, t);
			global.ALPHA_PLAYER_BORDER = lerp(global.ALPHA_PLAYER_BORDER, 1, t);
			global.RADIUS_HOPE_LIGHT =  lerp(global.RADIUS_HOPE_LIGHT, 0, t);
			
			if t == 1{
				wait_timer = 0;
			}
		}
		break;
		case BATTLE_STATES.battle_won:
		if wait_timer <= 0{
			state = BATTLE_STATES.battle_won;
			check_level_up_player();
			scr_open_textbox("battle_won")
			
		} else {
			inst_player.sprite_index = spr_player_finish;
		}
		break;
	
	}
	break;
	
	case BATTLE_STATES.enemy_turn:

		if black_player_col_enemy_turn != 0{
		var lerp_amnt = 0.1;
		black_player_col_enemy_turn = lerp(black_player_col_enemy_turn, 0, lerp_amnt);	
		black_bg_color_alpha = lerp(black_bg_color_alpha, 1, lerp_amnt);
		global.ALPHA_PLAYER = lerp(global.ALPHA_PLAYER, .2, lerp_amnt);
		global.ALPHA_PLAYER_BORDER = lerp(global.ALPHA_PLAYER_BORDER, 0, lerp_amnt);
		
		global.RADIUS_HOPE_LIGHT =  lerp(global.RADIUS_HOPE_LIGHT, global.RADIUS_HOPE_LIGHT_MINIMUM, lerp_amnt);
		
		scr_update_player_blend_color(black_player_col_enemy_turn, black_player_col_enemy_turn, black_player_col_enemy_turn);
		
		}
	
		if !setup_enemy_turn {
			setup_enemy_turn_settings();
			
		}

		if instance_exists(obj_points){
			global.sin_t_points ++;
		}
		
		if (enemy_attack_type == "time-repeat"){
			var attack_scr = current_attack.attack_script;
			
			script_execute(circle_and_falling_ice);

			
			if (enemy_attack_duration <= 0){
				enemy_attack_finished = true;
			} else {
				enemy_attack_duration--;
			}
		}
	
	
	if enemy_attack_finished{
		go_to_wait_time_state(BATTLE_STATES.main_menu);
		scr_can_move_tweaker(-1);
		inst_player.sprite_index = spr_player_idle_battle;
		enemy_attack_finished = false;
		setup_enemy_turn = false;
		mostrar_limites_de_movimentacao = false
		next_enviroment_sentence();
		tempo_inicio = current_time;
		duracao = 500;
		
		if inst_player.facing_x != 1{
			inst_player.facing_x = 1;
		}
		
	}
	
	
	
	break;
	
	case BATTLE_STATES.battle_won:
		
		
	break;
	
	
}
can_run_attack_script = false;