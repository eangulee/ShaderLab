// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Tut/Shadow/BuildInShadow/Caster_2" {

SubShader {
	//normal pass to render object
		pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
	
			struct vertOut {
				float4 oPos:SV_POSITION;
			};
			vertOut vert(appdata_base v)
			{
				vertOut o;
				float4 pos=UnityObjectToClipPos(v.vertex);
				o.oPos=pos;
				return o;
			}
			float4 frag(vertOut i):COLOR
			{
				float4 c;
				c=float4(0.3,0.3,0.3,0.3);
				return c;
			}
			ENDCG
		}
    // Pass to render object as a shadow caster
    Pass {
       Name "ShadowCaster"
       Tags { "LightMode" = "ShadowCaster" }

       Fog {Mode Off}
       ZWrite On ZTest Less Cull Off
       //Offset [_ShadowBias], [_ShadowBiasSlope]

		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma multi_compile SHADOWS_NATIVE SHADOWS_CUBE
		#pragma fragmentoption ARB_precision_hint_fastest
		#include "UnityCG.cginc"

		struct v2f { 
		    //V2F_SHADOW_CASTER;
		    float4 pos : SV_POSITION; 
		    float4 hpos : TEXCOORD1;
		    float3 vec : TEXCOORD0;
		};
		
		v2f vert( appdata_base v )
		{
		    v2f o;
		    //TRANSFER_SHADOW_CASTER(o)
		    o.vec = mul( unity_ObjectToWorld, v.vertex ).xyz - _LightPositionRange.xyz;
		    o.pos = UnityObjectToClipPos(v.vertex);
		    o.pos.z += unity_LightShadowBias.x; 
		    //float clamped = max(o.pos.z, 0.0);
		    float clamped = max(o.pos.z, -o.pos.w);
		    o.pos.z = lerp(o.pos.z, clamped, unity_LightShadowBias.y); 
		    o.hpos = o.pos;
		    return o;
		}
		
		float4 frag( v2f i ) : COLOR
		{
		    //SHADOW_CASTER_FRAGMENT(i)
		    return EncodeFloatRGBA( length(i.vec) *( _LightPositionRange.w));
		}
		ENDCG

    }//endpass
	}
}

