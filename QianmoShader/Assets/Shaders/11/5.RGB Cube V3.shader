//RGB立方体三色可调

Shader "浅墨Shader编程/Volume12/5.RGB Cube v3"
{
	Properties
	{
		_ColorRedValue("RedColor", Range(0.0, 1.0)) = 0.6
		_ColorGreenValue("GreenColor", Range(0.0, 1.0)) = 0.6
		_ColorBlueValue("BlueColor", Range(0.0, 1.0)) = 0.6
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
			
			uniform float _ColorRedValue;
			uniform float _ColorGreenValue;
			uniform float _ColorBlueValue;

			vertexOutput vert (float4 vertexPos : POSITION)
			{
				vertexOutput output;
				output.position = UnityObjectToClipPos(vertexPos);
				output.color = vertexPos + float4(_ColorRedValue, _ColorGreenValue, _ColorBlueValue, 0.0);

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
