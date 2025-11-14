enum BATTLE_STATES{
	main_menu,
	item_menu,
	hope_menu,
	select_enemy,
	arrow_pattern,
	enemy_turn,
	attacking,
	battle_won,
	wait_time
}

max_focus_points = 100;
focus_points = 0;
focus_points_draw = 0;
focus_points_amnt_incr = 0;
focus_points_dest = 0;

xp_gain_constant = 1;
gold_gain_constant = 2;
leveled_up = false;

bonus_xp = 0;
 


var file = file_text_open_read("attacks.json");
var json_string = "";
while (!file_text_eof(file)) {
    json_string += file_text_read_string(file);
    file_text_readln(file);
}
file_text_close(file);

var data = json_parse(json_string);
ataques = data;


file = file_text_open_read("enemies.json");
json_string = "";
while (!file_text_eof(file)) {
    json_string += file_text_read_string(file);
    file_text_readln(file);
}
file_text_close(file);

data = json_parse(json_string);
dados_inimigos = data;

file = file_text_open_read("enemy_pattern.json");
json_string = "";
while (!file_text_eof(file)) {
    json_string += file_text_read_string(file);
    file_text_readln(file);
}
file_text_close(file);

data = json_parse(json_string);
combinacao_inimigos = data;

file = file_text_open_read("enemies_attacks.json");
json_string = "";
while (!file_text_eof(file)) {
    json_string += file_text_read_string(file);
    file_text_readln(file);
}
file_text_close(file);

data = json_parse(json_string);
ataques_inimigos = data;

duracao = 0;
tempo_inicio = 0;
state_num = 6;

xyvar = [
	[0, -1],
	[0,  1],
	[-1, 0],
	[1,  0]
]

keys = [
	[vk_up, "up"],
	[vk_down, "down"],
	[vk_left, "left"],
	[vk_right, "right"],
	[ord("W"),"up"],
	[ord("S"),"down"],
	[ord("A"),"left"],
	[ord("D"),"right"]
]

//futuramente adicionar nesse array o texto em ingles também, que no for vai ser scaneado com uma variavel global de definicao de linguagem
//sempre deixar os parametros de erro como errou!
param_acertar = [
	[5, #0cf2cc, "perfeito!" ],
	[15, #35e8a7, "ótimo!"],
	[25, #b8ff96, "ok"],
	[1000, #fff896, "longe"],
	[-1, #f56464, "errou..."]
]

x_lim_setas = obj_camera.x - camera_get_view_width(view_camera[0])/2 + 20
default_height_textbox_battle = 40;
height_textbox_battle = default_height_textbox_battle;
arrow_pat = []; // armazena no padrão de setas correto.
vel_setas = 0;
player_arrow_pat = [];// armazena o input do player
inst_player_tweak = false;
text_to_draw = ["", ""] // [VALOR, TIPO DE TEXTO P/ DESENHAR];
dest_x_texto_acerto = 0;
x_texto_acerto = 0;

wait_timer = 0;
next_state = undefined;
mostrar_limites_de_movimentacao = false;


position_player = array_create(state_num, array_create(2,0));
position_player[0] = [obj_camera.x - 75,  round(camera_get_view_height(view_camera[0]) - height_textbox_battle/2)/2 ];
spawn_setas = obj_camera.x +80;
local_seta_mais_proxima = 0;

flag_atacando = false
obj_player.sprite_index = spr_player_idle_battle;

scr_can_move_tweaker(-1);

state = BATTLE_STATES.main_menu;

opt = 0;
last_opt = undefined;

obj_camera.fixated_camera = true;

global.lang = "pt"

options = [
	["fight", asset_get_index("spr_button_fight_" + string(global.lang))],
	["hope", asset_get_index("spr_button_hope_" + string(global.lang))],
	["item", asset_get_index("spr_button_item_" + string(global.lang))],
	["defend", asset_get_index("spr_button_defend_" + string(global.lang))]
]


main_textbox_id = scr_open_textbox("BATTLE_test_001");

	
//}

sin_t = 0;
arrow_timer = 0;
arrow_time = 60;
arrow_to_draw_from = 0;
arrow_feedback_draw = ["",0,0];
alpha_feedback = 0;
arrow_pattern_perfects = 0;
myimage_speed = 1;
myimage_index = 0;
barrier_speed = 1;
barrier_index = 0;

dist_seta_alvo = 0;
max_health = 30
max_dmg = 0;
dmg = 0;
alpha_txt_acerto = 1;
cor_texto_acerto = 0;
can_draw_texto_acerto = false;
shake_level = 0;
//arrow_x_distance = 0;


//carrega adversario(s)
adversario = combinacao_inimigos.combo1;
//armazena os adversarios 
inimigos_combo = adversario.enemies;


var quant_inimigos_combo = array_length(inimigos_combo);
//guarda a vida, sprites,... de cada um dos inimigos do combo
parametros_inimigos = array_create(quant_inimigos_combo);
hp_inimigos = array_create(quant_inimigos_combo);
nomes_inimigos = array_create(quant_inimigos_combo);
show_debug_message(inimigos_combo)

for (var i = 0; i < quant_inimigos_combo; i++){
	parametros_inimigos[i] = variable_struct_get(dados_inimigos, inimigos_combo[i]);
	hp_inimigos[i] = parametros_inimigos[i].hp;
	nomes_inimigos[i] = parametros_inimigos[i].enemy_name;
	var sprite = asset_get_index(parametros_inimigos[i].sprite)
	ini_sprites_altura = array_create(quant_inimigos_combo, sprite_get_height(sprite))
}

show_debug_message(nomes_inimigos)

x_inimigo = array_create(quant_inimigos_combo);
y_inimigo = array_create(quant_inimigos_combo);

old_player_xy =[0,0]
next_enemy_to_attack = 0;
alpha_barra_ini = 0;
enemies_speed = array_create(quant_inimigos_combo, 1);
enemies_index = array_create(quant_inimigos_combo, 0);
enemies_index_atk = array_create(quant_inimigos_combo, 0);
enemies_draw_defeat_state = array_create(quant_inimigos_combo, 0);
draw_away = 0;
fade_away = 2;
seta_index = 0;
seta_speed = 1;

inimigos_vivos = [];


closest_arrow_x = undefined;
closest_arrow_y = undefined;
last_closest_arrow_x = closest_arrow_x
last_closest_arrow_y = closest_arrow_x


available_enemies_attacks = [];
var enemies_atks_keys = variable_struct_get_names(ataques_inimigos);
var count_enemies_atks = array_length(enemies_atks_keys);


function load_arrow_distance(){
	individual_arrow_distance = [];
	base_initial_distance = 80;
	distance_between_arrows = 40;
	
	for (var i = 0; i < array_length(arrow_pat); i++){
		array_push(individual_arrow_distance, base_initial_distance + distance_between_arrows * i);
		show_debug_message("aaaaaaaaaaaaaaaaaaaaaaa");
		show_debug_message(individual_arrow_distance);
	}
}



//SETUP INICIAL DOS ATAQUES DISPONÍVEIS. =====
for (var i = 0; i < count_enemies_atks; i++){
	var atk = variable_struct_get(ataques_inimigos, enemies_atks_keys[i]); 
	var atk_requirements = atk.requirements;
	
	if(array_contains_ext(inimigos_combo, atk_requirements, false)){
		array_push(available_enemies_attacks, atk);
	}

}


function reload_enemies_attacks(){
	var attacks_count = array_length(available_enemies_attacks)
	var enemies_alive = inimigos_vivos;

	for (var i = 0; i < attacks_count; i++){
		var atk = available_enemies_attacks[i];
		var atk_requirements = atk.requirements;

		if (!array_contains_ext(enemies_alive, atk_requirements, true)) {
			array_delete(available_enemies_attacks, i, 1);
		}
	}
}

function determine_closest_arrow_xy_pos(x_center_value, y_center_value, x_distance, y_distance){
	closest_arrow_x = x_center_value + x_distance;
	closest_arrow_y = y_center_value + y_distance;
}


alpha_vignette_high = 0.5;
alpha_vignette_low = 0.2;
alpha_vignette = alpha_vignette_low;


atqs_chave = "";
bullet_timer = 0;
battle_timer = 0;

caixa_mov_pat = "";
fade_in_alpha = 0;


medium_alpha = 0.5;
high_alpha = 0.8;
max_alpha = 1;


// player mini hud

player_hud_height = sprite_get_height(spr_player_hud_inventory);
player_hud_width = sprite_get_width(spr_player_hud_inventory);
portrait_width = sprite_get_width(spr_player_portrait);

highlight_color = #FFD44C;

//part_system_stars = part_system_create(part_stars)
//emitter = part_emitter_create(part_system_stars)


part_system_stars = part_system_create();
part_type_stars = part_type_create();

part_type_sprite(part_type_stars, spr_part_star, true, true, false);
part_type_size(part_type_stars, 1, 1, 0, 0);
part_type_speed(part_type_stars, 1, 1, 0, 0);
part_type_life(part_type_stars, 32, 32);
part_type_blend(part_type_stars, true);
part_type_direction(part_type_stars, 90,90,0, 0)
part_type_alpha2(part_type_stars, 1, 0);

part_emitter_stars = part_emitter_create(part_system_stars);





//part_emitter_region(part_system_stars, part_emitter_stars, x_ini -10, x_ini +10, y_ini -10, y_ini +10, ps_shape_rectangle, ps_distr_linear);

//part_emitter_region(part_system_stars, part_emitter_stars,  x_ini -10, x_ini +10, y_ini -10, y_ini +10, ps_shape_rectangle, ps_distr_linear);
part_emitter_relative(part_system_stars, part_emitter_stars, true)


attack_timer = undefined;
runned_attack_action = false;
item_draw_count = 4;
enemy_attacking = false;
draw_inventory_actions = false;

selected_item = undefined;
inventory_arrow_index = 0;
inventory_arrow_speed = 1;

can_use = true;
inventory_options = ["Sim", "Não"]


enum INVENTORY_DIRECTIONS {
	down,
	up
}

push_inventory_dir = INVENTORY_DIRECTIONS.up;
inventory_draw_from = 0;

caixa_valores = {
	default_box: {
			caixa_tamanho: 215,
			caixa_altura: 100,
			caixa_posicao_x: obj_camera.x/2,
			caixa_posicao_y: obj_camera.y+10

	}
}

current_attack = undefined;
//aqui eu vou ter que criar uma mascara de colisao invertida eu acho...
//


for (var e = 0; e < quant_inimigos_combo; e++){
	if hp_inimigos[e] > 0{
		array_push(inimigos_vivos, inimigos_combo[e])
	}
}

function run_command(_opt){
	switch (_opt){
		case 0:
//		state = BATTLE_STATES.arrow_pattern
		run_arrow_pattern("normal_attack");
		state = BATTLE_STATES.select_enemy;
		
		break;
		
		case 2:
			state = BATTLE_STATES.item_menu;
		break;

		
	}
	
}

function run_arrow_pattern(_attack){
	switch (_attack){
		case "normal_attack":
			var attack_params = variable_struct_get(ataques, _attack)
			show_debug_message(attack_params);
			array_copy(arrow_pat, 0, attack_params.arrow_pattern, 0, array_length(attack_params.arrow_pattern));
			show_debug_message(arrow_pat);
			max_dmg = attack_params.damage;
			vel_setas = attack_params.velocity;
			arrow_timer = arrow_time;
			
			focus_points_amnt_incr = 10;
			focus_points_dest = clamp(round(focus_points + (focus_points_amnt_incr)), 0, 100);
			focus_points = focus_points_dest;
			load_arrow_distance();
		break;
	}
}

function load_enemy_attack(){
	reload_enemies_attacks();
	
	var attacks = available_enemies_attacks;
	var best_attack = undefined;
	var priority = 0;
	for (var i = 0; i < array_length(attacks); i++){
		var atk = attacks[i]
		
		if (atk.priority > priority){
			best_attack = atk;
		}
	}
	
	show_debug_message(available_enemies_attacks)
	caixa_mov_pat = best_attack.limit_box;
	current_attack = best_attack;

	
}


function check_level_up_player(){
	var inst_player = obj_player;
	
	var current_level = inst_player.values.level;
	var current_level_array_control = current_level-1;
	
	var exp_gain = power(current_level, xp_gain_constant);
	var gold_gain = power(current_level, gold_gain_constant);

	var current_xp = inst_player.values.xp; 
	var exp_necessary_next_level = obj_game_manager.level_tiers[current_level_array_control+1];
	
	var level_up_calc = exp_gain + current_xp - exp_necessary_next_level[0];
	
	inst_player.values.gold += gold_gain
	
	if level_up_calc >= 0{
		
		inst_player.values.level++;
		inst_player.values.xp = level_up_calc;
	} else {
		inst_player.values.xp += exp_gain;
	}
	
}

function setup_accuracy_text_draw(params, target_size, arrow_target_x){
	var range_text = 5;
	
	cor_texto_acerto = params[1];
	text_to_draw[0] = params[2]
	text_to_draw[1] = "qualidade_acerto";
	x_texto_acerto = arrow_target_x + range_text + target_size/2;
	dest_x_texto_acerto = arrow_target_x - range_text + target_size/2;
	alpha_txt_acerto = 1
}

function setup_accuracy_text_draw_values(dist_alvo){
	last_closest_arrow_x = closest_arrow_x;
	last_closest_arrow_y = closest_arrow_y;
	
	arrow_feedback_draw = [arrow_pat[arrow_to_draw_from], dist_alvo, local_seta_mais_proxima]
	alpha_feedback = 1
}

function search_for_param_accuracy(dist_alvo, target_size, arrow_target_x, is_missed_arrow = false){
	if is_missed_arrow{
		var params = param_acertar[array_length(param_acertar)-1];
		setup_accuracy_text_draw(params, target_size, arrow_target_x)
		return;
	}
	
	
	for(var i = 0; i < array_length(param_acertar)-1; i++){
		var params = param_acertar[i];
		if dist_alvo < params[0]{
			setup_accuracy_text_draw(params, target_size, arrow_target_x)
			break;
		}
	}
}

function reset_arrow_pattern_vars(arrow_count){
		array_delete(player_arrow_pat,0,arrow_count);
		spawn_setas = obj_camera.x +80;
		arrow_to_draw_from = 0;
}

max_distance_arrow = 100;

function calculate_damage(arrow_count){
	var miss_amount = 0;
	var max_dmg_porc = max_dmg/100;
	var base_dmg = max_dmg
	var total_distance = 0;
	var tolerated_distance = 5
	
	var base_maximum_distance = 100;
		
	for (var i = 0; i < arrow_count; i++){
		if player_arrow_pat[i][0] != arrow_pat[i]{
			miss_amount++;
		} 
		
		if player_arrow_pat[i][1] > tolerated_distance{
			total_distance += player_arrow_pat[i][1];
		}
		
	}
	
	show_debug_message(total_distance);
	
	total_distance = ((total_distance/arrow_count) / base_maximum_distance) * (max_dmg_porc * 30);
	
	var clamped_distance_discount = clamp(total_distance, 0, max_dmg_porc * 30);
	var clamped_dmg_discount = clamp(max_dmg_porc * (10 * miss_amount), 0, max_dmg_porc * 50)
	
	return (round(base_dmg - clamped_distance_discount - clamped_dmg_discount));	
}

function reload_alive_enemies_array(enemy_count){
			array_delete(inimigos_vivos, 0,array_length(inimigos_vivos));
			//percorre adicionando os inimigos se eles estiverem com mais que 0 de vida
			for (var e = 0; e < enemy_count; e++){
				if hp_inimigos[e] > 0{
					array_push(inimigos_vivos, inimigos_combo[e])
				} 
			}
}

//function setup_key_enemy_attack(){
//	inimigos_vivos = scr_ordenar_alf_array(inimigos_vivos);
				
//	var string_array_alive_enemies = "";
			
//	for (var i = 0; i < array_length(inimigos_vivos); i++){
//		string_array_alive_enemies += inimigos_vivos[i];
//		if (i != array_length(inimigos_vivos) -1){
//			string_array_alive_enemies += "_";
//		}
//	}
			
//	//guardamos numa chave o nome dos inimigos ordenados separados por "_" SEMPRE em lowercase.
//	atqs_chave = string_lower(string_array_alive_enemies);
//}

enemy_attack_timer = 0;
enemy_attack_type = undefined;
enemy_attack_duration = undefined;
enemy_attack_finished = false;
setup_enemy_turn = false


function setup_enemy_turn_settings(){
	enemy_attack_type = current_attack.type;
	
	if enemy_attack_type == "time-repeat"{
		enemy_attack_duration = current_attack.duration;
		enemy_attack_timer = current_attack.repeat_frequency;
	}
	
	setup_enemy_turn = true;
}


function go_to_wait_time_state(_next_state){
	var wait_time = 60;
	
	if (_next_state == BATTLE_STATES.enemy_turn){
		wait_time = 120;
	}
	
	state = BATTLE_STATES.wait_time;
	wait_timer = wait_time;
	next_state = _next_state;
}
