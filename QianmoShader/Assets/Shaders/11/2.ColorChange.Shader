Shader "浅墨Shader编程/Volume12/2.ColorChange"
{
	Properties
	{
		_Color("Color", Color) = (1, 1, 1, 1)
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			float4 vert(float4 vertexPos : POSITION) : SV_POSITION
			{
				return UnityObjectToClipPos(vertexPos);
			}

			uniform float4 _Color;

			float4 frag(void) : COLOR
			{
				return _Color;
			}

			ENDCG
		}
	}
}