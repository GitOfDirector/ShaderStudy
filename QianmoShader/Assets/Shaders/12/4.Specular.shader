// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "浅墨Shader编程/Volume13/4.Specular"
{
	Properties
	{
		_Color("Main Color", Color) = (1, 1, 1, 1)
		_SpecColor("Specular Color", Color) = (1, 1, 1, 1)
		_SpecShininess("Specular Shininess", Range(1.0, 100.0)) = 10.0
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }

		Pass
		{
			Tags { "LIghtMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float3 normal :  NORMAL;
				float4 posWorld : TEXCOORD0;
			};

			float4 _LightColor0;
			float4 _Color;
			float4 _SpecColor;
			float _SpecShininess;
			
			v2f vert (appdata v)
			{
				v2f o;

				o.pos = UnityObjectToClipPos(v.vertex);
				//获得顶点在世界空间中的位置
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				//获取定点在世界空间中的法向量坐标
				o.normal = mul(float4(v.normal, 0.0), unity_WorldToObject).xyz;

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				//获取法线方向
				float3 normalDir = normalize(i.normal);
				//获取入射光线的方向
				float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);
				//获取视角方向
				float3 viewDir = normalize(_WorldSpaceCameraPos - i.posWorld.xyz);

				//计算出漫反射颜色值
				float3 diffuse = _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDir, lightDir));

				//计算镜面反射颜色值
				float3 specular;

				//如果法线方向和入射方向大于180度，镜面反射值为0
				if(dot(normalDir, lightDir) < 0.0)
				{
					specular = float3(0.0, 0.0, 0.0);
				}
				else
				{
					//否则根据公式计算：
					//Specular = LightColor * SpecColor * pow(max(0, dot(R, V)), Shiness)
					//R = reflect(-L, N) 

					float3 reflectDir = reflect(-lightDir, normalDir);
					specular = _LightColor0.rgb  * _SpecColor.rgb * pow(max(0.0, dot(reflectDir, viewDir)), _SpecShininess);
				}

				//合并漫反射，镜面反射，环境光的颜色值
				float4 finalColor = float4(diffuse, 1.0) + float4(specular, 1.0) + UNITY_LIGHTMODEL_AMBIENT;

				return finalColor;
			}
			ENDCG
		}
	}
}
