Shader "Custom/37.自定义卡通渐变光照" 
{
	Properties 
	{
		_MainTex ("【主纹理】Texture", 2D) = "white" {}
		_Ramp("【渐变纹理】Shading Ramp", 2D) = "gray"{}
	}

	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		//使用自制的卡通渐变光照
		#pragma surface surf Ramp

		sampler2D _Ramp;
		sampler2D _MainTex;

		//实现自制的卡通渐变光照模式
		half4 LightingRamp(SurfaceOutput s, half3 lightDir, half atten)
		{
			//点成反射光线发现和光线方向
			half NdotL = dot (s.Normal, lightDir);
			//增强光照
			half diff = NdotL * 0.5 + 0.5;
			//从纹理中渐变效果
			half3 ramp = tex2D(_Ramp, float2(diff, diff)).rgb;
			//计算出最终结果
			half4 color;
			color.rgb = s.Albedo * _LightColor0.rgb * ramp * (atten * 2);
			color.a = s.Alpha;

			return color;
		}

		struct Input 
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
