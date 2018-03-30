Shader "浅墨Shader编程/Volume6/25.颜色可调的SurfaceShader" 
{
	Properties
	 {
		_Color ("Main Color", Color) = (0.1, 0.3, 0.9, 1)
	}

	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		//LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		// Use shader model 3.0 target, to get nicer looking lighting
		//#pragma target 3.0

		float4 _Color;

		struct Input {
			float4 color : COLOR;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color.rgb;
			o.Alpha = _Color.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
