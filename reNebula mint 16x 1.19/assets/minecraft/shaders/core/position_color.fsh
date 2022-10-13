#version 150

in vec4 vertexColor;
in float vertexDistance;
in vec3 xyzPos;

uniform float GameTime;
uniform vec4 ColorModulator;
uniform vec2 u_resolution;
uniform vec2 ScreenSize;

out vec4 fragColor;

void main() {
    vec4 color = vertexColor;

    if (color.a == 0.0)
    {
        discard;
    }

    // Item Tooltip Border
    if (color.r >= 0.15686 && color.r <= 0.31373 && color.g == 0 && color.b >= 0.49 && color.b <= 1)
    {
        // color = vec4(1.0, 1.0, 1.0, 1.0); White
        color = vec4(0.847, 0.765, 1.0, 1.0);
    }
    // Tooltip Background
    if (color.r == 16 / 255.0 && color.g == 0 / 255.0 && color.b == 16 / 255.0)
    {
        color = vec4(0.141, 0.098, 0.271, 0.90);
    }

    // Slot Hover Color
    if (color.r == 255 / 255.0 && color.g == 255 / 255.0 && color.b == 255 / 255.0 && color.a == 128 / 255.0)
    {
        color = vec4(0.847, 0.765, 1.0, color.a);
    }

    // Resource loading screen
    if (color.r == 239 / 255.0 && color.g == 50 / 255.0 && color.b == 61 / 255.0)
    {
        color = vec4(0.435, 0.29, 0.729, color.a);
    }

    // Sodium checkbox color
    if (color.r == 148 / 255.0 && color.g == 228 / 255.0 && color.b == 211 / 255.0)
    {
        color = vec4(0.753, 0.616, 1.0, 1.0);
    }

    // Options/Worlds Selection Color
    if (color.rgb == vec3(0.5647058823529412) && color.a >= 0.625 && color.a <= 0.6275) {
        color = vec4(1, 1, 1, 0.15);
    }

    fragColor = color * ColorModulator;
}
