Shader "Interface3/MixedTexturesPBR"
{
    Properties
    {
        _MainColor("MainCOlor", Color) = (0, 1, 0, 1)
        _MainTex("MainTexture", 2D) = "white" {}
        _BrickTex("BrickTexture", 2D) = "white" {}
        _MaskTex("MaskTexture", 2D) = "white" {}
        _Cutoff("Cutoff", Range(0.0, 1.0 )) = 0
        _TransitionWidth("Transition Width", Float) = 0.01
        _TransitionStrength("TransitionStrength", Range(0.0, 10.0)) = 1
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
        float _TransitionWidth;
        float _TransitionStrength;

        struct Input 
        { 
            float2 uv_MainTex;
        };

        void surfaceFunction(Input IN, inout SurfaceOutputStandard o) 
        {
            //m is mask value: whether it is brick or plaster;
            float m = step(_Cutoff, tex2D(_MaskTex, IN.uv_MainTex).r);

            float mx = step(_Cutoff, tex2D(_MaskTex, IN.uv_MainTex + float2(_TransitionWidth, 0)).r); 
            float my = step(_Cutoff, tex2D(_MaskTex, IN.uv_MainTex + float2(0, _TransitionWidth)).r); 

            float3 vec1 = normalize(float3(_TransitionStrength, 0, m-mx));
            float3 vec2 = normalize(float3(0, _TransitionStrength, m-my));

            o.Normal = cross(vec1, vec2);

            o.Albedo = m * tex2D(_BrickTex, IN.uv_MainTex).rgb + ( 1 - m ) * tex2D(_MainTex, IN.uv_MainTex).rgb;
        }

        ENDCG
    }
}
