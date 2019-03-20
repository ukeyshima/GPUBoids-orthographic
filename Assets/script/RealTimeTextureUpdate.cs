using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RealTimeTextureUpdate : MonoBehaviour
{
    public Material HeightMapMaterial;    
    public MouseInfo mouseInfo;
    // public RenderTexture HeightMapTexture; 
    // public Material NormalMapMaterial;    
    void Start(){
        
    }

    void Update()
    {
        Vector2 MousePosition=mouseInfo.GetConventionMousePosition();
        HeightMapMaterial.SetVector("_MousePosition",MousePosition);                                

        if(Input.GetMouseButton(0)){            
            HeightMapMaterial.SetFloat("_ShouldRippleRendering",1);
        }else{
            HeightMapMaterial.SetFloat("_ShouldRippleRendering",0);        
        }
                
        // NormalMapMaterial.SetTexture("_HeightMap",HeightMapTexture);
    }
}
