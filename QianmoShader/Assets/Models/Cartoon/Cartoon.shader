// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VRcoc/Cartoon"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Fresnel_Mask("Fresnel_Mask", 2D) = "white" {}
		_Text_int("Text_int", Float) = 0
		_Fresnel_Scale("Fresnel_Scale", Float) = 0
		_Fresnel_Power("Fresnel_Power", Float) = 0
		_Fresnel_Color("Fresnel_Color", Color) = (0.5019608,0.5019608,0.5019608,0.5019608)
		_Fresnel_Color_int("Fresnel_Color_int", Float) = 0
		_ReMap_Min_Old("ReMap_Min_Old", Float) = 0.3
		_ReMap_Max_Old("ReMap_Max_Old", Float) = 0.85
		_ReMap_Min_New("ReMap_Min_New", Float) = 0.2
		_ReMap_Max_New("ReMap_Max_New", Float) = 0.9
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZTest LEqual
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha  noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _Fresnel_Mask;
		uniform float4 _Fresnel_Mask_ST;

		UNITY_INSTANCING_CBUFFER_START(VRcocCartoon)
			UNITY_DEFINE_INSTANCED_PROP(float, _Text_int)
			UNITY_DEFINE_INSTANCED_PROP(float, _ReMap_Min_Old)
			UNITY_DEFINE_INSTANCED_PROP(float, _ReMap_Max_Old)
			UNITY_DEFINE_INSTANCED_PROP(float, _ReMap_Min_New)
			UNITY_DEFINE_INSTANCED_PROP(float, _ReMap_Max_New)
			UNITY_DEFINE_INSTANCED_PROP(float, _Fresnel_Scale)
			UNITY_DEFINE_INSTANCED_PROP(float, _Fresnel_Power)
			UNITY_DEFINE_INSTANCED_PROP(float4, _Fresnel_Color)
			UNITY_DEFINE_INSTANCED_PROP(float, _Fresnel_Color_int)
		UNITY_INSTANCING_CBUFFER_END

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 temp_cast_0 = (UNITY_ACCESS_INSTANCED_PROP(_ReMap_Min_Old)).xxxx;
			float4 temp_cast_1 = (UNITY_ACCESS_INSTANCED_PROP(_ReMap_Max_Old)).xxxx;
			float4 temp_cast_2 = (UNITY_ACCESS_INSTANCED_PROP(_ReMap_Min_New)).xxxx;
			float4 temp_cast_3 = (UNITY_ACCESS_INSTANCED_PROP(_ReMap_Max_New)).xxxx;
			float3 worldViewDir = normalize( UnityWorldSpaceViewDir( i.worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelFinalVal6 = (0.0 + UNITY_ACCESS_INSTANCED_PROP(_Fresnel_Scale)*pow( 1.0 - dot( ase_worldNormal, worldViewDir ) , UNITY_ACCESS_INSTANCED_PROP(_Fresnel_Power)));
			float2 uv_Fresnel_Mask = i.uv_texcoord * _Fresnel_Mask_ST.xy + _Fresnel_Mask_ST.zw;
			o.Emission = ( (temp_cast_2 + (( tex2D( _TextureSample0,uv_TextureSample0) * UNITY_ACCESS_INSTANCED_PROP(_Text_int) ) - temp_cast_0) * (temp_cast_3 - temp_cast_2) / (temp_cast_1 - temp_cast_0)) + ( ( fresnelFinalVal6 * ( UNITY_ACCESS_INSTANCED_PROP(_Fresnel_Color) * UNITY_ACCESS_INSTANCED_PROP(_Fresnel_Color_int) ) ) * tex2D( _Fresnel_Mask,uv_Fresnel_Mask).r ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
129;602;1296;524;1925.601;502.5503;1.9;True;True
Node;AmplifyShaderEditor.RangedFloatNode;10;-929.1995,365.5999;Float;False;InstancedProperty;_Fresnel_Scale;Fresnel_Scale;3;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;9;-942.7001,464.6996;Float;False;InstancedProperty;_Fresnel_Power;Fresnel_Power;4;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;12;-687.9005,709.3999;Float;False;InstancedProperty;_Fresnel_Color_int;Fresnel_Color_int;6;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.ColorNode;11;-718.3005,532.5999;Float;False;InstancedProperty;_Fresnel_Color;Fresnel_Color;5;0;0.5019608,0.5019608,0.5019608,0.5019608;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-448.4001,563.9003;Float;False;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.FresnelNode;6;-676.9998,366.3997;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;10.0;False;FLOAT
Node;AmplifyShaderEditor.SamplerNode;5;-1031.3,-322.7999;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;3;-894.7,-111.4;Float;False;InstancedProperty;_Text_int;Text_int;2;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.SamplerNode;15;-397.0992,700.2996;Float;True;Property;_Fresnel_Mask;Fresnel_Mask;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-312.5995,425.7996;Float;False;0;FLOAT;0.0,0,0,0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;23;-733.0986,161.6999;Float;False;InstancedProperty;_ReMap_Max_New;ReMap_Max_New;10;0;0.9;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;22;-734.0988,94.39967;Float;False;InstancedProperty;_ReMap_Min_New;ReMap_Min_New;9;0;0.2;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-695.9999,-208.9999;Float;False;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;20;-742.8988,-66.50027;Float;False;InstancedProperty;_ReMap_Min_Old;ReMap_Min_Old;7;0;0.3;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;21;-736.3987,16.69965;Float;False;InstancedProperty;_ReMap_Max_Old;ReMap_Max_Old;8;0;0.85;0;0;FLOAT
Node;AmplifyShaderEditor.TFHCRemap;19;-472.4988,-52.20025;Float;False;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,0,0,0;False;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-162.4991,427.4998;Float;False;0;COLOR;0.0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-56.59992,179.7;Float;False;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;87.10001,124.7;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;VRcoc/Cartoon;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;False;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;False;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0.001;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;13;0;11;0
WireConnection;13;1;12;0
WireConnection;6;2;10;0
WireConnection;6;3;9;0
WireConnection;14;0;6;0
WireConnection;14;1;13;0
WireConnection;4;0;5;0
WireConnection;4;1;3;0
WireConnection;19;0;4;0
WireConnection;19;1;20;0
WireConnection;19;2;21;0
WireConnection;19;3;22;0
WireConnection;19;4;23;0
WireConnection;16;0;14;0
WireConnection;16;1;15;1
WireConnection;8;0;19;0
WireConnection;8;1;16;0
WireConnection;0;2;8;0
ASEEND*/
//CHKSM=4D86A9F92587207C6D0FBB28F29F1618BABC7729