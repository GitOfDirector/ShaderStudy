Shader "浅墨Shader编程/Volume3/12.用剔除操作渲染对象背面"
{
    SubShader
	{
		Pass
		{
			//设置顶点光照
			Material
			{
				Emission(0.3, 0.3, 0.3, 0.3)
				Diffuse(1, 1, 1, 1)
			}

			//开启光照
			Lighting On

			//剔除正面（不绘制面向观察者的几何面）
			Cull Front


		}
	}  
}
