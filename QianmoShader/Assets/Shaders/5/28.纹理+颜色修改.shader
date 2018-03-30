Shader "浅墨Shader编程/Volume6/28.纹理+颜色修改"
 {
	Properties 
	{
	    _MainTex ("【主纹理】Texture", 2D) = "white" {}
		_Color ("【色泽】Tint", Color) = (0.6, 0.3, 0.6, 0.3)		
	}

	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		//使用兰伯特光照模型
		#pragma surface surf Lambert

		//输入结构
		struct Input 
		{
			float2 uv_MainTex;//纹理的uv值
		};

		//变量声明
		sampler2D _MainTex;
		fixed4 _ColorTint;

		//自定义颜色函数setcolor的编写
		void setcolor(Input IN, SurfaceOutput o, inout fixed4 color)
		{
			color *= _ColorTint;//将自选的颜色值乘给color
		}

		//表面能着色函数的编写
		void surf (Input IN, inout SurfaceOutput o)
		 {
			//从主纹理获取rgb颜色值
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
