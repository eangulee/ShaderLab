Shader "Hidden/Shader/Common/BlendTestOpA388"
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
            BlendOp RevSub
            Blend OneMinusDstColor OneMinusDstColor
            SetTexture [_SrcTex] { combine texture}
        }
        Pass{
            Blend DstAlpha Zero
            color(1,1,1,1)
        }
    }
}
