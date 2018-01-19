﻿Shader "浅墨Shader编程/2.材质颜色设置&开启光照" {

	SubShader 
	{
		Pass
		{
			Material
			{
				//将漫反射和环境光反射颜色设为相同
				Diffuse(0.9, 0.5, 0.4, 1)
				Ambient(0.9, 0.5, 0.4, 1)
			}
			//开启光照
			Lighting On
		}
	}
}
