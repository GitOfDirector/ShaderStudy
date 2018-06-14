//RGB立方体单向可调

Shader "浅墨Shader编程/Volume12/4.RGB Cube v2"
{
	Properties
	{
		_ColorValue("Color", Range(0.0, 1.0)) = 0.6
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct vertexOutput
			{
				float4 position : SV_POSITION;
				float4 color : TEXCOORD0;
			};
			
			uniform float _ColorValue;

			vertexOutput vert (float4 vertexPos : POSITION)
			{
				vertexOutput output;
				output.position = UnityObjectToClipPos(vertexPos);
				output.color = vertexPos + float4(_ColorValue, _ColorValue, _ColorValue, 0.0);

				return output;
			}
			
			float4 frag (vertexOutput input) : COLOR
			{
				return input.color;
			}

			ENDCG
		}
	}
}
