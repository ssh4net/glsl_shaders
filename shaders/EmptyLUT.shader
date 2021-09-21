<Shader>
	<MultiPassBuffers>NoBuffers</MultiPassBuffers>
	<Image>
		<Shader_VS>#version 330
layout(location = 0) in vec2 v_UV;

out vec2 f_UV;

void main()
{
	f_UV = v_UV;
	vec2 Position = v_UV * 2.0 - 1.0;
	gl_Position = vec4(Position, 0.0, 1.0);
}</Shader_VS>
		<Shader_FS>#version 330
uniform sampler2D image;

//region Photoshop Uniforms
uniform vec3	iColorBG;	// Photoshop Background Color
uniform vec3	iColorFG;	// Photoshop Foreground Color
uniform vec2	iImageSize;	// Image Size
uniform vec2	iViewSize;	// Viewport Size
uniform vec4	iRandom;	// Random values [0 .. 1]
uniform float	iTime;		// Plugin running time
uniform vec4	iDate;		// Year, Month, Day, Time in seconds
//endregion

in vec2 f_UV;

layout(location = 0) out vec4 FragmentColor;



void main()
{
	int lut_size = 8;
 
 	vec2 pixel_size = vec2(1.0f / iImageSize.x, 1.0f / iImageSize.y);
 	vec2 pixel_offset = vec2(pixel_size.x / 2.0f, pixel_size.y / 2.0f);
 	
	FragmentColor.a = 1.0f; // alpha 1.0

	// R and G values with pixel size compensation to have 0.0 and 1.0 values in pixel center
	FragmentColor.r = mod((f_UV.x - pixel_offset.x) * lut_size, 1) * (iImageSize.x + lut_size) / iImageSize.x;
	FragmentColor.g = mod((1.0f - f_UV.y - pixel_offset.y) * lut_size, 1) * (iImageSize.y + lut_size) / iImageSize.y;
	
	// old gradient 
	//FragmentColor.r = mod(f_UV.x * lut_size, 1);
	//FragmentColor.g = mod((1.0f - f_UV.y) * lut_size, 1);

	float gv = floor(lut_size - lut_size * f_UV.y) / (lut_size - 1);
	float gh = floor(lut_size - lut_size * (1.0f - f_UV.x)) / (lut_size - 1);
	FragmentColor.b = (lut_size * gv + gh) / (lut_size + 1);

}
</Shader_FS>
		<TextureFilter>
			<TextureMagFilter>Linear</TextureMagFilter>
			<TextureMinFilter>Linear</TextureMinFilter>
			<TextureWrapModeS>ClampToEdge</TextureWrapModeS>
			<TextureWrapModeT>ClampToEdge</TextureWrapModeT>
		</TextureFilter>
		<TextureFilterBufferA>
			<TextureMagFilter>Linear</TextureMagFilter>
			<TextureMinFilter>Linear</TextureMinFilter>
			<TextureWrapModeS>Repeat</TextureWrapModeS>
			<TextureWrapModeT>Repeat</TextureWrapModeT>
		</TextureFilterBufferA>
		<TextureFilterBufferB>
			<TextureMagFilter>Linear</TextureMagFilter>
			<TextureMinFilter>Linear</TextureMinFilter>
			<TextureWrapModeS>Repeat</TextureWrapModeS>
			<TextureWrapModeT>Repeat</TextureWrapModeT>
		</TextureFilterBufferB>
		<TextureFilterBufferC>
			<TextureMagFilter>Linear</TextureMagFilter>
			<TextureMinFilter>Linear</TextureMinFilter>
			<TextureWrapModeS>Repeat</TextureWrapModeS>
			<TextureWrapModeT>Repeat</TextureWrapModeT>
		</TextureFilterBufferC>
		<TextureFilterBufferD>
			<TextureMagFilter>Linear</TextureMagFilter>
			<TextureMinFilter>Linear</TextureMinFilter>
			<TextureWrapModeS>Repeat</TextureWrapModeS>
			<TextureWrapModeT>Repeat</TextureWrapModeT>
		</TextureFilterBufferD>
	</Image>
</Shader>