function scr_identificar_obj(_obj_tipo, _params){
	
	var _coll_dir_idx = coll_dir_indexer(coll_dir);
	var p = _params[_coll_dir_idx];
	var _inst = noone;
	

	_inst = collision_rectangle(p[0], p[1], p[2], p[3], _obj_tipo, false, false)


	return _inst;
}

function scr_interacao_ataque(){
	
var _range = 3;
var _distance = 12
var _vx = x + lengthdir_x(_distance, coll_dir)
var _vy = y + lengthdir_y(_distance, coll_dir)

interact_params = [
	[x,          y - _range, _vx,           _vy + _range],
	[x - _range, y - 1,      _vx + _range,  _vy - 2     ],
	[x - 1,      y - _range, _vx -2,        _vy + _range],
	[x - _range, y,          _vx + _range,  _vy         ]
];
	
	var _detected_instance = scr_identificar_obj(obj_interativo, interact_params);
	
	if (_detected_instance != noone){
		_detected_instance.ativarinteracao()
	} //else {
	//	_detected_instance = scr_identificar_obj(obj_atacavel, attack_params);
	//	processo_atacar = true;
	//	ativar_ataque = true;
	//	sprite_index = spr_player_attack_horizontal
		
	//	if (_detected_instance != noone){
	
	//	if facing_x == 0{
	//	image_xscale = -1
	//	} else
	//	if facing_x == 1{
	//	image_xscale = 1
	//	}

	//	inst_atacar = _detected_instance
	//} 
	//}
	

}




