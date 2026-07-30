varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// A cor da sombra global (ex: vec3(0.1, 0.1, 0.2) para um azul bem escuro)
uniform vec3 u_shadow_color;

// Configurações das luzes
const int MAX_LIGHTS = 8; // Defina um limite fixo para o loop do shader não pesar
uniform int u_light_count; // Quantas luzes realmente existem agora
uniform vec2 u_light_positions[MAX_LIGHTS]; // Posições (UV de 0.0 a 1.0)
uniform float u_light_radii[MAX_LIGHTS];    // Alcance da luz (em proporção UV)

// Importante: a proporção da tela (Largura / Altura)
// Sem isso, as luzes ficam com formato oval (de ovo) em telas retangulares!
uniform float u_aspect_ratio; 

void main()
{
    // 1. Pega a cor real do jogo
    vec4 base_colour = texture2D(gm_BaseTexture, v_vTexcoord);

    // 2. Ajusta as coordenadas para o aspect ratio (garante luzes redondas)
    vec2 uv = v_vTexcoord;
    uv.x *= u_aspect_ratio;

    // 3. A sombra começa no máximo (1.0 = escuridão total)
    float shadow_intensity = 1.0;

    // 4. Itera por todas as luzes para "apagar" a sombra
    for (int i = 0; i < MAX_LIGHTS; i++)
    {
        // Se já calculou todas as luzes ativas, sai do loop para economizar processamento
        if (i >= u_light_count) break; 

        // Pega a posição da luz e também ajusta o aspect ratio
        vec2 light_pos = u_light_positions[i];
        light_pos.x *= u_aspect_ratio;

        // Calcula a distância do pixel atual até o centro dessa luz
        float dist = distance(uv, light_pos);

        // smoothstep cria um degradê suave perfeito. 
        // 0.0 no centro da luz, vai até 1.0 na borda do raio (u_light_radii).
        float light_effect = smoothstep(0.0, u_light_radii[i], dist);

        // Multiplica a intensidade da sombra. 
        // Se estiver bem no meio da luz (light_effect = 0.0), a sombra é multiplicada por zero (some!).
        shadow_intensity *= light_effect;
    }

    // Garante que a sombra não faça maluquices passando de 1.0
    shadow_intensity = clamp(shadow_intensity, 0.0, 1.0);

    // 5. Calcula como seria o jogo 100% na sombra
    vec3 dark_color = base_colour.rgb * u_shadow_color;

    // 6. Faz o Lerp (mix). 
    // Onde shadow_intensity é 0 (tem luz), fica a cor normal. Onde é 1 (sombra), fica a dark_color.
    vec3 final_rgb = mix(base_colour.rgb, dark_color, shadow_intensity);

    gl_FragColor = vec4(final_rgb, base_colour.a);
}