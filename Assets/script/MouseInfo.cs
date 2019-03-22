using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MouseInfo : MonoBehaviour
{    
    public GPUBoids gpuBoids;        
    public Vector2 GetMousePosition(){        
        Vector3 MousePosition = Input.mousePosition;
        MousePosition = Camera.main.ScreenToWorldPoint(MousePosition);
        return new Vector2(MousePosition.x,MousePosition.z);
    }
    public Vector2 GetConventionMousePosition(){                
        Vector3 MousePosition = Input.mousePosition;
        MousePosition = Camera.main.ScreenToWorldPoint(MousePosition);
        Vector3 WallSize=gpuBoids.WallSize;        
        return new Vector2(MousePosition.x/WallSize.x*2.0f+0.5f,MousePosition.z/WallSize.z*2.0f+0.5f);
    }
    public Vector2 GetMouseVelocity(){
        float sensitivity = 0.1f; 
        float mouse_move_x = Input.GetAxis("Mouse X") * sensitivity;
        float mouse_move_y = Input.GetAxis("Mouse Y") * sensitivity;
        return new Vector2(mouse_move_x,mouse_move_y);
    }
    
    void Start(){
    
    }
    void Update()
    {           
    }
}
