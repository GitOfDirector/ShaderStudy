using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//[ExecuteInEditMode]
public class ScreenOilPaintEffect : MonoBehaviour
{
    public Material Mat
    {
        get
        {
            if (curMat == null)
            {
                curMat = new Material(CurShader);
                curMat.hideFlags = HideFlags.HideAndDontSave;
            }
            return curMat;
        }
    }

    public Shader CurShader;

    [Range(0, 5), Tooltip("分辨率比例值")]
    public float ResolutionValue = 0.9f;
    [Range(1, 30), Tooltip("半径的值，决定了迭代的次数")]
    public int RadiusValue = 5;

    private static float ChangeValue;
    private static int ChangeValue2;

    private Material curMat;

    void Start()
    {
        ChangeValue = ResolutionValue;
        ChangeValue2 = RadiusValue;


        //CurShader = Shader.Find("浅墨Shader编程/Volume10/ScreenOilPaintEffect");

        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }

    }

    void Update()
    {
        if (Application.isPlaying)
        {
            ResolutionValue = ChangeValue;
            RadiusValue = ChangeValue2;
        }
    }

    void OnRenderImage(RenderTexture sourceTexture, RenderTexture destTexture)
    {
        //着色器实例不为空，就进行参数设置  
        if (CurShader != null)
        {
            //给Shader中的外部变量赋值  
            Mat.SetFloat("_ResolutionValue", ResolutionValue);
            Mat.SetInt("_Radius", RadiusValue);
            Mat.SetVector("_ScreenResolution", new Vector4(sourceTexture.width, sourceTexture.height, 0.0f, 0.0f));

            //拷贝源纹理到目标渲染纹理，加上我们的材质效果  
            Graphics.Blit(sourceTexture, destTexture, Mat);
        }

        //着色器实例为空，直接拷贝屏幕上的效果。此情况下是没有实现屏幕特效的  
        else
        {
            //直接拷贝源纹理到目标渲染纹理  
            Graphics.Blit(sourceTexture, destTexture);
        }
    }

    void OnDisable()
    {
        if (curMat)
        {
            DestroyImmediate(curMat);
        }
    }

    void OnValidate()
    {
        ChangeValue = ResolutionValue;
        ChangeValue2 = RadiusValue;
    }

}


