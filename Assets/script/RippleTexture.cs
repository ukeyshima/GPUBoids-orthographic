using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RippleTexture : MonoBehaviour
{
    public Material Mat;
    public RenderTexture RippleNormalMapSrc;
    private RenderTexture RippleNormalMapDest;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        // Graphics.Blit(RippleNormalMapSrc, RippleNormalMapDest);
        Mat.SetTexture("_RippleTexture",RippleNormalMapSrc);
    }
}
