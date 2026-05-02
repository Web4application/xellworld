// shader.wgsl - High-performance topological renderer
struct Uniforms {
    modelViewProjectionMatrix : mat4x4<f32>,
};
@binding(0) @group(0) var<uniform> uniforms : Uniforms;

struct VertexOutput {
    @builtin(position) Position : vec4<f32>,
    @location(0) vColor : vec4<f32>,
};

@vertex
fn main(@location(0) pos : vec3<f32>, @location(1) depth : f32) -> VertexOutput {
    var output : VertexOutput;
    // Map depth data from .bth to color (Blue for deep, Green for shallow)
    output.vColor = vec4<f32>(0.0, 1.0 - depth, depth, 1.0);
    output.Position = uniforms.modelViewProjectionMatrix * vec4<f32>(pos, 1.0);
    return output;
}
