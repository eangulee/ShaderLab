Shader "Hidden/Shader/Common/BlendTestOp031"
{
    Properties {
        _DstTex ("DstTex", 2D) ="white"{}
        _SrcTex ("SrcTex", 2D) ="white"{}
    }
    SubShader {
        Pass{
            SetTexture[_DstTex] {combine texture}
        }
        Pass {
            BlendOp Max
            Blend SrcAlpha Zero
            SetTexture [_SrcTex] { combine texture}
        }
    }
}
