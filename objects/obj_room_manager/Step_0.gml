transition_alpha = clamp(transition_alpha,0 , 1)
if transition_alpha == 1{
	ready_to_go = true
}

if transition_alpha > 0 && room_to_go == rm_notdefined{
	transition_alpha -= 0.05
}

if room_to_go != rm_notdefined{
	global.can_move = false;
	
	switch(ready_to_go){
		case false: 
			transition_alpha += 0.05;
			break;
			
		case true:
			room_goto(room_to_go)
			break;
	}
} 

