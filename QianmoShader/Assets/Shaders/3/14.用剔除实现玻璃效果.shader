Shader "浅墨Shader编程/Volume4/14.用剔除实现玻璃效果"
{
	Properties
	{
		_Color("主颜色", Color) = (1, 1, 1, 0)
		_SpecColor("高光颜色", Color) = (1, 1, 1, 1)
		_Emission("光泽颜色", Color) = (0, 0, 0, 0)
		_Shininess("光泽度", Range(0.01, 1)) = 0.7
		_MainTex ("基础纹理（RGB）-透明度（A）", 2D) = "white" {}
	}

	SubShader
	{
		//定义材质
		Material
		{
			Diffuse[_Color]
			Ambient[_Color]
			Shininess[_Shininess]
			Specular[_SpecColor]
			Emission[_Emission]
		}

		//开启光照
		Lighting On

		//开启独立镜面反射
		SeparateSpecular On

		//开启透明度混合
		Blend SrcAlpha OneMinusSrcAlpha

		//通道一：渲染对象背对我们的部分
		Pass
		{
			//如果对象是凸型，那么总是离镜头离得比前面更远
			Cull Front//不绘制面向观察者的几何面
			SetTexture[_MainTex]
			{
				combine primary * texture
			}

		}

		//通道二：渲染对象面向我们的部分
		Pass
		{
			//如果对象是凸型，那么总是离镜头离得比背面更远
			Cull Back
			SetTexture[_MainTex]
			{
				combine primary * texture
			}
		}

	}
}
