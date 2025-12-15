function scr_identificar_obj(_obj_tipo, _params){
	
	var _interact_dir_idx = coll_dir_indexer(interact_dir);
	var p = _params[_interact_dir_idx];
	var _inst = noone;
	

	_inst = collision_rectangle(p[0], p[1], p[2], p[3], _obj_tipo, false, false)


	return _inst;
}

function scr_interact(){
	
var _range = 4;
var _distance = 12
var _vx = x + lengthdir_x(_distance, interact_dir)
var _vy = y + lengthdir_y(_distance, interact_dir)

interact_params = [
	[x+2,        y - _range - 1, _vx + 2,   _vy + _range],
	[x - _range, y - 1,          _vx + _range,  _vy - 3 ],
	[x - 1,      y - _range - 1, _vx -3,    _vy + _range],
	[x - _range, y,              _vx + _range,  _vy     ]
];
	
	var _detected_instance = scr_identificar_obj(obj_interativo, interact_params);
	
	if (_detected_instance != noone){
		_detected_instance.ativarinteracao()
	}

}




