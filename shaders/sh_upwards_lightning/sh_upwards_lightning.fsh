//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 texelSize;
uniform vec4 colorBlend;

void main()
{
	vec4 CurrentPixel =  texture2D( gm_BaseTexture, v_vTexcoord );
    vec4 CurrentColor = (v_vColour * CurrentPixel);
	
	vec2 AboveTexel = v_vTexcoord + vec2(0.0, -texelSize.y);
	vec4 AbovePixel = texture2D(gm_BaseTexture, AboveTexel);
	
	float ScreenR;
	float ScreenG;
	float ScreenB;
	
	if (CurrentPixel.a > 0.0 && AbovePixel.a <= 0.0){
		
	vec3 threshold = vec3(0.5); 
	vec3 low  = 2.0 * CurrentColor.rgb * colorBlend.rgb;   
	vec3 high = 1.0 - 2.0 * (1.0 - CurrentColor.rgb) * (1.0 - colorBlend.rgb);

	CurrentColor.rgb = mix(low, high, step(threshold, CurrentColor.rgb));
	}
	
	gl_FragColor = CurrentColor;
	
}
