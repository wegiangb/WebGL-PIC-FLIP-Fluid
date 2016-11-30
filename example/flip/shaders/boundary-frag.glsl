
precision highp float;

uniform sampler2D u_grid;
uniform sampler2D u_types;
uniform int u_texLength;
uniform vec3 u_min;
uniform vec3 u_max;
uniform float u_cellSize;
uniform ivec3 u_count;

varying vec2 f_uv;

@import ./include/grid;

void main() {
    // ivec3 count = gridCount(vec3(0.5, 0.5, 0.5) * u_cellSize, u_max, u_min, u_cellSize);
    // ivec3 idx = UVtoXYZ(f_uv, u_texLength, count);

    vec4 current = texture2D(u_grid, f_uv);
    
    ivec3 idx = UVtoXYZ(f_uv, u_texLength, u_count);

    if (!checkIdx(idx, u_count)) {
        discard;
    }

    // ivec3 left = idx - ivec3(1,0,0);
    // ivec3 right = idx + ivec3(1,0,0);
    // ivec3 up = idx + ivec3(0,1,0);
    // ivec3 down = idx - ivec3(0,1,0);
    // ivec3 front = idx + ivec3(0,0,1);
    // ivec3 back = idx - ivec3(0,0,1);

    // set adjacent to solid to 0
    // if (gridComponentAt(u_types, left, count, u_texLength, 0) == 2.0) {
    //   current[0] = max(current[0], 0.0);
    // }
    // if (gridComponentAt(u_types, right, count, u_texLength, 0) == 2.0) {
    //   current[0] = min(current[0], 0.0);
    // }
    // if (gridComponentAt(u_types, down, count, u_texLength, 0) == 2.0) {
    //   current[1] = max(current[1], 0.0);
    // }
    // if (gridComponentAt(u_types, up, count, u_texLength, 0) == 2.0) {
    //   current[1] = min(current[1], 0.0);
    // }
    // if (gridComponentAt(u_types, back, count, u_texLength, 0) == 2.0) {
    //   current[2] = max(current[2], 0.0);
    // }
    // if (gridComponentAt(u_types, front, count, u_texLength, 0) == 2.0) {
    //   current[2] = min(current[2], 0.0);
    // }

    // clamp to bounds
    // current.xyz = mix(current.xyz, clamp(current.xyz, current.xyz, vec3(0,0,0)), vec3(equal(idx, count)));
    // current.xyz = mix(current.xyz, clamp(current.xyz, vec3(0,0,0), current.xyz), vec3(equal(idx, ivec3(0,0,0))));
    // current.xyz = mix(current.xyz, clamp(current.xyz, current.xyz, vec3(0,0,0)), vec3(equal(idx, u_count - 1)));

    if (idx.x == 0) current.x = max(0.0, current.x);
    if (idx.y == 0) current.y = max(0.0, current.y);
    if (idx.z == 0) current.z = max(0.0, current.z);

    if (idx.x == u_count.x - 1) current.x = min(0.0, current.x);
    if (idx.y == u_count.y - 1) current.y = min(0.0, current.y);
    if (idx.z == u_count.z - 1) current.z = min(0.0, current.z);

    gl_FragColor = current;
}