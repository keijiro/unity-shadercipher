Shader "Custom/Decipher" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_NoiseScale ("Noise Scale", float) = 50.0
		_NoiseOffset ("Noise Offset", float) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		Pass {
			GLSLPROGRAM

			uniform sampler2D _MainTex;
			uniform float _NoiseScale;
			uniform float _NoiseOffset;
			varying vec4 uv;

			#ifdef VERTEX

			void main()
			{
				uv = gl_MultiTexCoord0;
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
			}

			#endif

			#ifdef FRAGMENT

			#include "noise2D.glslinc"

			void main()
			{
				vec4 t = texture2D(_MainTex, vec2(uv));
				vec4 n = vec4(snoise(vec2(uv) * _NoiseScale + _NoiseOffset));
				gl_FragColor = t * 2.0 - n * 0.5 - 0.5;
			}

			#endif

			ENDGLSL
		}
	}
}
