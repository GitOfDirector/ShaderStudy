using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//[ExecuteInEditMode]
public class PixelEffect : MonoBehaviour
{
    public Material CurMaterial
    {
        get 
        {
            if (m_CurMaterial == null)
            {
                m_CurMaterial = new Material(m_CurShader);
                m_CurMaterial.hideFlags = HideFlags.HideAndDontSave;
            }

            return m_CurMaterial; 
        }
    }

    [SerializeField]
    [Range(1f, 1024f), Tooltip("屏幕每行将被均分为多少个像素块")]
    private float m_PixelNumPerRow = 520;
    [SerializeField]
    [Range(0f, 24f), Tooltip("自定义长宽比")]
    private float m_Ratio = 1.0f;
    [SerializeField]
    [Tooltip("是否自动计算平方像素所需的长宽比")]
    private bool m_AutoCalulateRatio = true;

    private Shader m_CurShader;
    private Material m_CurMaterial;

    void Start()
    {
        m_CurShader = Shader.Find("浅墨Shader编程/Volume11/PixelEffect");

        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }
    }

    void Update()
    {

    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (m_CurShader != null)
        {
            float pixelNumPerRow = m_PixelNumPerRow;
            CurMaterial.SetVector("_Params", new Vector2(pixelNumPerRow, m_AutoCalulateRatio ? 
                (float)source.width / (float)source.height : m_Ratio));
            Graphics.Blit(source, destination, CurMaterial);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }

    void OnDisable()
    {
        if (CurMaterial)
        {
            DestroyImmediate(CurMaterial);
        }
    }


 


}
