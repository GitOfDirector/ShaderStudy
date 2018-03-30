Shader "浅墨Shader编程/Volume6/27.凹凸纹理载入"
 {
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}

	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input 
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			//从主纹理获取rgb颜色值
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			//从凹凸纹理获取法线值
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		}
		ENDCG
	}
	FallBack "Diffuse"
}
