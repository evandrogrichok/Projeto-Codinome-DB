//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 v_Texel;
uniform vec4 v_Color;

void main()
{
	vec4 newColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	if (texture2D( gm_BaseTexture, v_vTexcoord ).a <= 0.0){
		float alpha = 0.0;
		
		alpha =  texture2D( gm_BaseTexture, vec2(v_vTexcoord.x + v_Texel.x, v_vTexcoord.y) ).a;
		alpha += texture2D( gm_BaseTexture, vec2(v_vTexcoord.x - v_Texel.x, v_vTexcoord.y) ).a;
		alpha += texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y - v_Texel.y) ).a;
		alpha += texture2D( gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y + v_Texel.y) ).a;
		
		if (alpha > 0.0){
			newColor = v_Color;
		}
	}
	
    gl_FragColor = newColor;

}
