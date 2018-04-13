// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "浅墨Shader编程/Volume8/径向模糊特效标准版"
{
	Properties
	{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_IterationNumber("迭代次数", Int) = 16
	}

	SubShader
	{
		Pass
		{
			//设置深度测试模式：渲染所有像素，等于关闭透明度测试（AlphaTest Off）
			ZTest Always

			CGPROGRAM

			#pragma target 3.0

			#pragma vertex vert 
			#pragma fragment frag

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform float _Value;
			uniform float _Value2;
			uniform float _Value3;
			uniform int _IterationNumber;

			struct vertextInput
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;//一级纹理坐标
			};

			struct vertexOutput
			{
				half2 texcoord : TEXCOORD0;
				float4 vertex : SV_POSITION;//像素位置
				fixed4 color : COLOR;
			};

			vertexOutput vert(vertextInput Input)
			{
				//【1】声明一个输出结构对象
				vertexOutput Output;

				//【2】填充此输出结构
				//输出的顶点位置为模型视图投影矩阵乘以顶点位置，也就是将三维空间中的坐标投影到了二维窗口
				Output.vertex = UnityObjectToClipPos(Input.vertex);

				//输出的纹理坐标也就是输入的纹理坐标
				Output.texcoord = Input.texcoord;

				//输出的颜色值也就是输入的颜色值
				Output.color = Input.color;

				//【3】返回此输出结构对象
				return Output;
			}

			/*
			可以发现，这是一个单子着色器、单通道的顶点&片段着色器，顶点着色函数vert中基本上都是写的比较中规中矩的代码，
			精髓之处在于片段着色器frag中，用一个for循环，
			将像素颜色按照一条直线（uv * scale + center）进行了迭代采样累加，最终将采样的颜色的总和除以采样次数，
			得到了想要实现的运动模糊效果
			*/

			float4 frag(vertexOutput i) : COLOR
			{
				//【1】设置中心坐标
				float2 center = float2(_Value2, _Value3);
				//【2】获取纹理坐标的x, y坐标值
				float2 uv = i.texcoord.xy;
				//【3】纹理坐标按照中心位置进行一个偏移
				uv -= center;
				//【4】初始化一个颜色值
				float4 color = float4(0.0, 0.0, 0.0, 0.0);
				//【5】将Value乘以一个系数
				_Value *= 0.085;
				//【6】设置坐标缩放比例值
				float scale = 1;
				//【7	】进行纹理颜色的迭代
				for (int j = 1; j < _IterationNumber; ++j)
				{
					//将主纹理在不同坐标下采样的颜色值进行迭代累加
					color += tex2D(_MainTex, uv * scale + center);
					//坐标缩放比例依据循环参数的改变而变化
					scale = 1 + (float(j * _Value));
				}
				//【8】将最终的颜色值初一迭代次数取平均值
				color /= (float)_IterationNumber;
				//【9】返回最终的颜色值
				return color;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
