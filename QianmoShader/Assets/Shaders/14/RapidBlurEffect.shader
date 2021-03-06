﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


/*
降采样（Downsample）也称下采样（Subsample），按字面意思理解即是降低采样频率。
对于一幅N*M的图像来说，如果降采样系数为k,则降采样即是在原图中每行每列每隔k个点取一个点组成一幅图像的一个过程。
不难得出，降采样系数K值越大，则需要处理的像素点越少，运行速度越快。

高斯模糊（Gaussian Blur），也叫高斯平滑，高斯滤波，其通常用它来减少图像噪声以及降低细节层次，常常也被用于对图像进行模糊。
通俗的讲，高斯模糊就是对整幅图像进行加权平均的过程，每一个像素点的值，都由其本身和邻域内的其他像素值经过加权平均后得到。
高斯模糊的具体操作是：用一个模板（或称卷积、掩模）扫描图像中的每一个像素，用模板确定的邻域内像素的加权平均灰度值去替代模板中心像素点的值。
*/

Shader "浅墨Shader编程/Volume15/RapidBlurEffect"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}

	SubShader
	{
		ZWrite Off
		Blend Off

		//通道0：降采样通道
		Pass
		{
			ZTest Off
			Cull Off

			CGPROGRAM

			//指定此通道的顶点着色器为vert_DownSmpl
			#pragma vertex vert_DownSmpl
			//指定此通道的像素着色器为frag_DownSmpl
			#pragma fragment frag_DownSmpl

			ENDCG

		}
		
		//通道1：垂直方向模糊处理通道
		Pass
		{
			ZTest Always
			Cull Off

			CGPROGRAM

			 //指定此通道的顶点着色器为vert_BlurVertical  
            #pragma vertex vert_BlurVertical  
            //指定此通道的像素着色器为frag_Blur  
            #pragma fragment frag_Blur  

			ENDCG
		}

		//通道2：水平方向模糊处理通道
        Pass  
        {  
            ZTest Always  
            Cull Off  
  
            CGPROGRAM  
  
            //指定此通道的顶点着色器为vert_BlurHorizontal  
            #pragma vertex vert_BlurHorizontal  
            //指定此通道的像素着色器为frag_Blur  
            #pragma fragment frag_Blur  
  
            ENDCG  
        }  
	}

	//------------------------------------------------CG着色语言声明部分------------------------------------------------
	CGINCLUDE

	#include "UnityCG.cginc"

	sampler2D _MainTex;

	//UnityCG.cginc中的内置变量，纹理中的像素单位尺寸
	uniform half4 _MainTex_TexelSize;
	//C#脚本控制的变量
	uniform half _DownSampleValue;

	//顶点输入结构体
	struct VertexInput
	{
		//顶点位置坐标
		float4 vertex :POSITION;
		//一级纹理坐标
		half2 texcoord : TEXCOORD0;
	};

	//降采样输出结构体
	struct VertexOutput_DownSmpl
	{
		//像素位置坐标
		float4 pos : SV_POSITION;
		//一级纹理坐标（右上）
		half2 uv2_0 : TEXCOORD0;
		//二级（左下）
		half2 uv2_1 : TEXCOORD1;
		//三级（右下）
		half2 uv2_2 : TEXCOORD2;
		//四级（左上）
		half2 uv2_3 : TEXCOORD3;

	};

	//准备高斯模糊权重矩阵参数7*4的矩阵
	static const half4 GaussWeight[7] = 
	{
		half4(0.0205, 0.0205, 0.0205, 0),  
        half4(0.0855, 0.0855, 0.0855, 0),  
        half4(0.232, 0.232, 0.232, 0),  
        half4(0.324, 0.324, 0.324, 1),  
        half4(0.232, 0.232, 0.232, 0),  
        half4(0.0855, 0.0855, 0.0855, 0),  
        half4(0.0205, 0.0205, 0.0205, 0)  
	};

	//顶点着色函数
	VertexOutput_DownSmpl vert_DownSmpl(VertexInput v)
	{
		//实例化一个降采样输出结构
		VertexOutput_DownSmpl o;

		o.pos = UnityObjectToClipPos(v.vertex);
		//对图像的降采样：取像素上下左右周围的点，分别存于四级纹理坐标中
		o.uv2_0 = v.texcoord + _MainTex_TexelSize.xy * half2(0.5h, 0.5h);
		o.uv2_1 = v.texcoord + _MainTex_TexelSize.xy * half2(-0.5h, -0.5h);
		o.uv2_2 = v.texcoord + _MainTex_TexelSize.xy * half2(0.5h, -0.5h);
		o.uv2_3 = v.texcoord + _MainTex_TexelSize.xy * half2(-0.5h, 0.5h);

		return o;
	}

	fixed4 frag_DownSmpl(VertexOutput_DownSmpl i) : SV_Target 
	{
		//定义一个临时的颜色值
		//fixed4 color = (0, 0, 0, 0);
		fixed4 color = (0);
		
		//四个相邻像素点处的纹理值相加
		color += tex2D(_MainTex, i.uv2_0);
		color += tex2D(_MainTex, i.uv2_1);
		color += tex2D(_MainTex, i.uv2_2);
		color += tex2D(_MainTex, i.uv2_3);

		//返回最终颜色的平均值
		return color / 4;
	}

	//顶点输入结构体
	struct VertexOutput_Blur 
	{
		//像素坐标
		float4 pos : SV_POSITION;

		//一级纹理
		half4 uv : TEXCOORD0;

		//二级纹理
		half2 offset : TEXCOORD1;
	};

	//顶点着色函数
	VertexOutput_Blur vert_BlurHorizontal(VertexInput v) 
	{
		VertexOutput_Blur o;

		//将三维空间中的坐标投影到二维窗口
		o.pos = UnityObjectToClipPos(v.vertex);
		//纹理坐标
		o.uv = half4(v.texcoord.xy, 1, 1);
		//计算X方向的偏移量
		o.offset = _MainTex_TexelSize.xy *half2(1.0, 0.0) * _DownSampleValue;

		return o;
	}

	//顶点着色函数
	VertexOutput_Blur vert_BlurVertical(VertexInput v)
	{
		VertexOutput_Blur o;

		//将三维空间中的坐标投影到二维窗口
		o.pos = UnityObjectToClipPos(v.vertex);
		//纹理坐标
		o.uv = half4(v.texcoord.xy, 1, 1);
		//计算Y方向的偏移量
		o.offset = _MainTex_TexelSize.xy *half2(0.0, 1.0) * _DownSampleValue;

		return o;
	}

	//片段着色函数
	half4 frag_Blur(VertexOutput_Blur i) : SV_Target 
	{
		//获取原始的uv坐标
		half2 uv = i.uv.xy;

		//获取偏移量
		half2 OffsetWidth = i.offset;
		//从中心点偏移3个间隔，从最左或最上开始加权累加
		half2 uv_withOffset = uv - OffsetWidth * 3.0;

		//循环获取加权后的颜色值
		half4 color = 0;
		for (int j = 0; j < 7; j++)
		{
			//偏移后的像素纹理值
			half4 texCol = tex2D(_MainTex, uv_withOffset);
			//待输出颜色值 += 偏移后的像素纹理值 * 高斯权重
			color += texCol * GaussWeight[j];
			//移到下一个像素处，准备下一次循环加权
			uv_withOffset += OffsetWidth;
		}

		return color;
	}

	ENDCG
}
