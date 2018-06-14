using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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
        }
    }

    public Shader CurShader;

    [Range(0, 5), Tooltip("分辨率比例值")]
    public float ResolutionValue = 0.9f;
    [Range(1, 30), Tooltip("半径的值，决定了迭代的次数")]
    public int RadiusValue = 5;

    private static float ChangeValue;
    private static int ChangeValue2;

    private Material curMaterial;

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

    

}
