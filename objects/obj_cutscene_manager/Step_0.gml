if ready{

if linha_atual >= ds_grid_height(roteiro){
	instance_destroy();
	return;
}

// --- Leitura e Execução do Comando ---

var _type   = roteiro[# 0, linha_atual];
var _target = roteiro[# 1, linha_atual];
var _action = roteiro[# 2, linha_atual];
var _param1 = roteiro[# 3, linha_atual];
var _param2 = roteiro[# 4, linha_atual];
var _param3 = roteiro[# 5, linha_atual];

switch _type{
	case "CAMERA":
		if (_action == "move_to"){
	        var _target_obj = asset_get_index(_target);
	        var _cam_inst = instance_find(_target_obj, 0);
				_cam_inst.camera_move_to(_param1, real(_param2), real(_param3));
		}
		break;
		
	case "DIALOG":
		if !instance_exists(obj_textbox){
			create_textbox(_param1);
		}
		break;
		
	case "WAIT":
		esperando = true;
		switch _action{
			case "time":
				wait_time = wait_time + 1 * global.deltatime;
				if wait_time >= _param1{
					esperando = false;
					wait_time = 0;
				}
		}
		break;
		
		case "CHARACTER":
			var _target_obj = asset_get_index(_target);
			var _target_instance = instance_find(_target_obj,0);

			_target_instance.cutscene_char_move(_action, _param1, real(_param2), real(_param3));			
		break;

}


if (!esperando) {
    linha_atual++;
}
} else {
	if roteiro != "notdefined.csv"{
		ready = true;
		roteiro = load_csv(cutscene_id);
	}
}