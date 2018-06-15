Shader "浅墨Shader编程/Volume13/5.Specular With Shader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color("Main Color", Color) = (1, 1, 1, 1)
		_SpecColor("Specular Color", Color) = (1, 1, 1, 1)
		_SpecShininess("Specular Shininess", Range(1.0, 20.0)) = 10.0
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }

		Pass
		{
			Tags { "LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag		

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal :NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;//一级纹理坐标
				float4 posWorld : TEXCOORD1;//在世界空间中的坐标位置
			};

			float4 _LightColor0;
			float4 _Color;
			sampler2D _MainTex;
			float4 _SpecColor;
			float _SpecShininess;
			
			v2f vert (appdata v)
			{
				v2f o;

				o.pos = UnityObjectToClipPos(v.vertex);
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				o.normal = mul(float4(v.normal, 0.0), unity_WorldToObject).xyz;
				o.texcoord = v.texcoord;

				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				float4 texColor = tex2D(_MainTex, i.texcoord);
				float3 normalDir = normalize(i.normal);
				float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
				float3 viewDir = normalize(_WorldSpaceCameraPos - i.posWorld.xyz);

				float3 diffuse = _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDir, lightDir));

				float3 specular;

				if(dot(normalDir, lightDir) < 0.0)
				{
					specular = float3(0, 0, 0);
				}		
				else
				{
					float3 reflectDir = reflect(-lightDir, normalDir);
					specular = _LightColor0.rgb * _SpecColor.rgb * pow(max(0.0, dot(reflectDir, viewDir)), _SpecShininess);

				}

				float4 diffuseSpecularAmbient = float4(diffuse, 1.0) + float4(specular, 1.0) + UNITY_LIGHTMODEL_AMBIENT;

				return diffuseSpecularAmbient * texColor;

			}
			ENDCG
		}
	}
}
