Shader "Interface3/SimpleColor"
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

        #pragma surface surfaceFunction Lambert 

        half4 _MainColor;

        struct Input 
        { 
            int a;

        };

        void surfaceFunction (Input IN, inout SurfaceOutput OUT) 
        {
            OUT.Albedo = _MainColor;
        }

        ENDCG
    }
}
