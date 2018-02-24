Shader "浅墨Shader编程/Volume5/22.玻璃效果v2"
{
	Properties
	{
		_Color ("Main Color", Color) = (1, 1, 1, 1)
		_MainTex ("Texture", 2D) = "white" {}
		_Reflection("Gloss", Cube) = "skybox"{ TexGen CubeReflect }
	}
	SubShader
	{
		Tags { "RenderType"="Transparent" }

		Pass
		{
			//进行纹理混合
			Blend One One

			//设置材质
			Material
			{
				Diffuse [_Color]
			}

			//开启光照
			Lighting On

			//和纹理相乘
			SetTexture [_Reflections]
			{
				combine texture
				Matrix [_Reflection]
			}
		}
	}
}
