cam_moving = false;
fixated_camera = false;
intensity = 0
shake_timer = 0
shaking_camera = false;
shake_dir = 0;
shake_change = 0;
cam_w = camera_get_view_width(view_camera[0]);
cam_h = camera_get_view_height(view_camera[0]);


depth = DEPTH.UI_BASE;

//shaking nao é um estado, é um atributo

enum CAM_STATES {
    follow_target,     // segue um alvo
    focus_position,      // foca em ponto/objeto específico (cutscene)
    between_targets,    // entre dois alvos (diálogo)
    fixed       // travada
}

//enum CAM_CONTROLLER {
//    player,
//    trigger,
//    cutscene
//}

target = obj_player;
state = CAM_STATES.follow_target;

cam_w =  camera_get_view_width(view_camera[0]);
cam_h =  camera_get_view_height(view_camera[0]);


x = obj_player.x
y = obj_player.y


initial_cam_y = y;
x_layers_handle = [];

camera_x_frontwards_multiplier = 15;
camera_y_frontwards_multiplier = 5;
cam_x_frontwards = 0;
cam_y_frontwards = 0;
move_speed = 0;

spd_camera_default = 0.1;
spd_camera = spd_camera_default;

all_layers = layer_get_all();
all_layers_parallax = [];

parallaxed_layers = [DEPTH.BG_FARTHEST, DEPTH.BG_FAR, DEPTH.BG_NEAR, DEPTH.BG_NEAREST];
parallax_values = [1, .95 , .90, .85];

parallax_factor = [];

function setup_parallax_parameters(){
	x_layers_handle = []; 
	all_layers_parallax = [];
	all_layers = layer_get_all();
	layer_x_spd = [];
	parallax_factor = [];
	


	for(var i = 0; i < array_length(all_layers); i++){
		var _layer = all_layers[i];
		if (layer_get_depth(_layer) < parallaxed_layers[array_length(parallaxed_layers)-1]){
		continue;
		}
	
		array_push(x_layers_handle, layer_get_x(_layer));
		array_push(all_layers_parallax, _layer);
			
		for (var j = 0; j < array_length(parallaxed_layers); j++){
			if (layer_get_depth(_layer) >= parallaxed_layers[j]){
				array_push(parallax_factor, parallax_values[j]);
				array_push(layer_x_spd, layer_get_hspeed(_layer));
				break;
			}
		}	
		
	}
	
	layer_x_spd_acc = array_create(array_length(layer_x_spd));
	
}



old_x = x;
old_y = y;

function cam_shake(_int, _time){
	intensity = _int
	shake_timer = _time
	shaking_camera = true;
}

setup_fixated_cam = false;
x_fixated_camera = 0;
y_fixated_camera = 0;

function set_focus_position(_x, _y){
	state = CAM_STATES.focus_position;
	x_fixated_camera = _x;
	y_fixated_camera = _y;
}


target1 = 0;
target2 = 0;
function set_between_targets(t1, t2){
	state = CAM_STATES.between_targets;
	target1 = t1;
	target2 = t2;
}

function set_follow_target(t){
	state = CAM_STATES.follow_target;
	target = t;
}

function set_fixed_camera(){
	state = CAM_STATES.fixed;	
}




setup_parallax_parameters();





