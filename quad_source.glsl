float[4] y = float[](1,1,-1,-1);
float[4] x = float[](1,-1,1,-1);

void main(){
    gl_Position = vec4(x[gl_VertexID],y[gl_VertexID],0,1);
}
