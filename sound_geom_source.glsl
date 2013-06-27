layout(points) in;
layout(line_strip,max_vertices=4) out;

out Fragment {
    vec4 pos;
} frag;

void note(float ch,float pos,float l,float f) {
    vec4 v=vec4(pos,ch,0,1)*vec4(2.0/"RUNTIME",2.0/"CHANNELS",0,1)-vec4(1,0.95,0,0);

    gl_Position=v;
    frag.pos=vec4(1,pos,l,f);
    EmitVertex();

    gl_Position=v+vec4(l*2/"RUNTIME",0,0,0);
    frag.pos=vec4(1,pos,l,f);
    EmitVertex();
}

void kick(int id,float off,float w) {
    note("KICK",off+id*w,0.25,0);
}

void kosh(int id) {
    note("KOSH",id*0.5+0.3,0.1,0);
}

void main() {
    // Vertex shader writes gl_VertexID as position
    int id=int(gl_in[0].gl_Position.x);

    if (id<30) {
        kick(id,0,0.5);
        return;
    }
    if (id<90) {
        kick(id,15,0.25);
        return;
    }
    if (id<120) {
        kosh(id-60);
        return;
    }
    if (id<150) {
        kick(id,15,1);
        return;
    }
}
