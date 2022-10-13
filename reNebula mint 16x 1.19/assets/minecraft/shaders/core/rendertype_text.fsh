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

vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;

// don't talk to me or my nonexistant son ever again
// terrible code
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

    vec4 invTextColor = vec4(0.247, 0.247, 0.247, 1.0);

    // Make Inventory Text less ugly
    // This is DEFINITELY NOT an EFFICIENT WAY to do this
    if
    (
        vec4EqualsRough(color, invTextColor, 0.002)
    )
    {
        // color = vec4(1.0, 1.0, 1.0, color.a);
        // This is a dark purple, unobtrusive on the title screen (blends in well, even)
        // yet still works well in the Inventory
        color = vec4(0.231, 0.188, 0.365, color.a);
    }
    
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
