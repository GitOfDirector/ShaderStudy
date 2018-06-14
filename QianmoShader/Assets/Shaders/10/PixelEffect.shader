Shader "浅墨Shader编程/Volume11/PixelEffect" 
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Params("PixelNumPerRow(X)Ratio(Y)", Vector) = (80, 1, 1, 1.5)
	}

	SubShader 
	{
		//关闭剔除操作
		Cull Off
		//关闭深度写入模式
		ZWrite Off
		//设置深度测试模式：渲染所有像素，等同于关闭透明的测试
		ZTest Always
		
		Pass
		{
			CGPROGRAM
			
			#include "UnityCG.cginc"

			#pragma fragment frag
			#pragma vertex vert

			struct vertexInput
			{
				float4 vertex : POSITION;//顶点位置
				float2 uv : TEXCOORD0;//一级纹理坐标
			};

			struct vertexOutput
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			vertexOutput vert(vertexInput v)
			{
				vertexOutput o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
			half4 _Params;
			
			half4 PixelateOperation(sampler2D tex, half2 uv, half scale, half ratio)
			{
				//计算每个像素块的尺寸
				half pixelSize = 1.0 / scale;
				//取整计算每个像素的坐标值，ceil函数，对参数向上取整
				half coordX = pixelSize * ceil(uv.x / pixelSize);
				half coordY= (ratio *pixelSize) * ceil(uv.y / pixelSize / ratio);
				//组合坐标值
				half2 coord = half2(coordX, coordY);

				return half4(tex2D(tex, coord).xyzw); 
			} 

			fixed4 frag(vertexOutput Input) : COLOR
			{
				//使用自定义的函数，计算每个像素经过取整后的颜色值
				return PixelateOperation(_MainTex, Input.uv, _Params.x, _Params.y);
			}

			ENDCG
		}
		
	}
	FallBack "Diffuse"
}
