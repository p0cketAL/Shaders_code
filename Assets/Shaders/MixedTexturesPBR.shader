Shader "Interface3/MixedTexturesPBR"
{
    Properties
    {
        _MainColor("MainCOlor", Color) = (0, 1, 0, 1)
        _MainTex("MainTexture", 2D) = "white" {}
        _BrickTex("BrickTexture", 2D) = "white" {}
        _MaskTex("MaskTexture", 2D) = "white" {}
          _Cutoff("Cutoff", Range(0.0, 1.0 )) = 0
    }
    SubShader
    {
        Tags 
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM

        #pragma surface surfaceFunction Standard fullforwardshadows
        #pragma target 3.0
        
        sampler2D _MainTex;
        half4 _MainColor;
        sampler2D _MaskTex;
        sampler2D _BrickTex;
        float _Cutoff;

        struct Input 
        { 
            float2 uv_MainTex;
        };

        void surfaceFunction(Input IN, inout SurfaceOutputStandard o) 
        {
            float m = step(_Cutoff, tex2D(_MaskTex, IN.uv_MainTex).r);
            o.Albedo = m * tex2D(_BrickTex, IN.uv_MainTex).rgb + ( 1 - m ) * tex2D(_MainTex, IN.uv_MainTex).rgb;
        }

        ENDCG
    }
}
