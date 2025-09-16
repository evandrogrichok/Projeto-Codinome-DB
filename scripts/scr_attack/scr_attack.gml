function scr_attack(_attacker, _attacked, _dmg){
	if _attacker.cooldown <= 0 && _attacked.values.hp > 0{
	
	var _pitch = random_range(0.7,1.3);
		audio_play_sound(snd_dmg, 2, 0, 0.6, 0, _pitch);
		_attacked.values.hp -= max(0, (_dmg - _attacked.values.defense))
		_attacked.shake_level = 1;
		_attacked.fog_timer = 1;
		
		_attacker.cooldown = _attacker.values.quant_cooldown
		_attacked.stunned_timer = _attacked.values.stunned_timer
		
		obj_camera.cam_shake(1, 20);
		scr_knockback(_attacker, _attacked)
	}
	

	

}

function scr_knockback(_attacker, _attacked, _knockback_vel_attacker = 1, _knockback_vel_attacked = 1.5, _timer = 20){
	_attacked.knockback_timer = _timer;
	_attacked.knockback_vel = _knockback_vel_attacked;

	
	_attacked.relative_direction = point_direction(_attacker.x, _attacker.y, _attacked.x, _attacked.y);
}