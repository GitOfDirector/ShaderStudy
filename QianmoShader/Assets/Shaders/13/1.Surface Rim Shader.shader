Shader "浅墨Shader编程/Volume14/Surface Rim Shader" 
{
	Properties 
	{
		_MainColor("Main Color", Color) = (0.0, 0.5, 0.5, 1)
		_MainTex("Texture", 2D) = "white"{}
		_BumpMap("Bumpmap", 2D) = "bump"{}
		_RimColor("Rim Color", Color) = (0.17, 0.36, 0.81, 0.0)
		_RimPower("Rim Power", Range(0.6, 36.0)) = 8.0
		_RimIntensity("Rim Intensity", Range(0.0, 100.0)) = 1.0 
	}

	SubShader 
	{
		Tags { "RenderType"="Opaque" }

		
		CGPROGRAM
		
		#pragma surface surf Lambert

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};

		float4 _MainColor;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		float4 _RimColor;
		float _RimPower;
		float _RimIntensity;

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb *_MainColor.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			half rim = 1.0  - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow(rim, _RimPower) *_RimIntensity;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
