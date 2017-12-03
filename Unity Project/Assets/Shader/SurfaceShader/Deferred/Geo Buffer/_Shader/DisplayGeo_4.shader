﻿Shader "Tut/SurfaceShader/DisplayGeo_4"
{
	Properties
	{

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" "Queue"="Transparent+3000" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};
			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};
			sampler2D _CameraGBufferTexture4;
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv.xy;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_CameraGBufferTexture4, i.uv);
				return col;
			}
			ENDCG
		}
	}
}
