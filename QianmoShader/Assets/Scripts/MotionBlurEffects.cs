using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class MotionBlurEffects : MonoBehaviour
{
    Material Mat
    {
        get
        {
            if (curMaterial == null)
            {
                curMaterial = new Material(CurShader);
                curMaterial.hideFlags = HideFlags.HideAndDontSave;
            }
            return curMaterial;
        }
    }

    [Range(0, 50)]
    public float IterationNumber = 15; //迭代次数
    [Range(-0.5f, 0.5f)]
    public float Intensity = 0.125f;    //强度
    [Range(-2f, 2f)]
    public float OffsetX = 0.5f;    //水平方向偏移
    [Range(-2f, 2f)]
    public float OffsetY = 0.5f;    //垂直方向偏移
    public Shader CurShader;

    private Vector4 screenResolution;   //屏幕分辨率
    private Material curMaterial;

    private float changeValue1;
    private float changeValue2;
    private float changeValue3;
    private float changeValue4;

    void Start()
    {
        //判断系统是否支持屏幕特效
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }

        CurShader = Shader.Find("浅墨Shader编程/Volume8/径向模糊特效标准版");

        changeValue1 = Intensity;
        changeValue2 = OffsetX;
        changeValue3 = OffsetY;
        changeValue4 = IterationNumber;

        Debug.Log("Start");
    }

    void Update()
    {
        Debug.Log("Update");

        if (Application.isPlaying)
        {
            //赋值  
            IterationNumber = changeValue4;
            Intensity = changeValue1;
            OffsetX = changeValue2;
            OffsetY = changeValue3;  
        }
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (CurShader != null)
        {
            //设置shader中的外部变量
            Mat.SetFloat("_IterationNumber", IterationNumber);
            Mat.SetFloat("_Value", Intensity);
            Mat.SetFloat("_Value2", OffsetX);
            Mat.SetFloat("_Value3", OffsetY);
            Mat.SetVector("_ScreenResolution", new Vector4(source.width, source.height, 0, 0));
        
            //添加材质效果
            Graphics.Blit(source, destination, Mat);
        }
        else//不实现屏幕特效
        {
            //直接拷贝源纹理到目标纹理渲染
            Graphics.Blit(source, destination);
        }
    }

    void OnDisable()
    {
        if (curMaterial)
        {
            DestroyImmediate(curMaterial);
        }
    }

    void OnValidate()
    {
        //将编辑器中的值赋值回来，确保在编辑器中值的改变立刻让结果生效  
        changeValue4 = IterationNumber;
        changeValue1 = Intensity;
        changeValue2 = OffsetX;
        changeValue3 = OffsetY;
    }


}
