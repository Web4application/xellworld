@vertex
fn vs_main(@location(0) position: vec3<f32>, @location(1) intensity: f32) -> VertexOutput {
    var out: VertexOutput;
    // Apply low-latency vertex transformation
    out.pos = uniforms.mvp * vec4<f32>(position, 1.0);
    // Color-code based on topological height (Neon Teal branding)
    out.color = vec4<f32>(0.0, 0.8, 0.8, intensity); 
    return out;
}
