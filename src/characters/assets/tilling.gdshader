shader_type canvas_item;

// The texture you want to tile
uniform sampler2D tiling_texture : repeat_enable, filter_nearest;

// How many times the texture repeats across X and Y axes
uniform vec2 tiling_scale = vec2(4.0, 4.0);

// Scrolling speed for dynamic backgrounds (set to 0,0 for static)
uniform vec2 scroll_speed = vec2(0.0, 0.0);

void fragment() {
    // Offset UVs linearly over time, then scale them up to force repetition
    vec2 shifted_uv = (UV + (scroll_speed * TIME)) * tiling_scale;
    
    // Sample the custom texture using the modified coordinates
    vec4 tex_color = texture(tiling_texture, shifted_uv);
    
    // Multiply by the original UI modulation color (respects self_modulate)
    COLOR = tex_color * COLOR;
}