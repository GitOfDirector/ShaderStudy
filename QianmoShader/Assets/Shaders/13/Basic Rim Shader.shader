Shader "浅墨Shader编程/Volume14/Basic Rim Shader"
{
	Properties
	{
		//_MainTex ("Texture", 2D) = "white" {}
		_MainColor("Main Color", Color) = (0.5, 0.5, 0.5, 1) 
		_TextureDiffuse("Texture Diffuse", 2D) = "white"{}
		_RimColor("Rim Color", Color) = (0.5, 0.5, 0.5, 1) 
		_RimPower("Rim Power", Range(0.0, 36)) = 0.1
		_RimIntecsity("Rim Intexsity", Range(0.0, 100)) = 3
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
