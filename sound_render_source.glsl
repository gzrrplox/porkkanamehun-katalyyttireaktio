out vec4 cl;

float t=(gl_FragCoord.s+time*4096)/44100.0;
float sample_pos=t*"TIMERES";

float kick() {
    vec4 x=cg(t,"KICK");
    if (x.x<1) return 0;
    float u=t-x.y;
    float v=cos(pow(1-u*4,3)*100);
    float m=bc(0.3,u/x.z*pi2)*-0.5+0.5;
    return v*m*0.7;
}

float kosh() {
    vec4 x=cg(t,"KOSH");
    if (x.x<1) return 0;
    float u=t-x.y;
    float v=rand(vec2(u,u));
    float m=bc(0.1,u/x.z*pi2)*-0.5+0.5;
    return v*m*0.3;
}



void main(){
    float t=(gl_FragCoord.s/4096+time);
    float f=0;
    for (int i=0; i<10; ++i) {
        f+= texture2DRect(tex,vec2((t*4096)/44100*"TIMERES",i)).y;
    }
    vec4 k=texture2DRect(tex,vec2((t*4096)/44100*"TIMERES",0));
    cl=(vec4(kick()+kosh())*0.5+0.5);
}
