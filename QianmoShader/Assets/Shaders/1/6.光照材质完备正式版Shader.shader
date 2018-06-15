Shader "浅墨Shader编程/6.光照材质完备正式版Shader"
{
	Properties
	{
		_Color("主颜色", Color) = (1, 1, 1, 0)
		_SpecColor("高光颜色", Color) = (1, 1, 1, 1)
		_Emission("自发光颜色", Color) = (0, 0, 0, 0)
		_Shininess("光泽度", Range(0.1, 1)) = 0.7
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			Material
			{
				Diffuse[_Color]
				Ambient[_Color]
				Shininess[_Shininess]
				Specular[_SpecColor]
				Emission[_Emission]
			}

			Lighting On
			SeparateSpecular On
			SetTexture[_MainTex]
			{
				Combine texture * primary DOUBLE, texture * primary
			}


		}
	}
}
