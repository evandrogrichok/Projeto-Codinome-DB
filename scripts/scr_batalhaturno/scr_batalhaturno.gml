function scr_iniciar_batalhaturno(_inimigo){
	room_goto(rm_batlle);
	
}


function scr_ordenar_alf_array(_array){
	var tam_array = array_length(_array);
	
    for (var i = 0; i < tam_array - 1; i++) {
        for (var j = 0; j < tam_array - i - 1; j++) {
            if (_array[j] > _array[j+1]) {
                // Troca os elementos de posição
                var aux = _array[j];
                _array[j] = _array[j+1];
                _array[j+1] = aux;
            }
        }
    }
	
	return _array;
}