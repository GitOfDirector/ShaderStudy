Shader "浅墨Shader编程/Volume6/24.最基本的SurfaceShader"
 {
	//子着色器
	SubShader
	 {
		Tags { "RenderType"="Opaque" }

		
		CGPROGRAM
		//【1】光照模式声明：使用Lanbert光照模式
		#pragma surface surf Lambert

		//【2】输入结构
		struct Input 
		{
			float4 color : COLOR;//四元数的颜色值（RGBA）
		};

		//【3】表面着色函数的编写
		void surf (Input IN, inout SurfaceOutputStandard o) 
		{
			//反射率
			o.Albedo = float3(0.5, 0.8, 0.3);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
