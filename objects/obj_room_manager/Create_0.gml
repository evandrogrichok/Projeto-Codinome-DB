last_room = undefined;
transition_alpha = 0;
ready_to_go = false;
inst_player = obj_player
room_to_go = rm_notdefined;

function chamar_prox_room(_rm){
	room_to_go = _rm
	transition_alpha = 1;
}