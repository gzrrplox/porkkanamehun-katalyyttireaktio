
out Vertex {
    vec3 p1;
    vec3 p2;
    vec3 cl;
    float size;
    float cull;
} vx;

vec3 tr(vec4 p){
    float r=length(p);
    float i=acos(p.z/r)*0.8;
    float a=atan(p.x,p.y);
    return vec3(sin(a)*i,cos(a)*i,pow(r/5000.0,0.25));
}

vec3 la(float p) {
    return vec3(bc(0,p*0.5+time*10),bs(1,p*0.5+time*sin(time*10))*2,0);
}

int chars[17]=int[](0,630678,988959,630681,139810,432264,611161,987409,629241,630201,432534,71575,628631,1019678,139823,432537,305561);
//hei
int gr1[3]=int[](3,2,4);
//instanssi in kiva
int gr2[17]=int[](4,9,13,14,1,9,13,13,4,0,10,9,0,6,4,16,1);
//samoin haskell
int gr3[14]=int[](13,1,8,10,4,9,0,3,1,13,6,2,7,7);
//oravatkin ovat hauskoja
int gr4[23]=int[](10,12,1,16,1,14,6,4,9,0,10,16,1,14,0,3,1,15,13,6,10,5,1);
//tumps
int gr5[5]=int[](14,15,8,11,13);
//ja ponit
int gr6[8]=int[](5,1,0,11,10,9,4,14);

//return vec3(word*5+x-11*5,y+bc(0.2,time*pi2*2),150+(-time*20))*0.01;
//return vec3(word*5+x-9*5,y+bc(0.2,time*pi2*4),800+(-time*20))*0.01;

vec3 le(int z,int i,int w) {
    int word=gl_VertexID/20;
    int dot=gl_VertexID%20;
    int x=dot%4;
    int y=dot/4;

    int l=chars[z];

    vx.cull=1;
    if (bool(l & (1<<dot))) vx.cull=0;

    return vec3(i*5+x-w*2.5,y-3,0)*0.07;
}

vec3 rand3(float x) {
    return vec3(rand(vec2(x,0)),rand(vec2(0,x)),rand(vec2(x,x)));
}

vec3 tb(vec3 p,float t) {
    mat4 m=mat4(cos(t),0,sin(t),0,0,1,0,0,-sin(t),0,cos(t),0,0,0,0,1)*
        mat4(1000,0,0,0,0,-1000*"ASPECT",0,0,0,0,1000,1000,0,0,0,1);
    return tr(vec4(p,1)*m);
}

vec3 an(float p,float t){
    vec3 j=vec3(0);
    vx.cull=0;
    int i=gl_VertexID/20;
    float m=1;
    float tp=t*pi;
    float e=0;
    if (tp>47) m=0.5;
    if (tp>72) m=4;
    if (tp>95) e=(tp-90)*0.2+1;

    if (tp>=0&&i<3&&tp<20) {
        j=le(gr1[(i-0)%3],(i-0)%3,3);
        j+= vec3(0,0.1,4-t-bc(1,tp*4)*0.2);
        vx.cl=vec3(1);
        vx.size=0.1;
        return tb(j,0);
    }
    if (i>=3&&i<20) {
        j=le(gr2[(i-3)%17],(i-3)%17,17);
        j+= vec3(10-t-bc(1,tp*4)*0.2,-0.2,0);
        vx.cl=vec3(1,0,0);
        vx.size=0.1;
        return tb(j,0);
    }
    if (i>=20&&i<34) {
        j=le(gr3[(i-20)%14],(i-20)%14,14);
        j+= vec3(15-floor(t),0.2,0);
        vx.cl=vec3(0,1,0);
        vx.size=0.1;
        return tb(j,0);
    }
    if (i>=34&&i<57) {
        j=le(gr4[(i-34)%23],(i-34)%23,23);
        j+= vec3(25-t,sin((j.x+t)*2)*0.2,bc(1,tp*2)+2);
        vx.cl=vec3(1,0,1);
        vx.size=0.1;
        return tb(j,t*0.1*e);
    }
    if (i>=57&&i<62) {
        j=le(gr5[(i-57)%5],(i-57)%5,5);
        j+= vec3(bs(200,t*pi*0.5),bc(200,t*pi),bs(1,t*pi*4*m)*2+2);
        vx.cl=vec3(1,0,1);
        vx.size=0.05*m;
        return tb(j,0);
    }
    if (i>=62&&i<70) { 
        j=le(gr6[(i-62)%8],(i-62)%8,8);
        j+= vec3(bc(1,t*2),bs(1,t*2),0);
        vx.cl=vec3(2,2,0);
        vx.size=0.05;
        return tb(j,0);
    }
    if (e>0) {
        float x=(abs(p-1)*10);
        j=vec3(sin(x),cos(x),bc(1,e+x)*sin(e*2.2+x));
        vx.cl=abs(j);
        vx.size=0.05;
        return tb(j,e);
    }
   
    vx.cull=1;
    return tb(j,0);
}

void main(){
    float p=gl_VertexID/"POINTS"*pi2;
    vx.p1=an(p,time);
    vx.p2=an(p,time+1.0/60.0);
}

