Shader "Interface3/SimplePBR"
{
    Properties
    {
        _MainColor("MainCOlor", Color) = (0, 1, 0, 1)
        _MainTex("MainTexture", 2D) = "white" {}
        _Metallic("Metallic", Range(0.0, 1.0 )) = 0
        _Smoothness("Smoothness", Range(0.0, 1.0 )) = 0
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
        float _Metallic;
        float _Smoothness;

        struct Input 
        { 
            float2 uv_MainTex;
        };

        void surfaceFunction (Input IN, inout SurfaceOutputStandard OUT) 
        {
            OUT.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _MainColor;
            OUT.Metallic = _Metallic;
            OUT.Smoothness = _Smoothness;
        }

        ENDCG
    }
}
