global.can_move = 1;

function scr_can_move_tweaker(_param){
	global.can_move = global.can_move + _param;
}
function scr_blink_player_sprite(amount){
	obj_player.blink_times = amount;
}