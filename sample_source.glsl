
in Fragment {
    vec3 p1;
    vec3 p2;
    vec3 cl;
    float size;
} frag;

out vec4 cl;

void main(){
    vec2 xy=(gl_FragCoord.xy/"FB"*2-1)*vec2("ASPECT",1);
    float t=rand(xy+time);
    float a=6.3*rand(xy*1.1+time);
    float r=rand(xy*1.2+time);
    vec2 lens=vec2(sin(a)*sqrt(r),cos(a)*sqrt(r));
    vec3 pos=mix(frag.p1,frag.p2,t);
    vec2 m=pos.st-xy+lens*distance(pos.z,fo.x)*fo.y;
    float d=length(m);
    if (d<frag.size*(1.0-pos.z)) {
        cl=vec4(frag.cl,1);
        gl_FragDepth=clamp(pos.z,0.0,0.99);
    } else {
        gl_FragDepth=1.95;
        cl=vec4(0.05);
    }
}

