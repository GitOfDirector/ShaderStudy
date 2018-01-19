Shader "浅墨Shader编程/Volume3/8.纹理的Alpha通道与自发光相混合"
 {
    Properties 
	{
        _MainTex ("基础纹理（RGB）", 2D) = "white" {}
	}
	SubShader 
	{
        Pass
		{
			//【1】设置白色的顶点光照
            SetTexture[_MainTex]{ combine texture }
			//【2】开光照
			//【3】使用纹理的alpha通道来插值混合颜色(1, 1, 1, 1)
			//【4】和纹理相乘
			SetTexture[_BlendTex]{ combine texture * previous }
       }
    }
	FallBack "Diffuse"
}
