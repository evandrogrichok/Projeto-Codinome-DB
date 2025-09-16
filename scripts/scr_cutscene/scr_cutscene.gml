function iniciar_cutscene(_cut_id, _caller_id){
    var inst = instance_create_depth(1,1,-9999,obj_cutscene_manager)
	inst.cutscene_id = string(_cut_id);
	instance_destroy(_caller_id)

}