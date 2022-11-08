Shader "Interface3/SimpleTexture"
{
    Properties
    {
        _MainColor("MainCOlor", Color) = (0, 1, 0, 1)
        _MainTex("MainTexture", 2D) = "white" {}
    }
    SubShader
    {
        Tags 
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM

        #pragma surface surfaceFunction Lambert 
        
        sampler2D _MainTex;
        half4 _MainColor;

        struct Input 
        { 
            float2 uv_MainTex;
        };

        void surfaceFunction (Input IN, inout SurfaceOutput OUT) 
        {
            OUT.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _MainColor;
        }

        ENDCG
    }
}
