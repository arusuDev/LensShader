Shader "Lens/LensObjectShader"
{
 Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent"
                "Queue" = "Transparent" }
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha 
        Cull off
        Pass
        {
            //使用したいShaderに
            //Stencil
            //{
            //    Ref N(任意の数字)
            //    Comp Always
            //    Pass Replace
            //}
            //を入れて、そこの部分と、Stencil Ref 0は何色(水色とかなのかな？)で
            //描画する、みたいに決めておくと、
            //もしかしたらそれっぽくなるかもです！（わからないけど…ｗ)
            
            //各ピクセルごとの描画条件を決めるための変数ステンシルバッファに、1を代入する。
            Stencil
            {
                Ref 1
                Comp Always
                Pass Replace
            }

            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            sampler2D _MainTex;

            fixed4 frag (v2f_img i) : COLOR
            {
                fixed4 col = fixed4(0,0,0,0);
                return col;
            }
            ENDCG
        }
    }
}
