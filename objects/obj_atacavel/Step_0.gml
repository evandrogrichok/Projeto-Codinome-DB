depth = -bbox_bottom;
//distancia_target = point_distance(x,y,dir_x, dir_y)
//distance_to_player = point_distance(x,y,obj_player.x, obj_player.y) 

//if distancia_target > 1{
//	moving = true
//} else
//if distancia_target < 1 {
//	moving = false
//}


//if values.hp <= 0{
//	dec = overworld_decisions.purified
	
//} else {
//	if distance_to_player >= 15 && distance_to_player <= 60 && stunned_timer <= 0{
//		dec = overworld_decisions.run_to_player;
//		vel = vel_twd_player
//	}
//	else
//	if distance_to_player <= 15{
//		dec = overworld_decisions.rest
//		vel = 0;
//	}
//	else
//	if distance_to_player > 60 {
//		dec = overworld_decisions.walk;
//		vel = vel_walking
//	}

//	if distance_to_player < 15 && cooldown <= 0{
//		scr_attack(id, obj_player, values.attack_dmg);
//	}
	
//}


//if dec == overworld_decisions.walk && vel > 0{
//	if timer_dir <= 0{
//		new_direction();
//	} else {
//		timer_dir --;
//	}
//	walk_towards(dir_x, dir_y, vel);
	
//} else if dec == overworld_decisions.run_to_player && vel > 0{
//	walk_towards(obj_player.x, obj_player.y, vel);
	
//} else if dec == overworld_decisions.rest{
//	vel = 0;
//	dir_x = x;
//	dir_y = y;
	
//} else if dec == overworld_decisions.purified{
//	sprite_index = spr_objetoplaceholder;
//	image_alpha = 1
//	image_speed = 1
//}





//// ------------------------------------------------

//if knockback_timer > 0 {
//	if knockback_vel > 0{
//		knockback_vel -= 0.05
//	}

//	x =  x + lengthdir_x(knockback_vel, relative_direction)
//	y =  y + lengthdir_y(knockback_vel, relative_direction)

//	knockback_timer -= .5
//}
	


//if cooldown > 0{
//	cooldown -= .5	
//}

//if stunned_timer > 0{
//	stunned_timer -= .5	
//}

//if fog_timer > 0{
//	fog_timer -= 0.1	
//}

//if shake_level >= 0{	
//	shake_level -= .05
//}











