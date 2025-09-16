/// @param text_id

function scr_gametexts(_text_id){
	switch(_text_id){
		case "Bloco1":
		scr_text("Oi, eu sou o personagem 1. a.  ....  ... hahahhahah", "personagem 1")
			scr_text_shake(13,25);
		scr_text("Oi, eu sou o personagem 1, so que verde", "personagem 1 verde", -1)
			scr_option("sim", "Bloco1 - sim")
			scr_option("nao", "Bloco1 - nao")
			break;
			
		case "Bloco1 - nao":
			scr_text("ataaaa")
			break;
			
		case "Bloco1 - sim":
			scr_text("nao acredito")
			break;
			
		case "Bloco2":
		scr_text("Oi, eu sou o bloco 2")
		scr_text("Oi, eu sou o bloco 2?")
			break;
		case "TesteCut":
		scr_text("(... You heard someone calling you from the outside.)")
			break;
		
	}
}