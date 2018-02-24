Shader "浅墨Shader编程/4.光照材质完备beta版Shader"
 {
	Properties 
	{
		_Color ("主颜色", Color) = (1, 1, 1, 0)
		_SpecColor("反射高光颜色", Color) = (1, 1, 1, 1)
		_Emission("自发光颜色", Color) = (0, 0, 0, 0)
		_Shininess("光泽度", Range(0.01, 1)) = 0.7
	}
	SubShader
	 {
		Pass
		{
			Material
			{
				//可调节的漫反射光和环境光反射颜色
				Diffuse[_Color]
				Ambient[_Color]
				//光泽度
				Shininess[_Shininess]
				//高光颜色
				Specular[_SpecColor]
				//自发光颜色
				Emission[_Emission]

			}
			//开启光照
			Lighting On
		}
	 }
}
