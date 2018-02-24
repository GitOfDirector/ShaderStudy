// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "浅墨Shader编程/Volume5/顶点片元着色器"
{
	Properties
	{
		_Color ("Color", Color) = (1, 1, 1, 1)
		_SpecColor ("Specular Color", Color) = (1, 1, 1, 1)
		_Shininess("Shininess", Float) = 10
	}

	SubShader
	{
		Tags { "LigthMode"="ForwardBase" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			uniform float4 _Color;
			uniform float4 _SpecColor;
			uniform float _Shininess;
		    uniform float4 _LightColor0;

			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
				float4 col : COLOR;
			};

			//顶点函数
			vertexOutput vert (vertexInput v)
			{
				vertexOutput o;

				//方向
				float3 normalDirection = normalize(mul(float4(v.normal, 0), unity_WorldToObject).xyz);
				float3 viewDirection = normalize(float3(float4(_WorldSpaceCameraPos.xyz, 1.0) - mul(unity_ObjectToWorld, v.vertex).xyz));
				float3 lightDirection;
				float atten = 1.0;

				//光照
				lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				float3 diffuseReflection = atten * _LightColor0.xyz * max(0.0, dot(normalDirection, lightDirection));
				float3 specularReflection = atten * _LightColor0.xyz * _SpecColor.rgb * max(0.0, dot(normalDirection, lightDirection)) * 
					pow(max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _Shininess);
				float3 lightFinal = diffuseReflection +specularReflection + UNITY_LIGHTMODEL_AMBIENT;

				//输出
				o.col = float4(lightFinal * _Color.rgb, 1.0);//颜色
				o.pos = UnityObjectToClipPos(v.vertex);//位置
				return o;
			}
			
			//片段函数
			float4 frag (vertexOutput i) : Color
			{
				return i.col;
			}

			ENDCG
		}
	}

	Fallback "Diffuse"
}
