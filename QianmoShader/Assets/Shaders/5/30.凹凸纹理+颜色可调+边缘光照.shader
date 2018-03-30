Shader "浅墨Shader编程/Volume6/30.凹凸纹理+颜色可调+边缘光照"
 {
	Properties
	{
		_MainTex("【主纹理】Texture", 2D) = "white"{}
		_BumpMap("【凹凸纹理】Bumpmap", 2D) = "bump"{}
		_ColorTint("【色泽】Tint", Color) = (0.6, 0.3, 0.6, 0.3)
		_RimColor("【边缘颜色】Rim Color", Color) = (.26, .19, .16, .0)
		_RimPower("【边缘颜色强度】Rim Power", Range(0.5, 8.0)) = 3.0
	}

	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpMap;
		fixed4 _ColorTint;
		float4 _RimColor;
		float _RimPower;

		struct Input 
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};

		void setcolor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			color *= _ColorTint;
		}

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow(rim, _RimPower);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
