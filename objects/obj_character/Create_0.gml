depth = DEPTH.ENTITY_BASE
// TEM que redefinir para cada personagem //
my_portraits = {
};


////////////////////////////////////////////

target = undefined
line_position = 0;
distance = 10
distance = 10


mx = 0;
my = 0;
target_x = x;
target_y = y;
cutscene_loops = 0;
cutscene_target_loops = 0;
moving = false;
move_speed = 0;
last_dir = "s";

enum MOVE_TYPES{
	walk,
	move,
	teleport
}

move_type = undefined;
img_scale= 1;

function walk_to(_x, _y, _spd, _mode){
    if (_mode == "add") {
        target_x = x + _x;
        target_y = y + _y;
    } else {
        target_x = _x;
        target_y = _y;
    }
    
    move_speed = _spd;
    moving = true;
	move_type = MOVE_TYPES.walk;

    var _dir = point_direction(x, y, target_x, target_y);
 
    mx = lengthdir_x(1, _dir);
    my = lengthdir_y(1, _dir);

	
    if (abs(mx) >= abs(my)) {

        sprite_index = sprite_h;
        ultima_direcao = "h";
        

        if (mx != 0) img_scale = sign(mx); 
        
    } else {

        if (my < 0) { 

            sprite_index = sprite_w;
            ultima_direcao = "w";
        } else { 

            sprite_index = sprite_s;
            ultima_direcao = "s";
        }
    }
}

function teleport_to(_x, _y, _mode){    
	
	if(_mode == "add"){
		x = x + _x;
		y = y + _y;
	return;
	}
	x = _x;
	y = _y;
	
}


lerp_speed_default = .1;
lerp_speed = lerp_speed_default;

function move_to(_x, _y, _mode, _speed = lerp_speed_default){
	lerp_speed = _speed;
	move_type = MOVE_TYPES.move;
	moving = true; 
		
		
	if _mode == "add"{
		target_x = x + _x;
		target_y = y + _y;
		return;
	}
		
	target_x = _x;
	target_y = _y;
}

function step_walk_to(){
    var _dist = point_distance(x, y, target_x, target_y);
    
    if (_dist > move_speed) {

        x += mx * move_speed;
        y += my * move_speed;
		
		
    } else {
        
        x = target_x;
        y = target_y;
        
        moving = false;
        mx = 0;
        my = 0;
        move_type = undefined;
		
        if (ultima_direcao == "h") {
            sprite_index = sprite_idle_h;
        } else if (ultima_direcao == "w") {
            sprite_index = sprite_idle_w;
        } else if (ultima_direcao == "s") {
            sprite_index = sprite_idle_s;
        }
    }
}

function step_move_to(){
	var distance = point_distance(x, y, target_x, target_y);
	if (distance <= 1){
		move_type = undefined;
		x = target_x;
		y = target_y;
		moving = false;
		return;
	}
	x = lerp(x, target_x, lerp_speed_default);
	y = lerp(y, target_y, lerp_speed_default);
}

index_spr = 0;
spd_spr = 1;