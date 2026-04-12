if place_meeting(x, y, obj_player) && (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) && !instance_exists(obj_textbox)
{
	scr_open_textbox_custom(dialog);
}

