enum PLAYER_STATES{
	normal,
	hope
}

// --------------------------------------------------------------
//AJUSTES DE ENGINE

depth = -y;
	

//desabilitando interpolação
//gpu_set_texfilter(false)

//VER LINHAS/COLISOES...
debug_mode_aa = false



hope_index = 0;
hope_spd = 1;

// --------------------------------------------------------------
//PARAMETROS P/ MOVIMENTAÇÃO BASICA


// DIREÇÕES USADAS NA MOVIMENTAÇÃO DO PERSONAGEM
// tecla1, tecla2, dir_x, dir_y, sprite, coll_dir, facing_x, facing_y
direcoes = [
	[vk_up,    ord("W"),  0, -1, spr_player_w,  90,  -1,  0, vk_left,  ord("A"), 135],
	[vk_right, ord("D"),  1,  0, spr_player_h,   0,   1, -1, vk_up,    ord("W"),  45],
	[vk_down,  ord("S"),  0,  1, spr_player_s, 270,  -1,  1, vk_right, ord("D"), 315],
    [vk_left,  ord("A"), -1,  0, spr_player_a, 180,   0, -1, vk_down,  ord("S"), 225]
	
    
	
];




vel_player = 1 // velocidade normal do personagem
vel_player_default = 1 // velocidade normal do personagem
facing_y = 1 // direcao que está olhando no eixo y
facing_x = 0 // direcao que está olhando no eixo x
moving = false // se está se movendo
vel_colisao = vel_player + 2 // para checar colisao
degrees_directon = 0 // direcao para usar em funcoes de colisao
interact_dir = 0;
dashing = false;

// --------------------------------------------------------------
//CONTROLADORES DE CUTSCENE
cutscene_char = false;
cutscene_player_y_dest = y;
cutscene_player_x_dest = x;
cutscene_y_vel_player = undefined;
cutscene_x_vel_player = undefined;
acao = undefined;

blink_timer = 0;
blink_times = 0;

state = PLAYER_STATES.normal;

dash_timer = 0;

dash_x = 0
dash_y = 0
dash_x_coll = 0
dash_y_coll = 0

// --------------------------------------------------------------
//PARAMETROS DE BATALHA E ESTATISTICAS DO PERSONAGEM

values = {
	max_hp: 30,
	hp: 30,
	defense: 0,
	attack: 0,
	level: 1,
	xp: 0,
	gold: 0,
	cooldown: 0,
	sin_t_flash_dmg: 0,
	
	take_dmg: function(_amount, _cooldown_time, _cam_shake_intensity, _cam_shake_time){
		
		if self.cooldown <= 0{
			sin_t_flash_dmg = 0;
			self.hp -= _amount
			self.cooldown = _cooldown_time;
			var pitch = random_range(0.8, 1);
			audio_play_sound(snd_dmg, 5, false, 1, 0, pitch);
			obj_camera.cam_shake(_cam_shake_intensity, _cam_shake_time)
		}
	}
}




hope_dir = 0;
hope_dir_dest = 0;
//ativar_ataque = false; // se o player interagir com obj atacavel, ele ativa essa variavel;
//descansar_espada = false;
//descanso_contador = 0; // Vai contar as repetições da animação
//quant_cooldown = 30; //definido no filho
//fog_timer = 0;
//knockback_timer = 0;
//relative_direction = 0; //graus do player em relacao ao objeto
//knockback_vel = 0; // vel kb do player
//processo_atacar = false; //está atacando
//inst_atacar = noone;
//shake_level = 0;



hope_sprite_scale_add = 0

hope_sprite_scale_fast_increase = 0

global.BLEND_COLOR_PLAYER_R = 255;
global.BLEND_COLOR_PLAYER_G = 255;
global.BLEND_COLOR_PLAYER_B = 255;

global.ALPHA_PLAYER = 1;
global.ALPHA_PLAYER_BORDER = 1;
global.ALPHA_HOPE_BORDER = 1;

global.BLEND_COLOR_PLAYER = make_colour_rgb(global.BLEND_COLOR_PLAYER_R, global.BLEND_COLOR_PLAYER_G, global.BLEND_COLOR_PLAYER_B);

global.RADIUS_HOPE_LIGHT = 0;
global.RADIUS_HOPE_LIGHT_MINIMUM = 10;

sin_t = 0;


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


global.sh_outline_texel_pointer = shader_get_uniform(sh_outline, "v_Texel");
global.sh_outline_color_pointer = shader_get_uniform(sh_outline, "v_Color");


part_sys_hope = part_system_create();
part_emitter = part_emitter_create(part_sys_hope);

part_type_hope = part_type_create();


part_type_sprite(part_type_hope, spr_particle_hope, false, false, false);
part_type_size(part_type_hope, 1, 1.1 , .01, false);
part_type_life(part_type_hope, 20, 40);
part_type_blend(part_type_hope, true);

part_type_speed(part_type_hope, .2, .5, 0, 0);
part_type_alpha3(part_type_hope, 1, .8, 0);
part_type_colour1(part_type_hope, #FFD784)


part_emitter_burst(part_sys_hope, part_emitter, part_type_hope, 1000)
part_emitter_relative(part_sys_hope, part_emitter, true);
