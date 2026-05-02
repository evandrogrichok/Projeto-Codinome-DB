function point_spawn(_x, _y, _point_type, _point_bullet_type, info_passthrough_01){
	
	var struct = {
		point_type : _point_type,
		point_bullet_type : _point_bullet_type,
		info_passthrough : [info_passthrough_01]
	}

	instance_create_depth(_x, _y, DEPTH.LOGIC_TOP, obj_points, struct)
	
	
}


function circle_and_falling_ice(){
	var inst_manager = obj_battle_manager;
	var caixas_valores = inst_manager.caixa_valores
	var caixa_atual_valores = caixas_valores.default_box
	var compr_caixa = caixa_atual_valores.caixa_tamanho 
	var alt_caixa = caixa_atual_valores.caixa_altura
	var x_caixa = caixa_atual_valores.caixa_posicao_x
	var y_caixa = caixa_atual_valores.caixa_posicao_y
	var y_offset = obj_camera.y - camera_get_view_height(view_camera[0])/2 
	
	if inst_manager.can_run_attack_script{
		
	var final_y = irandom_range(y_caixa - alt_caixa/2, y_caixa + alt_caixa/2);
	var _x = irandom_range(x_caixa - compr_caixa/2, x_caixa + compr_caixa/2);
	
	//sorteando pontos
	var random_number = (irandom(10));
	if random_number == 0{
		point_spawn(_x, y_offset, POINT_TYPES.big, POINT_BULLET_TYPE.spikes, final_y)
	} else {
		instance_create_depth(_x, y_offset, DEPTH.LOGIC_OBJECTS, obj_spikes, {final_y: final_y});
	}
	
	}
	
	if !instance_exists(obj_circle){
		instance_create_depth(x_caixa, y_caixa, -1001, obj_circle);
	}
}
 
