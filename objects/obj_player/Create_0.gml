// --------------------------------------------------------------
//AJUSTES DE ENGINE

depth = -bbox_bottom;


//desabilitando interpolação
gpu_set_texfilter(false)

//VER LINHAS/COLISOES...
debug_mode_aa = false

//CORREÇÃO DE TEMPO
global.deltatime =  delta_time / 16666



// --------------------------------------------------------------
//PARAMETROS P/ MOVIMENTAÇÃO BASICA


// DIREÇÕES USADAS NA MOVIMENTAÇÃO DO PERSONAGEM
// tecla1, tecla2, dir_x, dir_y, sprite, coll_dir, facing_x, facing_y
direcoes = [
    [vk_up,    ord("W"),  0, -1, spr_player_w,  90,  -1,  0],
    [vk_down,  ord("S"),  0,  1, spr_player_s, 270,  -1,  1],
    [vk_left,  ord("A"), -1,  0, spr_player_a, 180,   0, -1],
    [vk_right, ord("D"),  1,  0, spr_player_d,   0,   1, -1]
];

vel_player = 1 // velocidade normal do personagem
facing_y = 1 // direcao que está olhando no eixo y
facing_x = 0 // direcao que está olhando no eixo x
moving = false // se está se movendo
vel_colisao = vel_player + 2 // para checar colisao
coll_dir= 0 // direcao para usar em funcoes de colisao



// --------------------------------------------------------------
//CONTROLADORES DE CUTSCENE
cutscene_char = false;
cutscene_player_y_dest = y;
cutscene_player_x_dest = x;
cutscene_y_vel_player = noone;
cutscene_x_vel_player = noone;
acao = noone;



// --------------------------------------------------------------
//PARAMETROS DE BATALHA E ESTATISTICAS DO PERSONAGEM

values = {
	id_player: id,
	hp: 30
	}

//ativar_ataque = false; // se o player interagir com obj atacavel, ele ativa essa variavel;
//descansar_espada = false;
//descanso_contador = 0; // Vai contar as repetições da animação
cooldown = 0; // cooldown para ser atacado de novo
//quant_cooldown = 30; //definido no filho
//fog_timer = 0;
//knockback_timer = 0;
//relative_direction = 0; //graus do player em relacao ao objeto
//knockback_vel = 0; // vel kb do player
//processo_atacar = false; //está atacando
//inst_atacar = noone;
//shake_level = 0;


// --------------------------------------------------------------
//FUNÇÕES DIVERSAS

function cutscene_char_move(_action, _axis, _destination, _speed){
	acao = _action;
	cutscene_char = true;
	
	if _axis == "x"{
		cutscene_player_x_dest += _destination;
		cutscene_x_vel_player = _speed;
	} else
	if _axis == "y"{
		cutscene_player_y_dest += _destination;
		cutscene_y_vel_player = _speed;
	}
}

function coll_dir_indexer(_coll_dir){
	_cd = _coll_dir
	
	switch (_coll_dir){
		case 0:
			return 0
		case 90:
			return 1
		case 180:
			return 2
		case 270:
			return 3
	}
}

function move_player_towards_point(_x, _y, _spd){
	x = round(lerp(x, _x, _spd));
	y = round(lerp(y, _y, _spd));
	
}


