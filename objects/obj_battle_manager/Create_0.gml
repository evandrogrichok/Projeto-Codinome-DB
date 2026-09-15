depth = DEPTH.LOGIC_OBJECTS

inst_player = get_instance("player");
inst_camera = get_instance("camera");

ataques             = load_json_file("attacks.json");
dados_inimigos      = load_json_file("enemies.json");
combinacao_inimigos = load_json_file("enemy_pattern.json");
ataques_inimigos    = load_json_file("enemies_attacks.json");
music_data          = load_json_file("musicas.json");
area_properties     = global.areas_properties[$ global.current_area];

if (
is_undefined(ataques) ||
is_undefined(dados_inimigos) ||
is_undefined(combinacao_inimigos) ||
is_undefined(ataques_inimigos) ||
is_undefined(music_data)
) 
{
    show_debug_message("Erro crítico: Falha ao carregar arquivos de dados!");
}

arrow_max_distance =  camera_get_view_height(view_camera[0])/2 - sprite_get_width(spr_seta_down); 
arrows_alpha = [];
arrow_speed_effect = [];
arrow_stretch_effect = [];
arrow_shine_effect = [];
arrow_shine_index = [];
arrow_shine_speed = .5;
arrow_sprite_transform = 0;
increase_target_size = 1;
blink_arrow_effect_time = 5;
blink_arrow_effect_timer = 0;





party[0] = {
	id : CHARACTERS.drio,
	name : "Drio",
	attack_minigame : run_arrow_pattern
	}
	
//party[1] = {
//	id : CHARACTERS.glint,
//	name : "Glint",
//	attack_minigame : run_arrow_pattern
//	}
	
//party[2] = {
//	id : CHARACTERS.avery,
//	name : "Avery",
//	attack_minigame : run_arrow_pattern
//	}
	
battle_actions = [];
current_party_member = 0;
party_member_number = array_length(party);
current_action = undefined;

enum CHARACTERS {
	drio,
	glint,
	avery
}

enum ACTIONS {
	ATTACK,
	POWER,
	ITEM,
	DEFEND
	
}


function battle_action(_actor, _action, _target, _item, _power) constructor {

	actor = _actor;
	action = _action;
	target = _target;
	used_item = _item;
	slected_power = _item;

}

function sort_battle_actions(_actions)
{
    var sorted = [];
    
    var order = [
        ACTIONS.DEFEND,
        ACTIONS.ATTACK,
        ACTIONS.POWER,
        ACTIONS.ITEM
    ];
    
    for (var i = 0; i < array_length(order); i++)
    {
        var action_type = order[i];
        
        for (var j = 0; j < array_length(_actions); j++)
        {
            if (_actions[j].action == action_type)
            {
                array_push(sorted, _actions[j]);
            }
        }
    }
    
    return sorted;
}


last_used_item = undefined;


manager_aux_obj = [obj_battle_manager_bg, obj_battle_manager_top];
manager_aux_obj_depths = [DEPTH.LOGIC_BEHIND, DEPTH.LOGIC_TOP];

for (var i = 0; i < array_length(manager_aux_obj); i++){
	if !instance_exists(manager_aux_obj[i]){
		instance_create_depth(0, 0, manager_aux_obj_depths[i], manager_aux_obj[i])
	}
}

scr_can_move_tweaker(-1);
adversario = combinacao_inimigos.combo1;
encounter_dialogue = adversario.encounter_dialogue;

on_beat_messages = {
    pt: [
        "Na batida!",
        "Boa!",
        "Isso!",
        "Perfeito!",
        "Suave!",
        "Hit!",
        "Mandou bem!",
        "Nice!"
    ],
    
    en: [
        "On beat!",
        "That's it!",
        "Hit!",
        "Look at you!",
        "Nice!",
        "Perfect!",
        "Smooth!"
    ]
}




textbox_queue = [];
textbox_index = 0;


//inst_player = obj_player;

spd_fp_draw = 0.25;
textbox_num = 0;

function add_message_to_queue(new_message){
	array_push(textbox_queue, new_message);
}

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
	textbox_event,
	reading_event_textbox,
	transition_enemy_turn,
	transition_main_menu,
	power_menu,
	transition_battle_won,
	attacking_power,
	execute_actions
}

enum TXT_TYPES{
	arrow_accuracy,
	enemy_damage,
	on_beat
}

max_focus_points = 100;
focus_points = 100;
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


arrow_target_x = inst_camera.x;
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


function emmit_arrow_particles(){
	part_emitter_region(part_sys_arrow, 0, arrow_target_x, arrow_target_x, arrow_target_y, arrow_target_y, pt_shape_square, ps_distr_gaussian);
	part_type_colour1(part_type_arrow, param_acertar[last_param_index][1]);
	part_emitter_burst(part_sys_arrow, 0, part_type_arrow, 20);
}



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

vignette_beat_colors = [ area_properties.ui_primary_colors[0]];

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


mus = audio_play_sound(snd_stardust, 10, true, .0);

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

function check_if_on_beat(){
	var current_music_time = audio_sound_get_track_position(mus);
	show_debug_message("CURRENT music time: " + string(current_music_time))
	var min_range = beat_time - (bpm_seconds/2);
	var max_range = beat_time + (bpm_seconds/2);
		show_debug_message("min: " + string(min_range))
		show_debug_message("max: " + string(max_range))
	if (current_music_time >= min_range && current_music_time <= max_range){
	
	show_debug_message("NA BATIDA")
	return true;

	}
	
	return false;
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

default_max_width_angled_text = 512;
scale_pct = 1.5;

xyvar = [
	[0, -1],
	[0,  1],
	[-1, 0],
	[1,  0]
]

target_rot_effect = 0;



player_dance_sprites = [
	spr_player_dance_0,
	spr_player_dance_1,
	spr_player_dance_2,
	spr_player_dance_3
]

last_random_dance_sprite = undefined;
random_dance_sprite = undefined;

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

//IMPLEMENTAR: futuramente adicionar nesse array o texto em ingles também, que no for vai ser scaneado com uma variavel global de definicao de linguagem
//sempre deixar os parametros de erro como errou!
enum ARRAY_PARAM_INDEXES{
	distance,
	color,
	string_param,
	sound,
	dmg_value_mult
}


var p = area_properties.ui_primary_colors;
var s = area_properties.ui_secondary_colors;
param_acertar = [
	[3, p[0], "perfeito!", snd_arrow, 1],
	[6, merge_colour(p[0], p[1], .5), "ótimo!", snd_arrow, .8],
	[10, p[1], "ok", snd_arrow, .5],
	[1000, s[1], "longe...", snd_arrow_miss, .2],
	[-1, s[0], "errou...", snd_arrow_miss, .2]
]

x_lim_setas = -(cam_h/2 - 20);
default_height_textbox_battle = 50;
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


//position_player = array_create(state_num, array_create(2,0));
//position_player[0] = [inst_camera.x - 75,  round(inst_camera.y - height_textbox_battle/2)];
player_initial_position = [inst_camera.x - (inst_camera.x/5)*3, inst_camera.y - inst_camera.y/5*2];
spawn_setas = inst_camera.x +80;
local_seta_mais_proxima = 0;

flag_atacando = false
inst_player.sprite_index = spr_player_idle_battle;

scr_can_move_tweaker(-1);

state = BATTLE_STATES.main_menu;

opt = 0;
last_opt = undefined;

inst_camera.fixated_camera = true;

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

opt_count = array_length(options);

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

enemy_sentences = adversario.environmental_sentences_ids;

//armazena os adversarios 
enemies_combo = adversario.enemies;
enemy_count = array_length(enemies_combo)

//guarda a vida, sprites,... de cada um dos inimigos do combo



enemies_data = array_create(enemy_count);
parametros_inimigos = array_create(enemy_count);
hp_inimigos = array_create(enemy_count);
enemies_enviromental_sentences = array_create(enemy_count);
nomes_inimigos = array_create(enemy_count);
show_debug_message(enemies_combo)
sprite_ini = [];
sprite_ini_dmg = [];
sprite_ini_atk = [];
sprite_ini_pur = [];

width_pct = array_create(enemy_count, undefined);


for (var i = 0; i < enemy_count; i++){
	var data_enemies = variable_struct_get(dados_inimigos, enemies_combo[i])
	
	enemies_data[i] = {
		//read only data
		hp_max : data_enemies.hp,
		enemy_name : data_enemies.enemy_name,
		defense_points : data_enemies.defense_pts,
		sprite_ini : asset_get_index(data_enemies.sprite),
		sprite_ini_dmg : asset_get_index(data_enemies.sprite_dmg),
		sprite_ini_atk : asset_get_index(data_enemies.sprite_atk),
		sprite_ini_pur : asset_get_index(data_enemies.sprite_pur),

		
		//modifiable data
		current_hp : data_enemies.hp
		
	}
	
}


x_inimigo = array_create(enemy_count);
y_inimigo = array_create(enemy_count);

old_player_xy =[0,0]
next_enemy_to_attack = 0;
alpha_barra_ini = 0;
enemies_speed = array_create(enemy_count, 1);
enemies_index = array_create(enemy_count, 0);
enemies_index_atk = array_create(enemy_count, 0);
enemies_draw_defeat_state = array_create(enemy_count, 0);
draw_away = array_create(enemy_count, 0);
fade_away = array_create(enemy_count, 3);
pct_enemy_purify = array_create(enemy_count, 0);
percentage_text_enemy = array_create(enemy_count, "0%");

power_menu_width = 100;
power_menu_height = 100;


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





//SETUP INICIAL DOS ATAQUES DISPONÍVEIS. =====
for (var i = 0; i < count_enemies_atks; i++){

	var atk = variable_struct_get(ataques_inimigos, enemies_atks_keys[i]); 
	var atk_requirements = atk.requirements;


	if(array_contains_ext(enemies_combo, atk_requirements, false)){
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



height_focus_points_hud = 6;
padding_hud = 5;

player_hud_height = sprite_get_height(spr_player_hud_inventory);
full_hud_height = sprite_get_height(spr_player_hud_inventory) + height_focus_points_hud + padding_hud;
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
//draw_away_hp_bar = 0;
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
			caixa_posicao_x: inst_camera.x-30,
			caixa_posicao_y: inst_camera.y+10

	}
}

current_attack = undefined;
//aqui eu vou ter que criar uma mascara de colisao invertida eu acho...
//

draw_set_font(fnt_main);
for (var i = 0; i < enemy_count; i++){
	if hp_inimigos[i] > 0{
		array_push(inimigos_vivos, enemies_combo[i])
	}
	pct_enemy_purify[i] = clamp(round(((enemies_data[i].hp_max - enemies_data[i].current_hp) / enemies_data[i].hp_max) * 100), 0, 100);
	percentage_text_enemy[i] = (string(pct_enemy_purify[i]) + "%")
	max_width_name[i] = string_width(return_longest_word(string_upper(enemies_data[i].enemy_name)));

	update_percentage_enemy_text_width(i);
	show_debug_message(max_width_name);
}

function run_command(_opt){
	switch (_opt){
		case 0:
//		state = BATTLE_STATES.arrow_pattern
		chosen_action = ACTIONS.ATTACK;
		state = BATTLE_STATES.select_enemy;
		enemy_name_appear_effect = 20;
		alpha_barra_ini = 1;
		
		break;
		case 1:
		chosen_action = ACTIONS.POWER;
		state = BATTLE_STATES.power_menu;
		break;
		
		case 2:
			chosen_action = ACTIONS.ITEM;
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

function create_item_message(_item, _actor){
		var msg = "<wave>" + string(_actor.name) + " usou " + string(_item.name) + "!</wave>";
		return msg;
}

function execute_action(action){
	
	switch action.action{
		case ACTIONS.ATTACK:
		next_enemy_to_attack = action.target;
		current_actor = action.actor;
		script_execute(current_actor.attack_minigame);
		break;
		
		case ACTIONS.ITEM:
			var msg = create_item_message(action.used_item, action.actor);
			var textbox_msg = new _msg(msg, "battle_event",,,,,,,3);
			add_message_to_queue(textbox_msg);
		break;
		
		case ACTIONS.POWER:
			state = BATTLE_STATES.attacking_power;
		break;
	}
}

//function chose_attack_minigame(actor){
//	switch actor{
//	case 0: //drio
//	//arrow
//	break;
//	case 1: //glint
//	//sing
//	break;
//	case 2: //avery
//	//drums
//	break;
	
//	}
//}

function add_dance_points(amount){
	focus_points_amnt_incr = amount;
	focus_points_dest = clamp(round(focus_points + (focus_points_amnt_incr)), 0, 100);
	focus_points = focus_points_dest;
}

function run_arrow_pattern(){

		var attack_params = variable_struct_get(ataques, "normal_attack");
		var directions = ["up", "down", "left", "right"];
		
		arrow_number = 4;
		arrows_alpha = array_create(arrow_number, 0);
		arrow_speed_effect = array_create(arrow_number, 1);
		arrow_stretch_effect = array_create(arrow_number, 1);
		arrow_shine_index = array_create(arrow_number, 0);
		arrow_shine_effect = array_create(arrow_number, false);
		arrow_pat = []
		
			
		for (var i = 0; i < arrow_number; i++){
			var r = irandom(array_length(directions)-1);
			array_push(arrow_pat, directions[r]);

		}

		max_dmg = attack_params.damage;
		vel_setas = attack_params.velocity;
		arrow_timer = arrow_time;
			
		add_dance_points(10);

		load_arrow_distance();
		state = BATTLE_STATES.arrow_pattern;


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


function calc_xp(level){
    return power(level, xp_gain_constant);
}

function add_xp(inst, amount){
    inst.values.xp += amount;
}

function try_level_up(inst){

    var next_level = inst.values.level + 1;
    var required_xp = obj_game_manager.level_tiers[$ "level_" + string(next_level)];

    if inst.values.xp < required_xp {
        return false;
    }

    inst.values.level++;
    inst.values.xp -= required_xp;

    return true;
}

function run_xp(inst){
    var xp = calc_xp(inst.values.level);
    add_xp(inst, xp);
    try_level_up(inst);
	return xp;
}


function calc_gold(level){
    return power(level, gold_gain_constant);
}

function add_gold(inst, amount){
    inst.values.gold += amount;
}


function run_gold(inst){
    var gold = calc_gold(inst.values.level);
    add_gold(inst, gold);
    return gold;
}



blink_dmg = true;

function reset_text_to_draw(txt_type){
	switch(txt_type){
		case TXT_TYPES.arrow_accuracy:
		text_to_draw = ["",""]
		
		break;
		case TXT_TYPES.on_beat:
		text_to_draw = ["",""]
		
		break;
		case TXT_TYPES.enemy_damage:
		text_to_draw = ["",""]
		scale_pop_effect = [];
		index_dmg = 0;
		can_lower_dmg_txt_alpha = false;
		blink_dmg = [false, false];
		alpha_txt_to_draw = 1;
		break;
	}
}



dmg_char_timer = 0;
dmg_char_delay = 10;

dmg_alpha_timer = [];
dmg_alpha_delay = 60;

dmg_blink_timer = [];
dmg_blink_delay = 10;

function text_arrow_accuracy(){
var range_text = 5
	text_initial_x_position = arrow_target_x + range_text;
	text_final_x_position = arrow_target_x;
		
	var rot_range = 5
	rot_text_dest = choose(rot_range, -rot_range)
	rot_text =  0;
		
	size_text = size_text_default;
		
	alpha_txt_to_draw = 1
}

function text_enemy_damage()
{
    index_dmg = 0;
    dmg_char_timer = 0;

    range_text = 8;
    alpha_txt_to_draw = 1;

    can_lower_dmg_txt_alpha = false;

    text_initial_x_position = x_inimigo[opt] + range_text;
    text_final_x_position = x_inimigo[opt] - range_text;

    hue_attack_text = [
        default_attack_text_hsv[0][0],
        default_attack_text_hsv[1][0]
    ];

    sat_attack_text = [
        default_attack_text_hsv[0][1],
        default_attack_text_hsv[1][1]
    ];

    val_attack_text = [
        default_attack_text_hsv[0][2],
        default_attack_text_hsv[1][2]
    ];

    dmg_alpha_timer = 0;

    var char_count = string_length(text_to_draw[0]);

    blink_dmg = array_create(char_count, true);
    dmg_blink_timer = array_create(char_count, 0);
    scale_pop_effect = array_create(char_count, -size_text);
}

function text_on_beat(){
	var l_keys = global.LEFT_KEY_HOLD;
	var r_keys = global.RIGHT_KEY_HOLD;
	var last_used_key = (l_keys - r_keys);
		
	range_text = 8;
	alpha_txt_to_draw = 1
	can_lower_dmg_txt_alpha = false;
		
	text_initial_x_position = inst_player.x + range_text;
	text_final_x_position = inst_player.x - range_text;
		
	rot_range = 4
	rot_text_dest = rot_range * last_used_key;
	rot_text =  0;
		
	var initial_text_size = .5;
	size_text = initial_text_size;
}

function setup_text_draw(text, txt_type, color = c_white){
	text_to_draw_color = color;
	text_to_draw[0] = text;
	text_to_draw[1] = txt_type;
	
	switch(txt_type){
	case TXT_TYPES.arrow_accuracy:
	text_arrow_accuracy();
	break;
	case TXT_TYPES.enemy_damage:
	text_enemy_damage();
	break;
	case TXT_TYPES.on_beat:
	text_on_beat();
	break;
	}	
}

function draw_arrow_feedback(dist_alvo){
	last_closest_arrow_x = closest_arrow_x;
	last_closest_arrow_y = closest_arrow_y;
	
	arrow_feedback_draw = [arrow_pat[arrow_to_draw_from], dist_alvo]
	alpha_feedback = 2
}



function draw_enemy_percentage(i, draw_away = 0, alpha = alpha_barra_ini, scale = scale_pct, color1 = #ff2887, color2 = #ff7928){
	var percentage_text = percentage_text_enemy[i];
	var sprite_height_enemy = sprite_get_height(enemies_data[i].sprite_ini);
	var sprite_width_enemy = sprite_get_width(enemies_data[i].sprite_ini);
	var porcentage_x = x_inimigo[i] - width_pct[i] - sprite_width_enemy/2 - padding_hp_bar_and_enemy;
			
	draw_set_valign(fa_middle);
	draw_angled_text(percentage_text, porcentage_x + draw_away, y_inimigo[i]- sprite_height_enemy/2, default_max_width_angled_text, color1, color1, color2, color2, alpha, scale, scale);
	draw_set_valign(fa_bottom);
}
		
function update_percentage_enemy_text_width(i){
	draw_set_font(fnt_main);
	var percentage_text =  percentage_text_enemy[i];
	var width_percentage_update = string_width(percentage_text)* scale_pct;
	
	if (!is_real(width_pct[i])){
		width_pct[i] = width_percentage_update;
	} else {
		width_pct[i] = lerp(width_pct[i], width_percentage_update, .1);
	}
}
		


function draw_enemy_name(i, draw_away = 0, alpha = alpha_barra_ini){
	var off_y_arrow = 17;
	var sprite_height_enemy = sprite_get_height(enemies_data[i].sprite_ini);
	var sprite_width_enemy = sprite_get_width(enemies_data[i].sprite_ini);
	var name_x = x_inimigo[i] - sprite_width_enemy/2 - padding_hp_bar_and_enemy - width_pct[i]/2;
			
	draw_set_valign(fa_middle)
	if opt == i{
		draw_angled_text(string_upper(enemies_data[i].enemy_name), name_x - padding_hp_bar_and_enemy - max_width_name[i] + enemy_name_appear_effect + draw_away, y_inimigo[i] - sprite_height_enemy/2, max_width_name[i], #ff2887, #ff2887, #ff7928, #ff7928, alpha, 1, 1, 1);
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

function is_attacks_left(init_index){
	var action_number = array_length(battle_actions);

	
	for (var i = init_index; i < action_number; i++){
		var action = battle_actions[i];
		var type = action.action
		
		if type == ACTIONS.ATTACK{
			return true;
		}
	}
	
	return false;
}

function reset_arrow_pattern_vars(){
    player_arrow_pat = [];
    spawn_setas = inst_camera.x + 80;
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
	array_delete(inimigos_vivos, 0,array_length(inimigos_vivos));
	//percorre adicionando os inimigos se eles estiverem com mais que 0 de vida
	for (var e = 0; e < enemy_count; e++){
		if enemies_data[e].current_hp > 0{
			array_push(inimigos_vivos, enemies_combo[e]);
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

transition_wait_time[BATTLE_STATES.transition_enemy_turn] = 120;
transition_wait_time[BATTLE_STATES.transition_battle_won] = 5;
transition_wait_time[BATTLE_STATES.transition_main_menu] = 60;
default_wait_time = 60;
wait_time = 60;

function state_transition(new_state){
	wait_time = default_wait_time;
	
	if !(is_undefined(transition_wait_time[new_state])){
	wait_time = transition_wait_time[new_state];
	}
	
	state = new_state;
	wait_timer = wait_time;
}

function wait_time_over(){
	wait_timer--;
	
	if (wait_timer <= 0){
		return true;
	}
	return false;
}

chosen_index = 0;

textbox_chat_id = enemy_sentences[chosen_index]


enum ENEMIES_DRAW_STATES{
	cursed,
	purified
}


function next_environment_sentence(){
	chosen_index++;
	chosen_index = (chosen_index + array_length(enemy_sentences)) % array_length(enemy_sentences);
	chosen_index = clamp(chosen_index, 1, array_length(enemy_sentences))
	textbox_chat_id = enemy_sentences[chosen_index]
}

function create_environmental_textbox(){
	main_textbox_id = scr_open_textbox(textbox_chat_id);
	dest_height_textbox_battle = default_height_textbox_battle
}

function destroy_environmental_textbox(){
	instance_destroy(main_textbox_id);
	dest_height_textbox_battle = 0;
}


main_textbox_id = scr_open_textbox(textbox_chat_id);
load_enemy_attack()


function if_enemy_is_defeated(i){

	
	var vel_draw_away = 5;
	var x_ini = x_inimigo[i] + vel_draw_away * draw_away[i];
	var y_ini = y_inimigo[i] - vel_draw_away - sin(sin_t*3.5) * 5;
			
	part_emitter_region(part_system_stars, part_emitter_stars, x_ini -10, x_ini +10, y_ini -10, y_ini +10, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(part_system_stars, part_emitter_stars, part_type_stars, 20);
			
	draw_sprite_ext(enemies_data[i].sprite_ini_pur, enemies_index[i], x_ini, y_ini, 1, 1, 0, c_white, fade_away[i]);
	show_debug_message(fade_away[i])

}

available_space_y = cam_h - height_textbox_battle;

function define_enemy_position(i, cam_x, cam_y){
	
	var base_x = cam_x + cam_w / 3;
	var top_y = cam_y - cam_h / 2;

	switch (enemy_count){
		case 1:
			x_inimigo[i] = base_x;
			y_inimigo[i] = top_y + available_space_y / 2;
		break;

		case 2:
			var x_offset = (i == 1) ? 10 : 0;

			x_inimigo[i] = base_x + x_offset;
			y_inimigo[i] = top_y + available_space_y / 3 * (i + 1);
		break;

		case 3:
			var x_offset = (i == 1) ? 20 : 0;

			x_inimigo[i] = base_x + x_offset;
			y_inimigo[i] = top_y + available_space_y / 4 * (i + 1);
		break;
	}
}


lane_height = cam_h /(enemy_count+1);
	



	
		padding_hp_bar_and_enemy = 30;
		
function draw_hp_bar_enemy(i, max_hp, draw_away = 0, alpha = alpha_barra_ini){
			
	
	var pct = (enemies_data[i].current_hp / max_hp);
	var height_sprite = sprite_get_height(spr_bar_enemy_pure);
	var width_sprite = sprite_get_width(spr_bar_enemy_pure);
			
	var bar_x = x_inimigo[i] - padding_hp_bar_and_enemy;
	var bar_y = y_inimigo[i] - height_sprite;
			
	pct = (enemies_data[i].current_hp / max_hp);
			
	draw_sprite_part_ext(spr_bar_enemy_pure, 0, 0, clamp(pct * height_sprite, 0, height_sprite), width_sprite, height_sprite, bar_x + draw_away, bar_y + clamp(pct * height_sprite, 0, height_sprite), 1, 1, c_white, alpha);
	draw_sprite_part_ext(spr_bar_enemy_cons, 0, 0, 0, width_sprite, (pct * height_sprite),bar_x + draw_away, bar_y, 1, 1, c_white, alpha);
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
		
		alpha_ui_player_default = 1.5;
		alpha_ui_player_low = .5;
		alpha_ui_player_target = 1.5;
		alpha_ui_player = alpha_ui_player_default;
		alpha_barra_ini_default = 2.5;

function finish_item_selection(_item){
		
		last_used_item = _item;
		
		record_action();
		
		if (is_party_selection_complete()){
			fully_close_environmental_textbox();
		}

		can_select = false;
}


function setup_next_party_member(){
	
}

function record_action(){
	var action = new battle_action(party[current_party_member], chosen_action, opt, last_used_item, power_to_cast);
	array_push(battle_actions, action);
		
	current_party_member++;
}

function is_party_selection_complete(){
	
			if (current_party_member < party_member_number) {
			    state = BATTLE_STATES.main_menu;
			    setup_next_party_member();
				return false;
			} 
		current_party_member = 0;
		current_action = 0;
		battle_actions = sort_battle_actions(battle_actions);
		state = BATTLE_STATES.execute_actions;
		return true;
}

function fully_close_environmental_textbox(){
		destroy_environmental_textbox();
		dest_height_textbox_battle = 0;
		can_draw_texto_acerto = true;	
}

function on_beat_feedback(){
	add_dance_points(5);
				
	var texts = variable_struct_get(on_beat_messages, global.LANG);
	var random_num = irandom(array_length(texts) - 1);
	var text = texts[random_num];
				
	setup_text_draw(text, TXT_TYPES.on_beat, c_white)
}

function state_select_enemy(accept_key, deny_key, u_keys, d_keys){
	if alpha_barra_ini != alpha_barra_ini_default{
		alpha_barra_ini = alpha_barra_ini_default; // numero maior pra permanecer mais tempo 100% visivel
	}		

	select_enemy_controller(accept_key, deny_key, u_keys, d_keys);
	
	if accept_key{
		

		
			record_action();
					
			if (is_party_selection_complete()){
				fully_close_environmental_textbox();
			}
							
		//mas se aceitar e nao tiver mais quem fazer o que, roda isso abaixo:
		
		//next_enemy_to_attack = opt; //vai mudar isso
		//dest_height_textbox_battle = 0;
		//can_draw_texto_acerto = true
		//destroy_environmental_textbox();
		//if casting_power{
		//	state = BATTLE_STATES.attacking_power;
		//	focus_points -= power_to_cast.dp_cost;
		//} else {
		//	run_arrow_pattern("normal_attack");
		//	state = BATTLE_STATES.arrow_pattern;
		//}
	}
		
	if deny_key{
		focus_points -= focus_points_amnt_incr
		opt = 0;
		state = BATTLE_STATES.main_menu;
	}
}

function select_enemy_controller(accept_key, deny_key, u_keys, d_keys){
	
	if enemies_data[opt].current_hp <= 0{
		var tentativas = 0; 
		var prox_ini = opt; // um apontador para procurar pelo prox inimigo, como se fosse um opt temporario falso
			
		do{
			prox_ini = (prox_ini + 1) % enemy_count; 
			tentativas ++; 
			   
			if ( enemies_data[prox_ini].current_hp > 0){
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
			   
			if (enemies_data[prox_ini].current_hp > 0){
				opt = prox_ini;
				enemy_name_appear_effect = enemy_name_appear_px_num;
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
			   
			if (enemies_data[prox_ini].current_hp > 0){
				opt = prox_ini;
				enemy_name_appear_effect = enemy_name_appear_px_num;
				break;
			}
			
		} until (tentativas >=  enemy_count);

	}
}

function state_main_menu(opt_changer, l_keys, r_keys, accept_key, deny_key){
	
	
	
	//===== CONTROLADOR DE OPÇÕES
	opt += opt_changer;
	opt = (opt + opt_count) mod opt_count;
	
	if opt_changer != 0{
		audio_play_sound(snd_key, 3, false);
	}
		
	b_subimage = array_create(opt_count, 0)
	b_subimage[opt] = 1;

	//ENVIAR OPCAO		
	if accept_key && can_select{
	run_command(opt)
	opt = 0;
	}
	
	inst_player.teleport_to(player_initial_position[0], player_initial_position[1], "absolute");
}

casting_power = false;
power_to_cast = undefined;
count_tap_dance = 0;
bang_index = 0;
bang_speed = 1;
hp_index = 0;
hp_speed = 1;

range_bang_pos = 5;
random_pos_x = irandom_range(-range_bang_pos, range_bang_pos);
random_pos_y = irandom_range(-range_bang_pos, range_bang_pos);


function cast_power(power_id){
	casting_power = true;
	power_to_cast = power_id;
	
	show_debug_message("power_id")
	show_debug_message(power_to_cast)
	
	if (power_id.type == POWER_TYPES.attack){
		if (power_id.target_type == "single"){		
			
			state =  BATTLE_STATES.select_enemy;
			enemy_name_appear_effect = 20;
			alpha_barra_ini = 1;
		}
	}
	
	if (power_id.type == POWER_TYPES.heal){
		if (power_id.target_type == "single"){
			destroy_environmental_textbox();
			focus_points -= power_to_cast.dp_cost
			state =  BATTLE_STATES.attacking_power;
			scr_player_paint_color(255, 255, 255, 5);
			inst_player.blob_effect(0.9, 1.1);
			audio_play_sound(snd_hp_recover, 1, false, .8)
			get_instance("player").values.hp += clamp(global.DANCE_POWERS_DATA.heal_prayer.heal_amount, 0, get_instance("player").values.max_hp - get_instance("player").values.hp);
			
		}
	}
}

//function add_textbox_queue(_message){
//	array_push(textbox_queue, _message);
//}

////scr_open_textbox_custom(textbox_queue);
//function run_queue_textbox(){

//}

/// @function update_battle_text_transform()
/// @description Atualiza a rotação e escala do texto.
function update_battle_text_transform(){
	rot_text = lerp_snap(rot_text, rot_text_dest, 0.2);
	size_text = lerp_snap(size_text, size_text_big, 0.2);
}


/// @function update_battle_text_position()
/// @description Move o texto em direção à sua posição final.
function update_battle_text_position(){
	text_initial_x_position = lerp_snap(
		text_initial_x_position,
		text_final_x_position,
		0.1
	);
}


/// @function update_damage_characters()
/// @description Revela os caracteres do dano e aplica o efeito de pop.
function update_damage_characters(){
	if index_dmg >= string_length(text_to_draw[0]){
		return;
	}

	dmg_char_timer++;

	if dmg_char_timer >= dmg_char_delay{
		dmg_char_timer = 0;
		index_dmg++;

		scale_pop_effect[index_dmg - 1] = -size_text;
	}
}


/// @function update_damage_char_effects()
/// @description Atualiza o pop e blink individual dos caracteres do dano.
function update_damage_char_effects(){
	var dmg_count = min(index_dmg, array_length(scale_pop_effect));

	for (var i = 0; i < dmg_count; i++){
		if scale_pop_effect[i] != 0{
			scale_pop_effect[i] = lerp_snap(
				scale_pop_effect[i],
				0,
				0.5
			);
		}

		if blink_dmg[i]{
			dmg_blink_timer[i]++;

			if dmg_blink_timer[i] >= dmg_blink_delay{
				blink_dmg[i] = false;
			}
		}
	}

	sat_attack_text[0] = dest_attack_text_hsv[0][1];
	sat_attack_text[1] = dest_attack_text_hsv[1][1];
}


/// @function update_damage_text_alpha()
/// @description Controla o delay e o fade-out do texto de dano.
function update_damage_text_alpha(){
	if !can_lower_dmg_txt_alpha{
		dmg_alpha_timer++;

		if dmg_alpha_timer >= dmg_alpha_delay{
			can_lower_dmg_txt_alpha = true;
		}

		return;
	}

	alpha_txt_to_draw = max(0, alpha_txt_to_draw - 0.1);
}


/// @function update_damage_text_color()
/// @description Atualiza a transição de cor do texto de dano.
function update_damage_text_color(){
	hue_attack_text[0] = lerp_snap(
		hue_attack_text[0],
		dest_attack_text_hsv[0][0],
		0.1
	);

	hue_attack_text[1] = lerp_snap(
		hue_attack_text[1],
		dest_attack_text_hsv[1][0],
		0.2
	);
}