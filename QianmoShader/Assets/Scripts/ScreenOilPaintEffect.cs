using System.Collections;
using System.Collections.Generic;
using UnityEngine;

<<<<<<< HEAD
//[ExecuteInEditMode]
public class ScreenOilPaintEffect : MonoBehaviour
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
=======
public class ScreenOilPaintEffect : MonoBehaviour
{
    public Material CurMat
    {
        get
        {
            if (curMat == null)
            {
                curMat = new Material(CurShader);
                curMat.hideFlags = HideFlags.HideAndDontSave;
            }
            return curMat;
>>>>>>> origin/master
        }
    }

    public Shader CurShader;
<<<<<<< HEAD

    [Range(0, 5), Tooltip("分辨率比例值")]
    public float ResolutionValue = 0.9f;
    [Range(1, 30), Tooltip("半径的值，决定了迭代的次数")]
    public int RadiusValue = 5;

    private static float ChangeValue;
    private static int ChangeValue2;

    private Material curMaterial;
=======
    [Range(0, 5), Tooltip("分辨率比例值")]
    public float ResolutionValue = 0.9f;
    [Range(1, 30), Tooltip("半径的值， 决定了迭代的次数")]
    public int RadiusValue = 5;

    public static float ChangeValue;
    public static int ChangeValue2;

    private Material curMat;

>>>>>>> origin/master

    void Start()
    {
        ChangeValue = ResolutionValue;
        ChangeValue2 = RadiusValue;
<<<<<<< HEAD

        //CurShader = Shader.Find("浅墨Shader编程/Volume10/ScreenOilPaintEffect");

        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }
=======
>>>>>>> origin/master
    }

    void Update()
    {
        if (Application.isPlaying)
        {
            ResolutionValue = ChangeValue;
            RadiusValue = ChangeValue2;
        }
    }

<<<<<<< HEAD
    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (CurShader != null)
        {
            Mat.SetFloat("_ResolutionValue", ResolutionValue);
            Mat.SetInt("_Radius", RadiusValue);
            Mat.SetVector("_ScreenResolution", new Vector4(source.width, source.height, 0.0f, 0.0f));

            Graphics.Blit(source, destination, Mat);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }



    void OnValidate()
    {
        ChangeValue = ResolutionValue;
        ChangeValue2 = RadiusValue;
    }

    void OnDisable()
    {
        if (curMaterial)
        {
            DestroyImmediate(curMaterial);
        }
    }

    
=======
    void OnRenderImage(RenderTexture sourceTexture, RenderTexture destTexture)
    {
        //着色器实例不为空，就进行参数设置  
        if (CurShader != null)
        {
            //给Shader中的外部变量赋值  
            CurMat.SetFloat("_ResolutionValue", ResolutionValue);
            CurMat.SetInt("_Radius", RadiusValue);
            CurMat.SetVector("_ScreenResolution", new Vector4(sourceTexture.width, sourceTexture.height, 0.0f, 0.0f));

            //拷贝源纹理到目标渲染纹理，加上我们的材质效果  
            Graphics.Blit(sourceTexture, destTexture, CurMat);
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
>>>>>>> origin/master

}
