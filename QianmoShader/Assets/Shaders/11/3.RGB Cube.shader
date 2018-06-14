//RGB立方体

Shader "浅墨Shader编程/Volume12/3.RGB Cube"
{

	SubShader
	{

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct vertexOutput
			{
				float4 position : SV_POSITION;//空间位置
				float4 color : TEXCOORD0;//0级纹理坐标
			};

			vertexOutput vert(float4 vertexPos : POSITION)
			{
				vertexOutput output;
				output.position = UnityObjectToClipPos(vertexPos);
				//输出颜色为顶点位置加上一个颜色偏移量
				output.color = vertexPos + float4(0.2, 0.2, 0.2, 0.0);

				return output;
			}

			float4 frag(vertexOutput input) : COLOR
			{
				return input.color;
			}

			ENDCG
		}
	}
}
