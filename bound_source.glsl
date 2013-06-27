
layout(points) in;
layout(triangle_strip,max_vertices=4) out;

in Vertex {
    vec3 p1;
    vec3 p2;
    vec3 cl;
    float size;
    float cull;
} vx[];

out Fragment {
    vec3 p1;
    vec3 p2;
    vec3 cl;
    float size;
} frag;

void main() {
   if (vx[0].cull>0) return;

   vec4 p1=vec4(vx[0].p1,1.0);
   vec4 p2=vec4(vx[0].p2,1.0);
   vec4 d=vec4(normalize(p2.xy-p1.xy),0,0);
   if (distance(p2.xy,p1.xy)<0.0001) d=vec4(1,0,0,0);
   vec4 n=vec4(-d.y,d.x,0,0);
   float size=vx[0].size;
   float z1=distance(p1.z,fo.x)*fo.y+size*(1.0-p1.z);
   float z2=distance(p2.z,fo.x)*fo.y+size*(1.0-p2.z);
   frag.p1=p1.xyz*vec3("ASPECT",1,1);
   frag.p2=p2.xyz*vec3("ASPECT",1,1);
   frag.cl=vx[0].cl;
   frag.size=size;
   gl_Position=p1-n*z1-d*z1;
   EmitVertex();
   gl_Position=p1+n*z1-d*z1;
   EmitVertex();
   gl_Position=p2-n*z2+d*z2;
   EmitVertex();
   gl_Position=p2+n*z2+d*z2;
   EmitVertex();
}

