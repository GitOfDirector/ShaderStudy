Shader "浅墨Shader编程/Volume4/15.基本Alpha测试"
{
	Properties
	{
		_MainTex ("基础纹理（RGB）-透明度（A）", 2D) = "white" {}
	}

	SubShader
	{

		//进行Alpha测试操作，并且只渲染透明度大于60%的像素
		Pass
		{
			AlphaTest Greater 0.6
			SetTexture [_MainTex]
			{
				combine texture
			}
		}












	}
}
