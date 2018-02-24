Shader "浅墨Shader编程/Volume5/19.基本blend使用" {
	Properties {
		_MainTex ("将要混合的纹理", 2D) = "black" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" }
		
		//通道
		Pass
		{
			//进行混合
			Blend DstColor Zero	// 乘法

			//设置纹理
			SetTexture[_MainTex]
			{
				combine texture
			}

		}
	}
	FallBack "Diffuse"
}
