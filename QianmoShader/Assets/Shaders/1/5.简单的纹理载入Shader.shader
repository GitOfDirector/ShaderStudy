Shader "浅墨Shader编程/5.简单的纹理载入Shader"
 {
	Properties
	{
		_MainTex("基本纹理", 2D) = ""//"White"{TexGen SphereMap}
	}

	SubShader
	{
		Pass
		{
			SetTexture[_MainTex]{combine texture}
		}
	}

	Fallback "Diffuse"
}
