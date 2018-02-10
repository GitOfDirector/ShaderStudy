Shader "浅墨Shader编程/Volume3/10.顶点光照+纹理Alpha自发光混合"
{
	Properties
	{
		_IlluminCol("自发光颜色（RGB）", Color) = (1, 1, 1, 1)
		_Color("主颜色", Color) = (1, 1, 1, 0)
		_SpecColor("高光颜色", Color) = (1, 1, 1 , 1)
		_Emission("光泽颜色", Color) = (0, 0, 0, 0)
		_Shininess("光泽度", Range(0.01, 1)) = 0.7
		_MainTex ("基础纹理（RGB）-自发光（A）", 2D) = "white" {}
	}
	SubShader
	{

		Pass
		{
			//【1】设置白色的顶点光照
			Material
			{
				Diffuse [_Color]
				Ambient [_Color]
				Shininess [_SpecColor]
				Specular [_SpecColor]
				Emission [_Emission]
			}

			//【2】开启光照
			Lighting On

			//【3】开启独立镜面反射
			SeparateSpecular On

			//【4】将自发光颜色混合上纹理
			SetTexture[_MainTex]
			{
				//使颜色属性进入混合器
				constantColor [_IlluminCol]
				//使用纹理的alpha通道混顶点颜色
				combine constant lerp(texture) previous
			}

			//【5】乘以纹理
			SetTexture[_MainTex]{ combine previous * texture }
		
			//【6】乘以顶点纹理
			SetTexture [_MainTex] { combine previous * primary DOUBLE, previous * primary}
		}
	}
}
