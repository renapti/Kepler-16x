#version 150
precision highp float;

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

// don't talk to me or my nonexistent son ever again
// terrible code
// Check if two Vec4's are roughly equal between difference of maxDiff
bool vec4EqualsRough(vec4 a, vec4 b, float maxDiff)
{
    if
    (
        (a.x >= ( b.x - maxDiff )) && 
        (a.y >= ( b.y - maxDiff )) && 
        (a.z >= ( b.z - maxDiff )) && 
        (a.x <= ( b.x + maxDiff )) && 
        (a.y <= ( b.y + maxDiff )) && 
        (a.z <= ( b.z + maxDiff ))
        
    )
    {
        return true;
    }
    else
    {
        return false;
    }
}

void main()
{
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;

    if (color.a < 0.1)
    {
        discard;
    }

    // These are the colors for:
    // Inventory Text (Text that says "Inventory" or "Chest," or something similar)
    // Background of Menu Text
    // Background of Chat Text
    // Background of Chat Prompt Text (When you "open chat," which is a different color for some ungodly reason)
    // XP Bar Text
    vec4 genericTextBackground = vec4(0.2471, 0.2471, 0.2471, 1);
    vec4 promptTextBackground = vec4(0.2157, 0.2157, 0.2157, 1); // Like, look at this???
    vec4 xpBarText = vec4(0.4941, 0.9882, 0.1255, 1);

    // Make Inventory Text less ugly
    // This is DEFINITELY NOT an EFFICIENT WAY to do this
    // Still works well nonetheless
    if
    (
        vec4EqualsRough(color, genericTextBackground, 0.005) ||
        vec4EqualsRough(color, promptTextBackground, 0.005)
    )
    {
        // Dark purple, which works well both in the inventory and title screen text
        // (This is my way of saying I'm too lazy to properly fix this)
        // (At least it's not an ugly dark gray anymore)
        color = vec4(0.231, 0.188, 0.365, color.a);
    }

    // Make XP Bar Text white, instead of using color.properties
    // Parity between OptiFine/Colormatic and Vanilla
    if
    (
        vec4EqualsRough(color, xpBarText, 0.005)
    )
    {
        color = vec4(1f);
    }
    
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
