Shader "Hidden/Shader/Common/BlendTestOp210"
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
            BlendOp Sub
            Blend Zero One
            SetTexture [_SrcTex] { combine texture}
        }
    }
}
