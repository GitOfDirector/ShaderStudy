Shader "浅墨Shader编程/Volume4/17.简单的植被Shader"
{
	Properties
	{
		_Color("主颜色", Color) = (1, 1, 1, 1)
		_MainTex ("Texture", 2D) = "white" {}
		_Cutoff("Alpha透明度阈值", Range(0, 9)) = .5
	}

	SubShader
	{
			//设置顶点光照
			Material
			{
				Diffuse[_Color]
				Ambient[_Color]
			}

			//开启光照
			Lighting On

			//关闭裁剪，渲染所有面，由于接下来渲染结合体的两面
			Cull Off

		//通道一：渲染所有超过[_Culloff]的透明的像素
		Pass
		{
			AlphaTest Greater [_Cutoff]

			//将顶点颜色混合纹理
			SetTexture[_MainTex]
			{
				Combine Texture * Primary, Texture
			}
		}

		//通道二：渲染半透明的细节
		Pass
		{
			//不写到深度缓冲中
			ZWrite off
			//不写已经写过的像素
			ZTest Less
			//深度测试中，只渲染小于或等于的像素值
			AlphaTest LEqual [_Cutoff]
			//设置透明度混合
			Blend SrcAlpha OneMinusSrcAlpha
			//进行纹理混合
			SetTexture [_MainTex]
			{
				combine texture * primary, texture
			}

		}










	}
}
