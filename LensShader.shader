﻿Shader "Lens/LensShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"
                "Queue" = "Transparent"
                "IgnoreProjector"="True" }
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha 
        ZWrite Off
        Cull off

        Pass
        {
            //描画しようとしたステンシルバッファが1ならば、ここに入るよ(if文と一緒)
            Stencil
            {
                Ref 1
                Comp Equal
            }

            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;

            fixed4 frag (v2f_img i) : SV_Target
            {
                float alpha = tex2D(_MainTex, i.uv).a;
                fixed4 col = fixed4(0,0,0,255);
                return col;
            }
            ENDCG
        }

        Pass
        {
            //ステンシルバッファに何の値も入っていないのであれば、
            Stencil
            {
                Ref 0
                Comp Equal
            }

            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;

            fixed4 frag (v2f_img i) : SV_Target
            {
                fixed4 col = fixed4(255,255,255,0);
                //fixed4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}