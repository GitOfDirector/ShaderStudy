using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScreenWaterDropEffect : MonoBehaviour
{
    Material Mat
    {
        get 
        {
            if (_mat == null)
            {
                _mat = new Material(CurShader);
                _mat.hideFlags = HideFlags.HideAndDontSave;
            }
            return _mat;
        }
    }

    public Shader CurShader;
    public Texture2D ScreenWaterDropTex;
    [Range(5, 64), Tooltip("溶解度")]
    public float Distortion = 8.0f;
    [Range(0, 7), Tooltip("水滴在X坐标上的尺寸")]
    public float SizeX = 1.0f;
    [Range(0, 7), Tooltip("水滴在Y坐标上的尺寸")]
    public float SizeY = 0.5f;
    [Range(0, 10), Tooltip("水滴的流动速度")]
    public float DropSpeed = 3.6f;

    private Material _mat;
    private float TimeX = 1.0f;

    void Start()
    {

    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (CurShader != null)
        {
            TimeX += Time.deltaTime;
            if (TimeX > 100)
                TimeX = 0;

            Mat.SetFloat("_CurTime", TimeX);
            Mat.SetFloat("_Distortion", Distortion);
            Mat.SetFloat("_SizeX", SizeX);
            Mat.SetFloat("_SizeY", SizeY);
            Mat.SetFloat("_DropSpeed", DropSpeed);
            Mat.SetTexture("_ScreenWaterDropTex", ScreenWaterDropTex);

            Graphics.Blit(source, destination, Mat);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }

    void OnDisable()
    {
        if (Mat)
        {
            DestroyImmediate(Mat);
        }
    }
}
