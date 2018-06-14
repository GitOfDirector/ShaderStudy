// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "浅墨Shader编程/Volume12/6.Diffuse(Lambert) Shader"
{
	Properties
	{
		_Color ("Main Color", 2D) = (1, 1, 1, 1)
	}

	SubShader
	{
		//渲染类型设置：不透明
		Tags { "RenderType"="Opaque" }
		//设置光照模式
		Tags { "LightingMode" = "ForwardBase" }
		//细节层次
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			//顶点着色器输入结构
			struct appdata
			{
				float4 vertex : POSITION;//顶点位置
				float3 normal : NORMAL;//法线向量坐标
			};

			//顶点着色器输出结构
			struct v2f
			{
				float4 position : SV_POSITION;//像素位置
				float3 normal : NORMAL;//法线向量坐标
			};

			//变量声明
			float4 _LightColor0;
			float4 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.position = UnityObjectToClipPos(v.vertex);
				o.normal = mul(float4(input.normal, 0.0), unity_WorldToObject).xy;

				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				//获取发现的方向
				float3 normalDirection = normalize(input.normal);
				//获取入射光线的值与方向
				float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);

				//计算出漫反射颜色的值
				//Diffuse = LightColor * MainColor * max(0, dot(N, L))
				float3 diffuse = _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDirection, ligthDirection));

				//合并漫反射颜色值与环境光颜色值
				float4 diffuseAmbient = float4(diffuse, 1.0) +UNITY_LIGHTMODEL_AMBIENT;

				//将漫反射-环境光颜色值乘以纹理颜色
				return diffuseAmbient;

			}
			ENDCG
		}
	}
}
