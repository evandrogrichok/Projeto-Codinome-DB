
function scr_open_textbox(_id, _item_name = "ITEM_NÃO_DEFINIDO"){
	
	
    if !instance_exists(obj_textboxx){
    var _inst_vars = {
        dialogo_id : _id,
        item : _item_name
    };

	var inst_id = instance_create_depth(0, 0, -99999, obj_textboxx, _inst_vars);
	return inst_id;
	}
	
}