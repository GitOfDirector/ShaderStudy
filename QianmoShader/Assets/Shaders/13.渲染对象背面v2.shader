Shader "浅墨Shader编程/Volume4/13.渲染对象背面v2/13.渲染对象背面v2"
{
	Properties
	{
		_Color("主颜色", Color) = (1, 1, 1, 1)
		_SpecColor("高光颜色", Color) = (1, 1, 1, 1)
		_Emission("光泽颜色", Color) = (0, 0, 0, 0)
		_Shininess("光泽度", Range(0.01, 1)) = 0.7
		_MainTex ("Texture", 2D) = "white" {}
	}

	SubShader
	{

		//通道一：绘制对象的前面部分，使用简单的白色材质，并应用主纹理
		Pass
		{
			//设置顶点光照
			Material
			{
				Diffuse[_Color]
				Ambient[_Color]
				Shininess[_Shininess]
				Specular[_SpecColor]
				Emission[_Emisssion]
			}

			//开启光照
			Lighting On

			//将顶点颜色混合纹理
			SetTexture[_MainTex]
			{
				Combine Primary * Texture
			}
		}

		//通道二：采用亮蓝色来渲染角色背面
		Pass
		{
			Color(0, 0, 1, 1)
			Cull Front
		}










	}
}
