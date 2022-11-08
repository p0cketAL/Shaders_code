Shader "Interface3/SimpleLambert"
{
    Properties
    {
        _MainColor("MainCOlor", Color) = (0, 1, 0, 1)
    }
    SubShader
    {
        Tags 
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM

        #pragma surface surfaceFunction SimpleLambert 

        half4 _MainColor;

        struct Input 
        { 
            int a;

        };

        void surfaceFunction (Input IN, inout SurfaceOutput OUT) 
        {
            OUT.Albedo = _MainColor;
        }

        half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten) 
        {
            half NdotL = saturate(dot(-s.Normal, lightDir));
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * NdotL * atten;
            c.a = s.Alpha;
            return c;
        } 

        ENDCG
    }
}
