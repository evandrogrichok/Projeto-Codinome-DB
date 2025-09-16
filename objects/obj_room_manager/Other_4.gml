ready_to_go = false
room_to_go = rm_notdefined
var inst_cam = obj_camera;
var inst_player = obj_player;

switch last_room{
	case rm_quartoirmaos:
		if room == rm_corredorcasa{
			inst_player.x = 348;
			inst_player.y = 150;
		}
	case rm_corredorcasa:
		if room == rm_quartoirmaos{
			inst_player.x = 257;
			inst_player.y = 332;
		}
	break;
}

inst_cam.x = inst_player.x
inst_cam.y = inst_player.y