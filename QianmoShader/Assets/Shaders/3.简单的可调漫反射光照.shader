Shader "浅墨Shader编程/3.简单的可调漫反射光照"
 {
	Properties 
	{
		_MainColor ("主颜色", Color) = (1, 1, .5, 1)
	}
	SubShader
	 {
		Pass
		{
			Material
			{
				//可调节的漫反射光和环境光反射颜色
				Diffuse[_MainColor]
				Ambient[_MainColor]
			}
			//开启光照
			Lighting On
		}
	 }
}
