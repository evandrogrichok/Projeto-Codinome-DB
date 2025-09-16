depth = -bbox_bottom;
timer_dir = 0;
//can_decide = true;
//dir_x = x + irandom_range(-20,20)
//dir_y = y + irandom_range(-20,20)
//dec = overworld_decisions.walk;
setted_alarm = false
distance_to_player = point_distance(x,y,obj_player.x, obj_player.y) 
distancia_target = 0
values = new enemy(id);

//enum overworld_decisions{
//	walk,
//	rest,
//	run_to_player,
//	purified
//}

//moving = false
//vel = 0.5;
//vel_twd_player = 1;
//vel_walking = 0.5;


//function walk_towards(_x, _y, _vel) {
//    if (_vel <= 0) {
//        // garante que não se mexa
//        x = x;
//        y = y;
//        return;
//    }

//    var dir = point_direction(x, y, _x, _y);
//    var dist = point_distance(x, y, _x, _y);

//    // não deixa passar do destino
//    if (dist < _vel) {
//        x = _x;
//        y = _y;
//    } else {
//        x += lengthdir_x(_vel, dir);
//        y += lengthdir_y(_vel, dir);
//    }
//}

//function set_alarm(_which, _time){
//	alarm[_which] = _time;
//	setted_alarm = true
//}

//fog_timer = 0

//stunned_timer = 0;
//values.hp = -1; //"vida" do personagem
//cooldown = 0; 
//shake_level = 0;
//knockback_timer = 0;
//relative_direction = 0; //graus do player em relacao ao objeto
//knockback_vel = 0 // vel kb do player



//function new_direction(){
//	timer_dir = 200;
//	x = round(x)
//	y = round(y)

//	dir_x = x + irandom_range(-30,30)
//	dir_y = y + irandom_range(-30,30)
//}