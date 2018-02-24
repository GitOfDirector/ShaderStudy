Shader "浅墨Shader编程/Volume5/18.基本纹理载入" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "black" {}
	}

	//子着色器
	SubShader {
		//子着色器
		Tags { "Queue"="Geometry" }//子着色器的标签设置为几何体
		
		//通道
		Pass
		{
			//设置纹理
			SetTexture[_MainTex]
			{
				combine texture
			}

		}
	}
	FallBack "Diffuse"
}
