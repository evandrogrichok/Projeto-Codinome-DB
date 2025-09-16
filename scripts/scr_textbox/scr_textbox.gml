
function scr_open_textbox(_id){
	
    if !instance_exists(obj_textboxx){
    var _inst_vars = {
        dialogo_id : _id
        // Você pode adicionar outras variáveis aqui se precisar
        // ex: speaker_id : "algum_speaker"
    };

	instance_create_depth(0, 0, -99999, obj_textboxx, _inst_vars);
	}
}