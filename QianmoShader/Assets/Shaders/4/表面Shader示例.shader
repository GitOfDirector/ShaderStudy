Shader "浅墨Shader编程/Volume5/表面Shader示例"
 {
	Properties
	{
		_MainTex("基本纹理", 2D) = "white"{}
		_BumpMap("凹凸纹理",  2D) = "bump"{}
		_RimColor("边缘颜色", Color) = (1, 1, 1, 1)
		_RimPower("边缘颜色强度", Range(0.6, 9.0)) = 1.0
	}

	SubShader
	{
		//渲染类型为Opaque， 不透明
		Tags{"RenderType" = "Opaque"}

		//开始CG着色器编程语言段
		CGPROGRAM

		//使用兰伯特光照模型
		#pragma surface surf Lambert

		//输入结构
		struct Input
		{
			float2 uv_MainTex;//主纹理
			float2 uv_BumpMap;//凸纹理
			float3 viewDir;//观察方向
		};

		//变量声明
		sampler2D _MainTex;
		sampler2D _BumpMap;
		float4 _RimColor;
		float _RimPower;	

		//表面着色器函数的编写
		void surf(Input IN, inout SurfaceOutput o)
		{
			//表面颜色为纹理颜色
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			//表面法线为凹凸纹理的颜色
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			//边缘颜色
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			//边缘颜色强度
			o.Emission  = _RimColor.rgb * pow(rim, _RimPower);
		}

		//结束CG着色器编程语言段
		ENDCG

	}

	//备胎为普通满反射
	Fallback "Diffuse"

}
