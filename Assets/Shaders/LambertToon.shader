Shader "Interface3/LambertToon"
{
    Properties
    {
        _MainColor("MainCOlor", Color) = (0, 1, 0, 1)
        _ToonRamp("ToonRamp", 2D) = "white" {}
        _SecondTexture("SecondTexture", 2D) = "white" {}
    }
    SubShader
    {
        Tags 
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM

        #pragma surface surfaceFunction LambertToon 

        half4 _MainColor;
        sampler2D _ToonRamp;
        sampler2D _SecondTexture;

        struct Input 
        { 
            //int a;
            half2 uv_MainTex;

        };

        void surfaceFunction (Input IN, inout SurfaceOutput OUT) 
        {
            OUT.Albedo = tex2D(_SecondTexture, IN.uv_MainTex) * _MainColor;
        }

        half4 LightingLambertToon(SurfaceOutput s, half3 lightDir, half atten) 
        {
            half NdotL = saturate(dot(s.Normal, lightDir));
            half lightStrength = tex2D(_ToonRamp, half2(NdotL, 0.5));
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * lightStrength * atten;
            c.a = s.Alpha;
            return c;
        } 

        ENDCG
    }
}
