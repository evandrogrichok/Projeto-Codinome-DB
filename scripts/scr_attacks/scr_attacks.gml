
function circle_and_falling_ice(){
	var inst_manager = obj_battle_manager;
	var caixas_valores = inst_manager.caixa_valores
	var caixa_atual_valores = caixas_valores.default_box
	var compr_caixa = caixa_atual_valores.caixa_tamanho 
	var alt_caixa = caixa_atual_valores.caixa_altura
	var x_caixa = caixa_atual_valores.caixa_posicao_x
	var y_caixa = caixa_atual_valores.caixa_posicao_y
	var y_offset = obj_camera.x - camera_get_view_height(view_camera[0])/2 
	
	if inst_manager.can_run_attack_script{
	instance_create_depth(irandom_range(x_caixa - compr_caixa/2, x_caixa + compr_caixa/2), y_offset, -1000, obj_spikes, {final_y : irandom_range(y_caixa - alt_caixa/2, y_caixa + alt_caixa/2) });		
	}
	
	if !instance_exists(obj_circle){
		instance_create_depth(x_caixa, y_caixa, -1001, obj_circle);
	}
}

