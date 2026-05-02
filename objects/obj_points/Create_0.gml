depth = DEPTH.LOGIC_TOP

enum POINT_TYPES{
	tiny,
	big,
	breakable
}

enum POINT_STATES{
	collected,
	normal
}

enum POINT_BULLET_TYPE{
	none,
	spikes
}

//point_type = POINT_TYPES.tiny;



if point_type == undefined{instance_destroy();}
global.sin_t_points = 0;

if point_bullet_type == POINT_BULLET_TYPE.spikes{
	audio_play_sound(snd_tsiu, 1, false);
	
	
	if is_array(info_passthrough) && array_length(info_passthrough) > 0 {
		y_final = info_passthrough[0];
	}
	
	y_speed = 2;
}



if (point_type == POINT_TYPES.breakable){
	solid = true;
}

part_sizes = [
	[0.2, 0.3, 0.3, 0.6],
	[0.3, 0.5, 0.5, 0.8],
	[0.3, 0.4, 0.5, 0.7]
]


type_name = undefined;
type_sound = undefined;
point_type_size = undefined;
dp_value = undefined;

function point_config_setup(ind){
	switch (ind){
		case POINT_TYPES.tiny:
		point_type_name = "tiny";
		point_type_sound = snd_pick_point;
		point_type_size = part_sizes[0];
		dp_value = 5;
		break;
		case POINT_TYPES.big:
		point_type_name = "big";
		point_type_sound = snd_pick_point_big;
		point_type_size = part_sizes[1];
		dp_value = 10;
		break;
		case POINT_TYPES.breakable:
		point_type_name = "breakable";
		point_type_sound = snd_pick_point_big;
		point_type_size = part_sizes[2];
		dp_value = 15;
		break;
	}
}

point_config_setup(point_type)

sprite_index = asset_get_index("spr_point_" + point_type_name);




alpha = 1;

state = POINT_STATES.normal;

can_disappear = false;

transform_disappear = 0; // usado para controlar rotação e transformação do sprite

function alpha_changer(){
	alpha =  lerp(alpha, 0, 0.5);
	transform_disappear ++;
}
fx_pickup_index = 0;
fx_pickup_speed = 50;
ts = time_source_create(time_source_game, 10, time_source_units_frames, function(){with (self){ can_disappear = true; }})




part_sounds = [snd_pick_point, snd_pick_point_big, snd_pick_point_break];

