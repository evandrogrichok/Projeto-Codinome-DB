enum BATTLE_STATES{
	main_menu,
	item_menu,
	hope_menu,
	select_enemy,
	arrow_pattern,
	enemy_turn,
	attacking,
	wait_time,
}


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
	[1000, #fff896, "ixi..."],
	[-1, #f56464, "errou"]
]

x_lim_setas = obj_camera.x - camera_get_view_width(view_camera[0])/2 + 20
arrow_pat = [];
vel_setas = 0;
player_arrow_pat = [];
inst_player_tweak = false;
text_to_draw = array_create(3,"")
dest_x_texto_acerto = 0;
x_texto_acerto = 0;

wait_timer = 0;
next_state = noone;
mostrar_limites_de_movimentacao = false;


position_player = array_create(state_num, array_create(2,0));
position_player[0] = [-20,  round(camera_get_view_height(view_camera[0])/2)];
spawn_setas = obj_camera.x +80;
local_seta_mais_proxima = 0;

flag_atacando = false
obj_player.sprite_index = spr_player_idle_battle;

scr_can_move_tweaker(-1);

state = BATTLE_STATES.main_menu;

opt = 0;
obj_camera.fixated_camera = true;

global.lang = "pt"

options = [
	["fight", asset_get_index("spr_button_fight_" + string(global.lang))],
	["hope", asset_get_index("spr_button_hope_" + string(global.lang))],
	["item", asset_get_index("spr_button_item_" + string(global.lang))],
	["defend", asset_get_index("spr_button_defend_" + string(global.lang))]
]

show_debug_message(options[0][1])

	
//}

sin_t = 0;
arrow_timer = 0;
arrow_time = 60;
arrow_to_draw_from = 0;
arrow_feedback_draw = ["",0,0];
alpha_feedback = 0;
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
seta_index = 0;
seta_speed = 1;

inimigos_vivos = [];
atqs_chave = "";
bullet_timer = 0;
battle_timer = 0;

caixa_mov_pat = "default_box";
fade_in_alpha = 0;
caixa_valores = {
	default_box: {
			caixa_tamanho: 215,
			caixa_altura: 100,
		
			caixa_posicao_x: obj_camera.x/2,
			caixa_posicao_y: obj_camera.y+10

	}
}

current_attack = noone;
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
//		state = BATTLE_STATES.arrow_pattern;
		run_arrow_pattern("normal_attack");
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
			state = BATTLE_STATES.select_enemy;
		break;
	}
}

function load_enemy_attack(_chave){
	var dados_ataques = variable_struct_get(ataques_inimigos, _chave);
	var ataques = dados_ataques.attacks
	var padrao_caixa = dados_ataques.limit_box
	var chosen_attack = irandom_range(1, array_length(ataques)) - 1;
	

	caixa_mov_pat = padrao_caixa;
	current_attack = ataques[chosen_attack];

	show_debug_message("DADOS_ATAQUES: " + string(dados_ataques) +" ATAQUES: " + string(ataques) +" PADRAO_CAIXA: " + string(padrao_caixa) + " CHOSEN_ATTACK: " + string(current_attack))
}
