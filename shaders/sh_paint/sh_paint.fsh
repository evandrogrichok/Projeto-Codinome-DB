varying vec2 v_vTexcoord;

uniform vec4 v_Color;

void main()
{
    vec4 tex = texture2D(gm_BaseTexture, v_vTexcoord);
	if (texture2D( gm_BaseTexture, v_vTexcoord ).a > 0.0){
	   gl_FragColor = vec4(v_Color.rgba);
	}
}