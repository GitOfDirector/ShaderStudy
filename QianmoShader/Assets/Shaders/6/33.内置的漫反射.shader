Shader "浅墨Shader编程/Volume7/33.内置的漫反射" 
{
	Properties
	 {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}

	//----------------------子着色器
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		//使用兰伯特光照模型
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input
	    {
			float2 uv_MainTex;
		};

		//表面着色函数编写
		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
