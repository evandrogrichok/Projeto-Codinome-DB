depth = DEPTH.LOGIC_OBJECTS

manager_aux_obj = [obj_battle_manager_bg, obj_battle_manager_top];
manager_aux_obj_depths = [DEPTH.LOGIC_BEHIND, DEPTH.LOGIC_TOP];

for (var i = 0; i < array_length(manager_aux_obj); i++){
	if !instance_exists(manager_aux_obj[i]){
		instance_create_depth(0, 0, manager_aux_obj_depths[i], manager_aux_obj[i])
	}
}

scr_can_move_tweaker(-1);

textbox_queue = [new _msg("Cael usou 'Dançar'! Os bonecos de neve parecem estar se lembrando de algo.", "battle_event")];


enum BATTLE_STATES{
	main_menu,
	item_menu,
	hope_menu,
	select_enemy,
	arrow_pattern,
	enemy_turn,
	attacking,
	battle_won,
	wait_time,
	reading_event_textbox
}

enum TXT_TYPES{
	arrow_accuracy,
	enemy_damage
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

if !(layer_exists("FX_BATTLE")){
	layer_create(DEPTH.LOGIC_TOP +1, "FX_BATTLE")
}
if !(layer_exists("FX_BATTLE_OBJ")){
	layer_create(DEPTH.LOGIC_OBJECTS, "FX_BATTLE_OBJ")
}

global.part_sys_points = part_system_create_layer("FX_BATTLE", false);
global.part_emitter_points = part_emitter_create(global.part_sys_points);
global.part_type_points = part_type_create();
global.point_part_colors = [ #fcfcfc, #ff2887, #54ecec];
part_type_sprite(global.part_type_points, spr_particle_hope, false, false, false);
part_type_size(global.part_type_points, 1, 1 , 0, false);
part_type_life(global.part_type_points, 20, 40);
part_type_blend(global.part_type_points, true);
part_type_alpha3(global.part_type_points, 1, 1, 0);
part_type_colour1(global.part_type_points, c_aqua);
part_type_direction(global.part_type_points, 0, 360, 0, 0);
part_emitter_relative(global.part_sys_points, global.part_emitter_points, false);


arrow_target_x = obj_camera.x;
highlight_color = #FFD44C;
part_sys_arrow = part_system_create_layer("FX_BATTLE_OBJ", false);
part_emitter_arrow = part_emitter_create(part_sys_arrow);
part_type_arrow = part_type_create();
part_type_sprite(part_type_arrow, spr_particle_hope, false, false, false);
part_type_size(part_type_arrow, 1.5, 2 , 0, false);
part_type_life(part_type_arrow, 50, 70);
part_type_alpha3(part_type_arrow, 1, 1, 0);
part_type_colour1(part_type_arrow, #FFDB67);
part_type_blend(part_type_arrow, false);
part_type_direction(part_type_arrow, 0, 360, 0, 0);
part_type_speed(part_type_arrow, 1.4, 1.6, -0.05, 0);
part_emitter_relative(part_sys_arrow, part_emitter_arrow, false);
part_emitter_region(part_sys_arrow, 0, arrow_target_x, arrow_target_x, obj_camera.y, obj_camera.y, pt_shape_square, ps_distr_gaussian);



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

file = file_text_open_read("musicas.json");
json_string = "";
while (!file_text_eof(file)) {
    json_string += file_text_read_string(file);
    file_text_readln(file);
}
file_text_close(file);

data = json_parse(json_string);
music_data = data;

music_parameters = music_data.Main

show_debug_message(music_parameters.time_signature)

beat = 0;
bar = 0;

gain_arrow_hit = 0;

per_bar_beat = 4;

snd_id_arrow_hit = undefined;
can_run_attack_script = false;
function count_beat(){
	var ts = variable_struct_get(music_parameters, "time_signature")
switch (ts){
	case "4/4":
	per_bar_beat = 4
	
	can_run_attack_script = true;
	beat++;
	if beat == per_bar_beat{
	count_bar(ts)
	}
	beat = (beat + per_bar_beat) mod per_bar_beat;
	show_debug_message("Beat!")
	break;
}
	call_beat_functions();
}
function count_bar(ts){
	bar++;
}


function call_beat_functions(){
	if state == BATTLE_STATES.arrow_pattern{
	if beat != 0{
		audio_play_sound(snd_c, 5, false, 1.2);
	} else {
		audio_play_sound(snd_c, 5, false, 1.2, 0, 1.1225);
	}
	}
	screen_effects()
}

// preciso descobrir qual é a distancia que a seta tem que estar, somando uma a beat + o que falta pra beat atual acabar.
ts_index_increase = undefined;


alpha_vignette_beat = 0;
color_vignette_beat = c_white;

vignette_beat_colors = [ #95e6ff, #4eb4ff, #85ffcc]

function screen_effects(){
	var idx = irandom(array_length(vignette_beat_colors) -1);
	
	color_vignette_beat = vignette_beat_colors[idx]
	alpha_vignette_beat = .8;
};



bpm_seconds = time_bpm_to_seconds(music_parameters.bpm)
show_debug_message(bpm_seconds)
//time_source_spb = time_source_create(time_source_game, bpm_seconds, time_source_units_seconds, function(){with (self){ count_beat()}},[undefined],-1)
//time_source_start(time_source_spb);
//time_source_sphb = time_source_create(time_source_game, bpm_seconds*2, time_source_units_seconds, function (){show_debug_message("PAR"); show_debug_message(beat); }, [undefined],-1)
//time_source_start(time_source_sphb);
//time_source_sfx_arrow = time_source_create(time_source_game,  time_source_get_time_remaining(time_source_spb), time_source_units_seconds, function(){audio_play_sound(snd_arrow, 5, false, 2)});


mus = audio_play_sound(snd_stardust, 10, true, .8);

function play_arrow_sfx(correct_input, dist){
	var song_current_time = audio_sound_get_track_position(mus);
	var float_beat = song_current_time/bpm_seconds;
	var current_beat = 
	(song_current_time/bpm_seconds);
	var diff_sec = (current_beat - float_beat) * bpm_seconds;
	var sound_to_play = param_acertar[last_param_index][3];
	var perfect_distance_range = param_acertar[0][0]
	
	
	if (diff_sec>0 && dist <= perfect_distance_range){
		var ts_sfx = time_source_create(time_source_game, diff_sec, time_source_units_seconds, function(){audio_play_sound(snd_arrow, 5, false, 2)});
		time_source_start(ts_sfx);
	} else {
		audio_play_sound(sound_to_play, 5, false, 2);
	}
} 


can_lower_dmg_txt_alpha = false;
//Vm = ΔS / Δt

pitch_arrow = 1;


duracao = 0;
tempo_inicio = 0;
state_num = 6;

cam_w = camera_get_view_width(view_camera[0]);
cam_h = camera_get_view_height(view_camera[0]);

arrow_sprite_width = sprite_get_width(spr_button_fight_pt);
arrow_sprite_height = sprite_get_height(spr_button_fight_pt);

sprite_player_hud_height = sprite_get_height(spr_player_hud);
target_size = 20;
padding_between_arrows = 10;

xyvar = [
	[0, -1],
	[0,  1],
	[-1, 0],
	[1,  0]
]

target_rot_effect = 0;

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

black_player_col_enemy_turn = 255;
black_bg_color_alpha = 0;

//futuramente adicionar nesse array o texto em ingles também, que no for vai ser scaneado com uma variavel global de definicao de linguagem
//sempre deixar os parametros de erro como errou!
enum ARRAY_PARAM_INDEXES{
	distance,
	color,
	string_param,
	sound,
	dmg_value_mult
}

param_acertar = [
	[3, #0cf2cc, "perfeito!", snd_arrow, 1],
	[6, #35e8a7, "ótimo!", snd_arrow, .8],
	[10, #b8ff96, "ok", snd_arrow, .5],
	[1000, #fff896, "longe...", snd_arrow_miss, .2],
	[-1, #f56464, "errou...", snd_arrow_miss, .2]
]

x_lim_setas = -(cam_h/2 - 20);
default_height_textbox_battle = 40;
dest_height_textbox_battle = default_height_textbox_battle;
height_textbox_battle = default_height_textbox_battle;
arrow_pat = []; // armazena no padrão de setas correto.
vel_setas = 0;
player_arrow_pat = [];// armazena o input do player
inst_player_tweak = false;
text_to_draw = ["", ""] // [VALOR, TIPO DE TEXTO P/ DESENHAR];
text_final_x_position = 0;
text_initial_x_position = 0;

wait_timer = 0;
next_state = undefined;
mostrar_limites_de_movimentacao = false;


position_player = array_create(state_num, array_create(2,0));
position_player[0] = [obj_camera.x - 75,  round(obj_camera.y - height_textbox_battle/2)];
spawn_setas = obj_camera.x +80;
local_seta_mais_proxima = 0;

flag_atacando = false
obj_player.sprite_index = spr_player_idle_battle;

scr_can_move_tweaker(-1);

state = BATTLE_STATES.main_menu;

opt = 0;
last_opt = undefined;

obj_camera.fixated_camera = true;

options = [
	["fight",spr_button_fight_en],
	["hope",spr_button_hope_en],
	["item",spr_button_item_en],
	["defend",spr_button_defend_en],
]

option_count = array_length(options);
setted_up_lang = false;

function setup_lang(){
	options = [
		["fight", asset_get_index("spr_button_fight_" + string(global.LANG))],
		["hope", asset_get_index("spr_button_hope_" + string(global.LANG))],
		["item", asset_get_index("spr_button_item_" + string(global.LANG))],
		["defend", asset_get_index("spr_button_defend_" + string(global.LANG))]
	]
}

opt_height = sprite_get_height(spr_button_item_pt)
	
//}


larg_barra_hp = 25;
larg_out_hp = larg_barra_hp + 2;
altura_barra_hp = 3;
altura_out_hp = altura_barra_hp+2;

sin_t = 0;
arrow_timer = 0;
arrow_time = 60;
arrow_to_draw_from = 0;
arrow_feedback_draw = ["",0];
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
alpha_txt_to_draw = 1;
text_to_draw_color = 0;
can_draw_texto_acerto = false;
shake_level = 0;

default_attack_text_hsv = [
	[115, 0, 255],
	[120, 0, 255]
];
dest_attack_text_hsv = [
	[155, 255, 255],
	[130, 255, 255]
];

hue_attack_text =  [default_attack_text_hsv[0][0], default_attack_text_hsv[1][0]];
sat_attack_text =  [default_attack_text_hsv[0][1], default_attack_text_hsv[1][1]];
val_attack_text =  [default_attack_text_hsv[0][2], default_attack_text_hsv[1][2]];

rot_text =  0;
rot_text_dest =  0;
size_text_default =  1;
size_text_big =  1.25;
size_text = size_text_default;

//arrow_x_distance = 0;


//carrega adversario(s)
adversario = combinacao_inimigos.combo1;
enemy_sentences = adversario.enviromental_sentences_ids;

//armazena os adversarios 
inimigos_combo = adversario.enemies;


var quant_inimigos_combo = array_length(inimigos_combo);
//guarda a vida, sprites,... de cada um dos inimigos do combo
parametros_inimigos = array_create(quant_inimigos_combo);
hp_inimigos = array_create(quant_inimigos_combo);
enemies_enviromental_sentences = array_create(quant_inimigos_combo);
nomes_inimigos = array_create(quant_inimigos_combo);
show_debug_message(inimigos_combo)
sprite_ini = [];
sprite_ini_dmg = [];
sprite_ini_atk = [];
sprite_ini_pur = [];

width_pct = array_create(quant_inimigos_combo, undefined);


for (var i = 0; i < quant_inimigos_combo; i++){
	parametros_inimigos[i] = variable_struct_get(dados_inimigos, inimigos_combo[i]);
	hp_inimigos[i] = parametros_inimigos[i].hp;
	nomes_inimigos[i] = parametros_inimigos[i].enemy_name;
	var sprite = asset_get_index(parametros_inimigos[i].sprite)
	ini_sprites_altura = array_create(quant_inimigos_combo, sprite_get_height(sprite))
	
	sprite_ini[i] = parametros_inimigos[i].sprite
	sprite_ini[i] = asset_get_index(sprite_ini[i]);
	
	sprite_ini_dmg[i] = parametros_inimigos[i].sprite_dmg
	sprite_ini_dmg[i] = asset_get_index(sprite_ini_dmg[i])
	
	sprite_ini_atk[i] = parametros_inimigos[i].sprite_atk
	sprite_ini_atk[i] = asset_get_index(sprite_ini_atk[i])
		
	sprite_ini_pur[i] = parametros_inimigos[i].sprite_pur
	sprite_ini_pur[i] = asset_get_index(sprite_ini_pur[i])
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
fade_away = 3;
seta_index = 0;
seta_speed = 1;

inimigos_vivos = [];


closest_arrow_x = undefined;
closest_arrow_y = undefined;
last_closest_arrow_x = closest_arrow_x
last_closest_arrow_y = closest_arrow_x

available_enemies_attacks = array_create(0);
var enemies_atks_keys = variable_struct_get_names(ataques_inimigos);
var count_enemies_atks = array_length(enemies_atks_keys);

function load_arrow_distance(){
	individual_arrow_time = [];
	pattern_start_time = ceil(audio_sound_get_track_position(mus)/bpm_seconds) *bpm_seconds; //pega o tempo exato da musica do proximo beat no momento que a função é executada
	var arrow_offset = 4; // quantidade de beats iniciais de espaço
	
	for(var i = 0; i < array_length(arrow_pat); i++){
		individual_arrow_time[i] = pattern_start_time + (i + arrow_offset) * bpm_seconds; // aqui ele pega o tempo exato da proxima beat + a quantidade de beats desejada
																					  	  // a mais + incrementação de beats por indice
	}
	

}


show_debug_message(variable_struct_get(ataques_inimigos, enemies_atks_keys[0]))


//SETUP INICIAL DOS ATAQUES DISPONÍVEIS. =====
for (var i = 0; i < count_enemies_atks; i++){

	var atk = variable_struct_get(ataques_inimigos, enemies_atks_keys[i]); 
	var atk_requirements = atk.requirements;


	if(array_contains_ext(inimigos_combo, atk_requirements, false)){
		array_push(available_enemies_attacks, atk);
	}
}

function determine_closest_arrow_xy_pos(x_center_value, y_center_value, x_distance, y_distance){
	closest_arrow_x = x_center_value + x_distance;
	closest_arrow_y = y_center_value + y_distance;
}

dmg_copy_string = "";
index_dmg = 0;

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

//layer_create(-16000, "Effects_On_Top");

//part_system_hope = part_system_create_layer("Effects_On_Top", true);
//part_type_hope = part_type_create();

//part_type_sprite(part_type_hope, spr_particle_hope, false, false, false);
//part_type_size(part_type_hope, 1, 1.2, .1, 0);
//part_type_speed(part_type_hope, 1, 1, 0, 0);
//part_type_life(part_type_hope, 32, 32);
//part_type_blend(part_type_hope, false);
//part_type_direction(part_type_hope, obj_player.hope_dir,obj_player.hope_dir,1, 10)
//part_type_alpha2(part_type_hope, 1, 0);

//part_emitter_hope = part_emitter_create(part_system_hope);

//part_emitter_relative(part_system_hope, part_emitter_hope, true)
alpha_options = array_create(option_count, 1);
draw_away_hp_bar = 0;
ene_dist_y = 20;
attack_timer = undefined;
runned_attack_action = false;
item_draw_count = 4;
enemy_attacking = false;
draw_inventory_actions = false;

selected_item = undefined;
inventory_arrow_index = 0;
inventory_arrow_speed = 1;

enemy_name_appear_px_num = 10
enemy_name_appear_effect = enemy_name_appear_px_num;
can_use = true;
inventory_options = ["Sim", "Não"]


enum INVENTORY_DIRECTIONS {
	down,
	up
}
last_param_index = undefined;
push_inventory_dir = INVENTORY_DIRECTIONS.up;
inventory_draw_from = 0;

caixa_valores = {
	default_box: {
			caixa_tamanho: 215,
			caixa_altura: 100,
			caixa_posicao_x: obj_camera.x-30,
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
		state = BATTLE_STATES.select_enemy;
		enemy_name_appear_effect = 20;
		alpha_barra_ini = 1;
		
		break;
		
		case 2:
			state = BATTLE_STATES.item_menu;
				for (var i = 0; i < option_count; i++){
				var alpha = 0.6
				if (i == 2){
					alpha = 1;
				}
				alpha_options[i] = alpha; 
			}
			obj_game_menu.state = MENU_STATES.item_menu_battle
			obj_game_menu.item_substate = ITEM_SUBSTATES.selecting
		break;

		
	}
	
}

function add_dance_points(amount){
	focus_points_amnt_incr = amount;
	focus_points_dest = clamp(round(focus_points + (focus_points_amnt_incr)), 0, 100);
	focus_points = focus_points_dest;
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
			
			add_dance_points(10);

			load_arrow_distance();
		break;
	}
}



function load_enemy_attack(){
	
	reload_alive_enemies_array()
	
	var available_atks = [];

	for(var i = 0; i < array_length(available_enemies_attacks); i++){
		var current_atk = available_enemies_attacks[i];
		var req = current_atk.requirements;
		
		var can_use_attack = true;
		
		for (var r = 0; r < array_length(req); r++){
			if (!array_contains(inimigos_vivos, req[r])){
				can_use_attack = false;
			}
		}
		
		if(can_use_attack){
			array_push(available_atks, current_atk)
		}
	}
	
	var best_attack = undefined;
	var max_priority = -9999;
	
	if (array_length(available_atks) == 0) {
        show_error("Nenhum ataque possível encontrado!", false);
        return;
    }
	
	for (var i = 0; i < array_length(available_atks); i++){
        var atk = available_atks[i];
        
        if (atk.priority > max_priority){
            max_priority = atk.priority;
            best_attack = atk;
        }
    }
	
	
	if (best_attack != undefined) {
        show_debug_message("Ataque escolhido: " + string(best_attack));
        caixa_mov_pat = best_attack.limit_box;
        current_attack = best_attack;
    }	
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

time_source_alpha_control = undefined;
blink_dmg = true;

function reset_text_to_draw(txt_type){
	switch(txt_type){
		case TXT_TYPES.arrow_accuracy:
		text_to_draw = ["",""]
		
		break;
		case TXT_TYPES.enemy_damage:
		text_to_draw = ["",""]
		can_lower_dmg_txt_alpha = false;
		blink_dmg = true;
		break;
	}
}

function setup_text_draw(text, txt_type, color = undefined){
	text_to_draw_color = color;
	text_to_draw[0] = text;
	text_to_draw[1] = txt_type;
	
	switch(txt_type){
	case TXT_TYPES.arrow_accuracy:
		var range_text = 5
		text_initial_x_position = arrow_target_x + range_text;
		text_final_x_position = arrow_target_x;
		
		var rot_range = 5
		rot_text_dest = choose(rot_range, -rot_range)
		rot_text =  0;
		
		size_text = size_text_default
		
		alpha_txt_to_draw = 1
	
	break;
	case TXT_TYPES.enemy_damage:
		range_text = 8;
		alpha_txt_to_draw = 1
		
		can_lower_dmg_txt_alpha = false;
		
		text_initial_x_position = x_inimigo[opt] + range_text;
		text_final_x_position = x_inimigo[opt] - range_text;
		
		hue_attack_text =  [default_attack_text_hsv[0][0], default_attack_text_hsv[1][0]];
		sat_attack_text =  [default_attack_text_hsv[0][1], default_attack_text_hsv[1][1]];
		val_attack_text =  [default_attack_text_hsv[0][2], default_attack_text_hsv[1][2]];
		

		
		time_source_alpha_control = time_source_create(time_source_game, 1, time_source_units_seconds, function(){with (self){ can_lower_dmg_txt_alpha = true}})
		time_source_start(time_source_alpha_control);
		time_source_blink_dmg = time_source_create(time_source_game, 1, time_source_units_frames, function(){with (self){ blink_dmg = false}})
		time_source_start(time_source_blink_dmg);
		
		
		rot_range = 10
		rot_text_dest = choose(rot_range, -rot_range)
		rot_text =  0;
		
		size_text = size_text_default
		
		scale_pop_effect = array_create(string_length(text_to_draw[0]), - size_text);
		

	break;
	}

	
}

function draw_arrow_feedback(dist_alvo){
	last_closest_arrow_x = closest_arrow_x;
	last_closest_arrow_y = closest_arrow_y;
	
	arrow_feedback_draw = [arrow_pat[arrow_to_draw_from], dist_alvo]
	alpha_feedback = 1
}
		function draw_enemy_name_and_percentage(i, draw_away = 0, alpha = alpha_barra_ini){
				var max_hp = parametros_inimigos[i].hp;
	var nome = string_upper(parametros_inimigos[i].enemy_name);
	var off_y_arrow = 17;
	
					var max_width_name = string_width(return_longest_word(nome));
					var pct = clamp(round(((max_hp - hp_inimigos[i]) / max_hp) * 100), 0, 100)
					var scale_pct = 1.5;
					var sprite_height_enemy = sprite_get_height(sprite_ini[i]);
					var sprite_width_enemy = sprite_get_width(sprite_ini[i]);
					var percentage_text = (string(pct) + "%")
					var width_percentage_update = string_width(percentage_text)* scale_pct
			
			
			if !is_real(width_pct[i]){
		
				width_pct[i] = width_percentage_update
			} else {
				width_pct[i] = lerp(width_pct[i], width_percentage_update, .1);
			}
			var name_and_porcentage_x = x_inimigo[i] - width_pct[i] - sprite_width_enemy/2 - padding_hp_bar_and_enemy

	
			draw_set_valign(fa_middle)
			draw_angled_text(percentage_text, name_and_porcentage_x +draw_away, y_inimigo[i]- sprite_height_enemy/2, max_width_name, #ff2887, #ff2887, #ff7928, #ff7928, alpha, scale_pct, scale_pct);
			if opt == i{
				draw_angled_text(nome, name_and_porcentage_x - padding_hp_bar_and_enemy - max_width_name + enemy_name_appear_effect + draw_away, y_inimigo[i] - sprite_height_enemy/2, max_width_name, #ff2887, #ff2887, #ff7928, #ff7928, alpha, 1, 1, 1);
			}
			draw_set_valign(fa_bottom)
		}

function search_for_param_accuracy(dist_alvo, is_missed_arrow = false){
	if is_missed_arrow{
		return param_acertar[array_length(param_acertar)-1];
	}
	
	
	for(var i = 0; i < array_length(param_acertar)-1; i++){
		var params = param_acertar[i];
		if dist_alvo < params[0]{
			last_param_index = i;
			return param_acertar[i]
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
	var base_dmg = max_dmg;
	var per_arrow_dmg = max_dmg/arrow_count;
	var total_dmg = 0;
	
	
	
		
	for (var i = 0; i < arrow_count; i++){
		total_dmg += per_arrow_dmg * player_arrow_pat[i][2]; //  player_arrow_pat[2] é o multiplicador
		
	}
	
	
	return (round(total_dmg));	
}

function reload_alive_enemies_array(){
			
			enemy_count = array_length(inimigos_combo)
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

enum TEXTBOX_PROPERTIES{
	is_visible,
	is_created,
}

function toggle_textbox(property, value){
	switch(property){
	case TEXTBOX_PROPERTIES.is_visible:
		main_textbox_id.visible = value
	break;
	
	case TEXTBOX_PROPERTIES.is_created:
		if value == true{
			main_textbox_id = scr_open_textbox(textbox_chat_id);
			dest_height_textbox_battle = default_height_textbox_battle
		} else 
		if value == false{
			instance_destroy(main_textbox_id);
			dest_height_textbox_battle = 0;
		}
	break;
	}
}

chosen_index = 0;

textbox_chat_id = enemy_sentences[chosen_index]


enum ENEMIES_DRAW_STATES{
	cursed,
	purified
}


function next_enviroment_sentence(){
	chosen_index++;
	chosen_index = (chosen_index + array_length(enemy_sentences)) % array_length(enemy_sentences);
	chosen_index = clamp(chosen_index, 1, array_length(enemy_sentences))
	textbox_chat_id = enemy_sentences[chosen_index]
}


main_textbox_id = scr_open_textbox(textbox_chat_id);
load_enemy_attack()


function enemy_is_defeated(i){

	
	var vel_draw_away = 5;
	var x_ini = x_inimigo[i] + vel_draw_away * draw_away;
	var y_ini = y_inimigo[i] - vel_draw_away - sin(sin_t*3.5) * 5;
			
	part_emitter_region(part_system_stars, part_emitter_stars, x_ini -10, x_ini +10, y_ini -10, y_ini +10, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(part_system_stars, part_emitter_stars, part_type_stars, 20);
			
	draw_sprite_ext(sprite_ini_pur[i], enemies_index[i], x_ini, y_ini, 1, 1, 0, c_white, fade_away);

}

	function define_enemy_position(i, cam_x, cam_y){
		if enemy_count == 1{ // se houver 1 só, fica centralizado,
			x_inimigo[i] = cam_x + cam_w/3
			y_inimigo[i] = cam_y - height_textbox_battle/2;
		} else { //senão, ele faz calculos
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
	}
	
		padding_hp_bar_and_enemy = 20;
		function draw_hp_bar_enemy(i, max_hp, draw_away = 0, alpha = alpha_barra_ini){
			
	
			var pct = (hp_inimigos[i] / max_hp);
			var height_sprite = sprite_get_height(spr_bar_enemy_pure);
			var width_sprite = sprite_get_width(spr_bar_enemy_pure);
			
			var bar_x = x_inimigo[i] - padding_hp_bar_and_enemy;
			var bar_y = y_inimigo[i] - height_sprite;
			
			pct = (hp_inimigos[i] / max_hp);
			
			draw_sprite_part_ext(spr_bar_enemy_pure, 0, 0, clamp(pct * height_sprite, 0, height_sprite), width_sprite, height_sprite, bar_x + draw_away, bar_y + clamp(pct * height_sprite, 0, height_sprite), 1, 1, c_white, alpha);
			draw_sprite_part_ext(spr_bar_enemy_cons, 0, 0, 0, width_sprite, (pct * height_sprite),bar_x + draw_away, bar_y, 1, 1, c_white, alpha);
			//draw_sprite_stretched_ext(spr_outline_enemy_hb,0, x_inimigo[i] - larg_out_hp/2 - larg_barra_hp, y_inimigo[i] - sprite_get_height(sprite_ini) - altura_out_hp+1, larg_out_hp, altura_out_hp, c_white,alpha_barra_ini)
			//draw_sprite_stretched_ext(spr_healthbar_enemy,0, bar_x + 1, bar_y, altura_barra_hp, pct * 31, #54003e,alpha_barra_ini)
		}
		
		function lower_alpha_enemy_bar(){
				if state == BATTLE_STATES.attacking
					return;
				if state == BATTLE_STATES.select_enemy
					return;
				if state == BATTLE_STATES.arrow_pattern
					return;
					
				alpha_barra_ini -= 0.03;
		}
		
		
function draw_angled_text(_string, _x, _y, max_width, c1, c2, c3, c4, alpha, x_scale= 1, y_scale = 1, sin_mult = 0, per_char_add_y = -1, line_break_height = 10){
	

	per_char_added_width = 0
	line_break = 0;
	per_char_add_y_total = 0;
	

	
	for (var i = 0; i < string_length(_string); i++){
	var char =  string_copy(_string, i+1, 1)
	

		
		show_debug_message(per_char_added_width);
	
	draw_text_transformed_colour(_x + per_char_added_width, _y + per_char_add_y_total + line_break * line_break_height + sin(sin_t)*sin_mult, char, x_scale, y_scale, 0, c1, c2, c3, c4, alpha);
	per_char_added_width += string_width(char) * x_scale;
	
	if per_char_added_width > max_width && char == " "{

		per_char_added_width = 0;
		per_char_add_y_total = 0;
		line_break++;
		continue;
	}
	per_char_add_y_total += per_char_add_y;


}


}

function return_longest_word(_string){
var current_word = "";
var longest_word = "";
var longest_word_length = 0;
var current_word_length = 0;
	for (var i = 0; i < string_length(_string); i++){
		var char = string_copy(_string, i+1, 1);
		if char == " "{
			if current_word_length > longest_word_length{
				longest_word = current_word;
				longest_word_length = current_word_length;
			}
			current_word = "";
			current_word_length = 0;
			continue;
		}
		
			current_word += char;
			current_word_length ++;
			
	}
	
	
			if current_word_length > longest_word_length{

				longest_word = current_word;
				longest_word_length = current_word_length;
			}
	return longest_word;
}

function add_textbox_queue(_message){
	array_push(textbox_queue, _message);
}

//scr_open_textbox_custom(textbox_queue);
function run_queue_textbox(){

}