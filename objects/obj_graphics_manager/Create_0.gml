depth = DEPTH.FX_FRONT; // Ajuste para ficar abaixo do texto, mas acima do cenário/players

// Pega as referências dos seus uniforms (mantenha os nomes que já usa)
uni_shadow_color = shader_get_uniform(sh_lighting, "u_shadow_color");
uni_light_count  = shader_get_uniform(sh_lighting, "u_light_count");
uni_light_pos    = shader_get_uniform(sh_lighting, "u_light_positions");
uni_light_radii  = shader_get_uniform(sh_lighting, "u_light_radii");
uni_aspect       = shader_get_uniform(sh_lighting, "u_aspect_ratio");

// Criamos uma variável para guardar a nossa surface customizada
sombra_surface = -1;

//definir por area/room
global_shadow_color = #ad88f7;