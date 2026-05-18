if (!global.cutscene_active) instance_destroy();

if (index >= array_length(cutscene)) {
	instance_destroy();
	global.cutscene_active = false;
	exit;
}
var cmd = cutscene[index];



if (waiting)
{
    if (current_wait_type == WAITING_TYPES.frames) {
        if (wait_timer > 0) wait_timer--;
        else {
            waiting = false;
            index++;
        }
    }

    if (current_wait_type == WAITING_TYPES.textbox) {
        if (!instance_exists(obj_textbox)) {
            waiting = false;
            index++;
        }
    }
    if (current_wait_type == WAITING_TYPES.page) {
        if (obj_textbox.page > last_textbox_page) {
            waiting = false;
            index++;
        }
    }

    if (current_wait_type == WAITING_TYPES.animation) {
        if (object._cutscene_loops >= cmd.loops) {
            waiting = false;
            index++;
        }
    }
	
    if (current_wait_type == WAITING_TYPES.moving) {
        if (!object.moving) {
            waiting = false;
            index++;
        }
    }

    exit;
}



switch (cmd.type){	
	case "wait_animation":
	object = asset_get_index(cmd.obj);
    object._cutscene_loops = 0;
    object._cutscene_target_loops = cmd.loops;
	set_waiting_event(WAITING_TYPES.animation);
	break;
	
	case "wait":
    wait_timer = cmd.frames;
	set_waiting_event(WAITING_TYPES.frames);
	break;
	
	case "wait_textbox":
	set_waiting_event(WAITING_TYPES.textbox);
	break;
	
	case "wait_page":
	last_textbox_page = obj_textbox.page
	set_waiting_event(WAITING_TYPES.page);
	break;
	
	case "textbox":
    scr_open_textbox(cmd.id);
	break;
	
	case "cam_focus":
    obj_camera.set_focus_position(cmd.x, cmd.y);
	break;

	case "cam_follow":
	object = asset_get_index(cmd.target)
    obj_camera.set_follow_target(object);
	break;

	case "cam_fixed":
    obj_camera.set_fixed_camera();
	break;
	
	case "cam_shake":
    obj_camera.cam_shake(cmd.intensity, cmd.time);
	break;
	
	case "cam_between":
	var t1 = asset_get_index(cmd.target_1);
	var t2 = asset_get_index(cmd.target_2);
    obj_camera.set_between_targets(t1, t2);
	break;
	
	case "play_sound":
	var _loop = cmd[$ "loop"] ?? false;
	var _snd = asset_get_index(cmd.sound);
	_snd = _snd ?? snd_c;
    audio_play_sound(_snd, 1, _loop);
	break;
	
	case "play_music":
	obj_music_manager.play_music_cutscene(asset_get_index(cmd.music));
	break; //a ser construido no OBJ_MUSIC_MANAGER
	
	case "walk_instance":
	object = asset_get_index(cmd.obj);
	var _mode = cmd[$ "mode"] ?? "add";
	var _wait = cmd[$ "wait"] ?? true;
	var _speed = cmd[$ "speed"] ?? 1;
	
    with (object) {
        walk_to(cmd.x, cmd.y, _speed, _mode);
    }
	
	if(_wait){
		set_waiting_event(WAITING_TYPES.moving);
	}
	break;
	case "teleport_instance":
	object = asset_get_index(cmd.obj);
	_mode = cmd[$ "mode"] ?? "add";
    with (object) {
        teleport_to(cmd.x, cmd.y, _mode);
    }
	break;
	case "set_sprite":
	object = asset_get_index(cmd.obj);
	var sprite = asset_get_index(cmd.sprite);
    object.sprite_index = sprite;
	break;
	
	case "create_object":
	object = asset_get_index(cmd.obj);
    instance_create_depth(cmd.x, cmd.y, cmd.desired_depth, object);
	break;
	
}




if (!waiting) {
    index++;
}