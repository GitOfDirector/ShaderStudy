// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//透明单色Shader  
Shader "浅墨Shader编程/Volume13/1.SimpleAlphaShader"   
{  
    //------------------------------------【唯一的子着色器】------------------------------------  
    SubShader  
    {     
        //设置Queue为透明，在所有非透明几何体绘制之后再进行绘制  
        Tags{ "Queue" = "Transparent" }  
  
        Pass  
        {  
            //不写入深度缓冲,为了不遮挡住其他物体  
            ZWrite Off    
            //选取Alpha混合方式  
            Blend  SrcAlpha SrcAlpha  
            //Blend SrcAlpha OneMinusSrcAlpha  
  
            CGPROGRAM  

            #pragma vertex vert   
            #pragma fragment frag  

            float4 vert(float4 vertexPos : POSITION) : SV_POSITION  
            {  
                return UnityObjectToClipPos(vertexPos);  
            }  

            float4 frag(void) : COLOR  
            {  
                return float4(0.3, 1.0, 0.1, 0.6);  
            }  
  
            ENDCG  
        }  
    }  
}