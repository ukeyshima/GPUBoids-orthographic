Shader "Hidden/GPUBoids/BoidsRender"{
    Properties{
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
        SubShader{
            Tags {"RenderType"="Transparent" "Queue"="Transparent"}          
            Blend SrcAlpha One  
            LOD 200

            CGPROGRAM                       
            #pragma surface surf Lambert alpha vertex:vert
            #pragma instancing_options procedural:setup

                struct Input{
                    float2 uv_MainTex;                    
                    float3 vert_color;
                    float3 viewDir;
                };

                struct BoidData{
                    float3 velocity; 
                    float3 position; 
                    float scale;                    
                };

                #ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
                StructuredBuffer<BoidData> _BoidDataBuffer;
                #endif

                sampler2D _MainTex; 
                float _ObjectScale;

                float4x4 eulerAnglesToRotationMatrix(float3 angles) {
                    float ch = cos(angles.y); float sh = sin(angles.y); 
                    float ca = cos(angles.z); float sa = sin(angles.z); 
                    float cb = cos(angles.x); float sb = sin(angles.x); 
                    return float4x4( ch * ca + sh * sb * sa, -ch * sa + sh * sb * ca, sh * cb, 0, cb * sa, cb * ca, -sb, 0, -sh * ca + ch * sb * sa, sh * sa + ch * sb * ca, ch * cb, 0, 0, 0, 0, 1);
                }

                void vert(inout appdata_full v, out Input o){
                UNITY_INITIALIZE_OUTPUT(Input, o);
                #ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

                BoidData boidData = _BoidDataBuffer[unity_InstanceID];
                float3 pos = boidData.position.xyz; 
                float scl = boidData.scale;              

                float4x4 object2world = (float4x4)0;

                v.vertex.x+=sin(v.vertex.y*6.0+_Time.x*150.0)*smoothstep(-0.2,0.66,v.vertex.y)*0.1;                                

                object2world._11_22_33_44 = float4((float3)_ObjectScale*scl, 1.0);

                float rotY = atan2(boidData.velocity.x, boidData.velocity.z);

                float rotX = -asin(boidData.velocity.y / (length(boidData.velocity.xyz) + 1e-8)); 

                float4x4 rotMatrix = eulerAnglesToRotationMatrix(float3(rotX+3.14*3/2, rotY, 0));

                object2world = mul(rotMatrix, object2world);

                object2world._14_24_34 += pos.xyz;

                v.vertex = mul(object2world, v.vertex);

                o.vert_color+=(float3)clamp((v.vertex.y)/20.0+0.5,0.0,1.0)*0.5 +(normalize(boidData.velocity)+0.5)*0.5;                

                v.normal = normalize(mul(object2world, v.normal));

                #endif
        }
                
        void setup(){}

        void surf (Input IN, inout SurfaceOutput o){
            half rim = 1.0-saturate(dot (normalize(IN.viewDir), o.Normal));            
            o.Emission=IN.vert_color* pow (rim, 1.3);
            o.Alpha=0.9;
        }
        ENDCG
    }
    FallBack "Diffuse"
}