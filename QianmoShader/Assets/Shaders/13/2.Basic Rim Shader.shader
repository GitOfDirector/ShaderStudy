// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "浅墨Shader编程/Volume14/Basic Rim Shader"
{
	Properties
	{
		//_MainTex ("Texture", 2D) = "white" {}
		_MainColor("Main Color", Color) = (0.5, 0.5, 0.5, 1) 
		_TextureDiffuse("Texture Diffuse", 2D) = "white"{}
		_RimColor("Rim Color", Color) = (0.5, 0.5, 0.5, 1) 
		_RimPower("Rim Power", Range(0.0, 36)) = 0.1
		_RimIntensity("Rim Intensity", Range(0.0, 100)) = 3
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
		//LOD 100

		Pass
		{
			//设定通道名称
			Name "ForwardBase"

			//设置光照模式
			Tags
			{
				"LightMode" = "ForwardBase"
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "AutoLight.cginc"

			//指定Shader Model 3.0
			#pragma target 3.0

			//系统光照颜色
			uniform float4 _LightColor0;
			//主颜色
			uniform float4 _MainColor;
			//漫反射纹理
			uniform sampler2D _TextureDiffuse;
			//漫反射纹理_ST后缀板
			uniform float4 _TextureDiffuse_ST;
			//边缘光颜色
			uniform float4 _RimColor;
			//边缘光强度
			uniform float _RimPower;
			//边缘光强度颜色
			uniform float _RimIntensity;

			//顶点输入结构体
			struct vertexInput
			{
				//顶点位置
				float4 vertex : POSITION;
				//法线向量坐标
				float3 normal : NORMAL;
				//一级纹理坐标
				float4 texcoord :TEXCOORD0;
			};

			//顶点输出结构体
			struct vertexOutput
			{
				//像素位置
				float4 pos :SV_POSITION;
				//一级纹理坐标
				float4 texcoord :TEXCOORD0;
				//法线向量坐标
				float3 normal : NORMAL;
				//世界空间中的坐标位置
				float4 posWorld : TEXCOORF1;
				//创建光源坐标，用于内置的光照
				LIGHTING_COORDS(3, 4)
			};
			
			//顶点着色函数
			vertexOutput vert (vertexInput v)
			{
				vertexOutput o;
				
				o.texcoord = v.texcoord;
				//获取顶点在世界空间中的法线向量坐标
				o.normal = mul(float4(v.normal, 0), unity_WorldToObject).xyz;
				//获得顶点在世界空间中的位置坐标
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);
				//获取像素位置
				o.pos = UnityObjectToClipPos(v.vertex);

				return o;
			}
			
			//片段着色函数
			fixed4 frag (vertexOutput i) : COLOR
			{
				//视角方向
				float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
				//法线方向
				float3 normalDir = normalize(i.normal);
				//光照方向
				float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);

				//计算光照的衰减

				//衰减值
				float attenuation = LIGHT_ATTENUATION(i);
				//衰减后的颜色值
				float3 attenColor = attenuation *_LightColor0.xyz;

				//计算漫反射
				float3 NdotL = dot(normalDir, lightDir);
				float3 diffuse = max(0.0, NdotL) *attenColor + UNITY_LIGHTMODEL_AMBIENT.xyz;

				//准备自发光颜色

				//计算边缘强度
				half rim = 1.0 - max(0, dot(i.normal, viewDir));
				//计算边缘自发光强度
				float3 emissive = _RimColor.rgb * pow(rim, _RimPower) * _RimIntensity;

				//计算最终颜色
				// = （漫反射系数 * 纹理颜色 * rgb颜色）+ 自发光颜色
			    float3 finalColor = diffuse * (tex2D(_TextureDiffuse, TRANSFORM_TEX(i.texcoord.rg, _TextureDiffuse)).rgb
					*_MainColor.rgb) +emissive;

				return fixed4(finalColor, 1);
			}
			ENDCG
		}
	}
}
