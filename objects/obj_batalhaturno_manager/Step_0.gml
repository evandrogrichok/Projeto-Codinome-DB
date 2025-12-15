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

//show_debug_message(focus_points);
//show_debug_message(focus_points_draw);

//localizacao do obj cam
var cam_x = obj_camera.x
var cam_y = obj_camera.y;

var arrow_target_x = cam_x;

//inimigos
var enemy_count = array_length(inimigos_combo);
var enemy_count_alive = array_length(inimigos_vivos);

//show_debug_message(global.can_move)


sin_t += 0.05

if target_rot_effect != 0 {
	target_rot_effect = lerp(target_rot_effect, 0, 0.3);
}

can_use = true;

switch (state){
	case (BATTLE_STATES.main_menu):
	
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
	
	//===== CONTROLADOR DE OPÇÕES
	var item_inventory_count = array_length(obj_game_manager.inventory);

	
	if opt_changer != 0{
		audio_play_sound(snd_key, 3, false);
	}



	
	if (draw_inventory_actions){
		var inventory_options_count = array_length(inventory_options);	
		
		opt += vertical_opt_changer;
		opt = (opt + inventory_options_count) mod inventory_options_count;
		
		
		if accept_key && can_use{
			if (opt == 0){
				obj_game_manager.use_item(obj_game_manager.inventory[selected_item], selected_item);
				draw_inventory_actions = false;
				opt = selected_item;
				selected_item = undefined;
				go_to_wait_time_state(BATTLE_STATES.enemy_turn)
			} else {
				draw_inventory_actions = false;
				opt = selected_item;
				selected_item = undefined;
			}
		
		}
	
		if deny_key && draw_inventory_actions{
			draw_inventory_actions = false;
			opt = selected_item;
			selected_item = undefined;

		}
	
	
	} else {
		
		if (d_keys){
			opt++;
			opt = clamp(opt, 0, item_inventory_count-1);
		
			if (opt > item_draw_count + inventory_draw_from - 1) && (opt < item_inventory_count -1 ){
				inventory_draw_from ++
			
			}
		}
		if (u_keys){
		
			opt--;
			opt = clamp(opt, 0, item_inventory_count-1);
		

			if (opt < inventory_draw_from + 1) && (opt > 0){
				inventory_draw_from --
			
			}
		}
		
		if accept_key {
			selected_item = opt
			opt = 0;
			draw_inventory_actions = true;
			can_use = false;
		}
		
		if deny_key {
			opt = 2; //voltar em "itens"
			state = BATTLE_STATES.main_menu; // voltar para menu
		}
	}

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
		instance_destroy(obj_textboxx);
		state = BATTLE_STATES.arrow_pattern;
	}
		
	if deny_key{
		focus_points -= focus_points_amnt_incr
		state = BATTLE_STATES.main_menu;
		main_textbox_id.visible = true;
	}
	
	break;
	
	case (BATTLE_STATES.arrow_pattern):
	height_textbox_battle = lerp(height_textbox_battle, 0, 0.1);
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
		
		target_rot_effect = choose(20, -20);

		if (key[1] == arrow_pat[arrow_to_draw_from]){
			setup_accuracy_text_draw_values(dist_alvo);
			search_for_param_accuracy(dist_alvo, target_size, arrow_target_x)
			//procurando o parametro certo para desenhar
		} else {
			//var params sempre recebe a ultima linha do array pra pegar os parametros de erro, só por organizacao!
			var ultimo = array_length(param_acertar)-1
			var params = param_acertar[ultimo];
			
			setup_accuracy_text_draw_values(dist_alvo);
			setup_accuracy_text_draw(params, target_size, arrow_target_x)
		}
		
		arrow_to_draw_from ++
		
		}
	}

	
	if ((local_seta_mais_proxima < x_lim_setas) && array_length(player_arrow_pat) < quant_setas){
		setup_accuracy_text_draw_values(max_distance_arrow);
		search_for_param_accuracy(max_distance_arrow, target_size, arrow_target_x, true);
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
			
			text_to_draw = [string(dmg),"dano_no_inimigo",""]
			x_texto_acerto = x_inimigo[opt] + range_text;
			dest_x_texto_acerto = x_inimigo[opt] - range_text;
			
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
			state = next_state
			inst_player_tweak = false;
			tempo_inicio = 0;
			duracao = 0;
			opt = 0;
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

		
		if (enemy_attack_type == "time-repeat"){
			var attack_scr = current_attack.attack_script;
			
			script_execute(circle_and_falling_ice);
			
			
			if (enemy_attack_timer <= 0){
				var attack_frequency = current_attack.repeat_frequency;
				enemy_attack_timer = attack_frequency;
			} else {
				enemy_attack_timer--;
				
			}

			
			if (enemy_attack_duration <= 0){
				enemy_attack_finished = true;
			} else {
				enemy_attack_duration--;
			}
		}
	
	
	if enemy_attack_finished{
		go_to_wait_time_state(BATTLE_STATES.main_menu);
		scr_change_canmove(-1);
		inst_player.sprite_index = spr_player_idle_battle;
		enemy_attack_finished = false;
		setup_enemy_turn = false;
		mostrar_limites_de_movimentacao = false
		tempo_inicio = current_time;
		duracao = 500;
	}
	
	
	
	break;
	
	case BATTLE_STATES.battle_won:
		
		
	break;
	
	
}
