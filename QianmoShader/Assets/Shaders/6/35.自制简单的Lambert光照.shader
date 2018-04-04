Shader "浅墨Shader编程/Volume7/35.自制简单的Lambert光照" 
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf WhiteLambert

		half4 LightingWhiteLambert(SurfaceOutput s, half3 lightDir, half atten)
		{
			half NdotL = max(0, dot(s.Normal, lightDir));
			half4 color;
			color.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten  * 2);
			color.a = s.Alpha;
			return color;
		}

		sampler2D _MainTex;

		struct Input 
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
