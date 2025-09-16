if cooldown > 0{
	cooldown --;
	sprite_index = spr_playerhope_hb_dmg;
} else {
	sprite_index = spr_playerhope_hb;
}


if keyboard_check(vk_right){
	x++
}
if keyboard_check(vk_left){
	x--
}
if keyboard_check(vk_up){
	y--
}
if keyboard_check(vk_down){
	y++
}

