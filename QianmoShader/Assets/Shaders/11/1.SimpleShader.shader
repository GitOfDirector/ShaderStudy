// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "浅墨Shader编程/Volume12/1.SimpleShader" 
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}

	SubShader 
	{
		Pass
		{
			CGPROGRAM
			
			#pragma  vertex vert
			#pragma fragment frag

			float4 vert(float4 vertexPos :POSITION) : SV_POSITION
			{
				return UnityObjectToClipPos(vertexPos);
			}

			float4 frag(void) : COLOR
			{
				return float4(0.0, 0.6, 0.8, 1.0);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
