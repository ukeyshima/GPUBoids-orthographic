﻿Shader "Unlit/Reaf"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag            
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

               float random1(float3 p){
                return frac(sin(dot(p.xyz,float3(12.9898,46.2346,78.233)))*43758.5453123)*2.0-1.0;
            }
            float random2(float3 p){
                return frac(sin(dot(p.xyz,float3(73.6134,21.6712,51.5781)))*51941.3781931)*2.0-1.0;
            }
            float random3(float3 p){
                return frac(sin(dot(p.xyz,float3(39.1831,85.3813,16.2981)))*39183.4971731)*2.0-1.0;
            }
            float random4(float3 p){
                return frac(sin(dot(p.xyz,float3(43.5124,51.1244,82.1841)))*73912.1234123)*2.0-1.0;
            }
            float random5(float3 p){
                return frac(sin(dot(p.xyz,float3(52.1344,31.4841,62.1847)))*64819.3839193)*2.0-1.0;
            }
            float random6(float3 p){
                return frac(sin(dot(p.xyz,float3(63.3381,41.3124,97.1324)))*87281.1234123)*2.0-1.0;
            }
            float perlinNoise(float3 p){
                float3 i1=floor(p);    
                float3 i2=i1+float3(1.0,0.0,0.0);
                float3 i3=i1+float3(0.0,1.0,0.0);
                float3 i4=i1+float3(1.0,1.0,0.0);
                float3 i5=i1+float3(0.0,0.0,1.0);
                float3 i6=i1+float3(1.0,0.0,1.0);
                float3 i7=i1+float3(0.0,1.0,1.0);
                float3 i8=i1+float3(1.0,1.0,1.0);
                float3 f1=float3(random1(i1),random2(i1),random3(i1));
                float3 f2=float3(random1(i2),random2(i2),random3(i2));
                float3 f3=float3(random1(i3),random2(i3),random3(i3));
                float3 f4=float3(random1(i4),random2(i4),random3(i4));
                float3 f5=float3(random1(i5),random2(i5),random3(i5));
                float3 f6=float3(random1(i6),random2(i6),random3(i6));
                float3 f7=float3(random1(i7),random2(i7),random3(i7));
                float3 f8=float3(random1(i8),random2(i8),random3(i8));
                float3 k1=p-i1;
                float3 k2=p-i2;
                float3 k3=p-i3;
                float3 k4=p-i4;
                float3 k5=p-i5;
                float3 k6=p-i6;
                float3 k7=p-i7;
                float3 k8=p-i8;
                float3 j=frac(p);
                j=j*j*(3.0-2.0*j);
              	return lerp(lerp(lerp(dot(f1,k1),dot(f2,k2),j.x),lerp(dot(f3,k3),dot(f4,k4),j.x),j.y),lerp(lerp(dot(f5,k5),dot(f6,k6),j.x),lerp(dot(f7,k7),dot(f8,k8),j.x),j.y),j.z);
            }   

                float perlinNoise2(float3 p){
                float3 i1=floor(p);    
                float3 i2=i1+float3(1.0,0.0,0.0);
                float3 i3=i1+float3(0.0,1.0,0.0);
                float3 i4=i1+float3(1.0,1.0,0.0);
                float3 i5=i1+float3(0.0,0.0,1.0);
                float3 i6=i1+float3(1.0,0.0,1.0);
                float3 i7=i1+float3(0.0,1.0,1.0);
                float3 i8=i1+float3(1.0,1.0,1.0);
                float3 f1=float3(random4(i1),random5(i1),random6(i1));
                float3 f2=float3(random4(i2),random5(i2),random6(i2));
                float3 f3=float3(random4(i3),random5(i3),random6(i3));
                float3 f4=float3(random4(i4),random5(i4),random6(i4));
                float3 f5=float3(random4(i5),random5(i5),random6(i5));
                float3 f6=float3(random4(i6),random5(i6),random6(i6));
                float3 f7=float3(random4(i7),random5(i7),random6(i7));
                float3 f8=float3(random4(i8),random5(i8),random6(i8));
                float3 k1=p-i1;
                float3 k2=p-i2;
                float3 k3=p-i3;
                float3 k4=p-i4;
                float3 k5=p-i5;
                float3 k6=p-i6;
                float3 k7=p-i7;
                float3 k8=p-i8;
                float3 j=frac(p);
                j=j*j*(3.0-2.0*j);
                return lerp(lerp(lerp(dot(f1,k1),dot(f2,k2),j.x),lerp(dot(f3,k3),dot(f4,k4),j.x),j.y),lerp(lerp(dot(f5,k5),dot(f6,k6),j.x),lerp(dot(f7,k7),dot(f8,k8),j.x),j.y),j.z);
            }  

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal :NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;                
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;             
                v.vertex.xz+=float2(perlinNoise(v.vertex.xyz*10.0),perlinNoise2(v.vertex.xyz*10.0))/20.0;
                v.vertex.y+=
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);                 
                return o;
            }

            fixed4 frag (v2f i) : SV_Target{  
                fixed4 col = tex2D(_MainTex, i.uv)*fixed4(0.1,0.7,0.1,1.0)+(perlinNoise(float3(i.uv/100.0,_Time.y)));
                return col;
            }
            ENDCG
        }
    }
}
