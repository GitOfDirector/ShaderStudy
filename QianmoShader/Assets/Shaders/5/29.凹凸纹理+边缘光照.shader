Shader "浅墨Shader编程/Volume6/29.凹凸纹理+边缘光照" 
{
	Properties 
	{
		_MainTex ("【主纹理】Texture", 2D) = "white" {}
		_BumpMap ("【凹凸纹理】Bumpmap", 2D) = "bump"{}
		_RimColor ("【边缘颜色】Rim Color", Color) = (0.26, 0.19, 0.16, 0.0)
		_RimPower ("【边缘颜色强度】Rim Power", Range(0.5, 8.0)) = 3.0
	}
	
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpMap;
		float4 _RimColor;
		float _RimPower;

		struct Input 
		{
			float2 uv_MainTex;//主纹理的uv值
			float2 uv_BumpMap;//凹凸纹理的uv值
			float3 viewDir;//当前坐标的视角方向
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			//从主纹理获取rgb颜色值
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;

			//从凹凸纹理获取法线值
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	
			//从_RimColor参数获取自发光颜色
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb *pow(rim, _RimPower);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
