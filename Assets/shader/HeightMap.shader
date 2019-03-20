Shader "Unlit/HeightMap"
{
    Properties
    {
        _S2("PhaseVelocity^2", Range(0.0, 0.5)) = 0.5
        _Atten("Attenuation", Range(0.0, 1.0)) = 0.985
        _DeltaUV("Delta UV", Float) = 2
    }
    SubShader{

        Cull Off
        ZWrite Off
        ZTest Always

        Pass{                        
        CGPROGRAM
        #pragma vertex CustomRenderTextureVertexShader
        #pragma fragment frag
            
        #include "UnityCustomRenderTexture.cginc"

        half _S2;
        half _Atten;
        float _DeltaUV;
        float2 _MousePosition;
        float _ShouldRippleRendering;        
        sampler2D _MainTex;

        float4 frag(v2f_customrendertexture  i) : SV_Target{
            float2 uv = i.globalTexcoord;                

            float du = 1.0 / _CustomRenderTextureWidth;
            float dv = 1.0 / _CustomRenderTextureHeight;
            float3 duv = float3(du, dv, 0) * _DeltaUV;
                
            float2 c = tex2D(_SelfTexture2D, uv);
                
            float k = (2.0 * c.r) - c.g;

            float p = (k + _S2 * (
                tex2D(_SelfTexture2D, uv - duv.zy).r +
                tex2D(_SelfTexture2D, uv + duv.zy).r +
                tex2D(_SelfTexture2D, uv - duv.xz).r +
                tex2D(_SelfTexture2D, uv + duv.xz).r - 4.0 * c.r
            )) * _Atten;                

            float color=step(0.3,0.01/sqrt(dot(_MousePosition-uv,_MousePosition-uv))*_ShouldRippleRendering);
            return float4(p, c.r, 0,1.0)+color;
            }
            ENDCG
        }
    }
}
