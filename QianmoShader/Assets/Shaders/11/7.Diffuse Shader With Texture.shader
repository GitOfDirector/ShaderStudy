Shader "浅墨Shader编程/Volume12/7.Diffuse Shader With Texture"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color("Main Color", Color) = (1, 1, 1, 1) 
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
        //Tags{ "LightingMode" = "ForwardBase" }  
		LOD 200

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;				
			};

			float4 _LightColor0;
			float4 _Color;
			sampler2D _MainTex;
			
			v2f vert (appdata input)
			{
				v2f o;

				o.position = UnityObjectToClipPos(input.vertex);
				
				o.normal = mul(float4(input.normal, 0.0), unity_WorldToObject).xyz;

				o.texcoord = input.texcoord;

				return o;
			}
			
			fixed4 frag (v2f input) : COLOR
			{
				float4 texColor = tex2D(_MainTex, input.texcoord);
				float3 normalDir = normalize(input.normal);
				float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);

				float3 diffuse = _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDir, lightDir));

				float4 diffuseAmbient = float4(diffuse, 1.0) +UNITY_LIGHTMODEL_AMBIENT;

				return diffuseAmbient * texColor;
			}

			ENDCG
		}
	}
}
