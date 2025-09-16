//case intro
if room == rm_hopebattle && objects_created == false{
	 create_objects_hb(character_hope_battle)
}


if timer_next_attack <= 0{
	
	switch (character_hope_battle){
		case "obj_objetoplaceholder_atacavel":
			if !esperando{
				csv_line++;
			}
			var _attack = character_csv[# 0, csv_line];
			var _speed = character_csv[# 1, csv_line];
			var _amount = character_csv[# 2, csv_line];
			var _param1 = character_csv[# 3, csv_line];
			var _param2 = character_csv[# 4, csv_line];
			var _param3 = character_csv[# 5, csv_line];

		
		
			// if linha maior que width do ds pula pro prox estado(ending)
			switch (_attack){
				
				case "side_bullets":
					side_bullets(real(_param1))
					timer_next_attack = 40;
					break;
				
				case "ice_spikes":
					esperando = true;
						if spawns == _amount{
						esperando = false;
						}
						if timer <= 0{
						ice_spikes()
						timer = _speed
						spawns++;
						}
					timer -= 1;
					break;
					
			}
		
	}
	
} else {
	timer_next_attack -= 1;
}

//case ending