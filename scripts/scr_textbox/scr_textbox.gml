
function scr_open_textbox(_id, _item_name = "ITEM_NÃO_DEFINIDO" ){	
    if instance_exists(obj_textbox)
	return;

	_inst_vars = {
		custom_message : false,
	    dialogo_id : _id,
	    item : _item_name
	};
	
	var inst_id = instance_create_depth(0, 0, -99999, obj_textbox, _inst_vars);
	return inst_id;
}


function scr_open_textbox_custom(_dialog){
	
	//if instance_exists(obj_textboxx)
	//return;
	
	
	var _inst_vars = {
		custom_message : true,
		dialogo : _dialog
	};
	
	var inst_id = instance_create_depth(0, 0, -99999, obj_textbox, _inst_vars);
	return inst_id;
	
	
}



function _msg(_text, _type = "chat", _textbox = spr_textbox, _sound = snd_text_default, _color = c_white, _font = fnt_main, _target = noone, _emotion = noone, _location = 0) constructor {

    text = _text;
    type = _type;
    textbox = _textbox;
    sound = _sound;
    color = _color;
    font = _font;
    target = _target;
    emotion = _emotion;
    location = _location;

}