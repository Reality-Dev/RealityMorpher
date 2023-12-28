#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
#include "Morph_geometry.h"

using namespace metal;
using namespace realitykit;

/*
    We cannot use MTLFunctionConstants with RealityKit Geometry Modifiers, hence different targets.
    We could use a float channel
        (such as params.uniforms().uv1_offset().x)
    to pass in the target count, but this would decrease the number of targets we could have by 1, so we do it this way.
*/

[[visible]]
void morph_geometry_target_count_1(realitykit::geometry_parameters params)
{
    const float2x4 weights = float2x4(params.uniforms().custom_parameter(), float4(0));
    morph_geometry(params, weights, 1);
}

[[visible]]
void morph_geometry_target_count_2(realitykit::geometry_parameters params)
{
    const float2x4 weights = float2x4(params.uniforms().custom_parameter(), float4(0));
    morph_geometry(params, weights, 2);
}

[[visible]]
void morph_geometry_target_count_3(realitykit::geometry_parameters params)
{
    const float2x4 weights = float2x4(params.uniforms().custom_parameter(), float4(0));
    morph_geometry(params, weights, 3);
}

[[visible]]
void morph_geometry_target_count_4(realitykit::geometry_parameters params)
{
    const float2x4 weights = float2x4(params.uniforms().custom_parameter(), float4(0));
    morph_geometry(params, weights, 4);
}

[[visible]]
void morph_geometry_target_count_5(realitykit::geometry_parameters params)
{
    /*
     secondaryTextureCoordinateTransform = .init(offset: [vect[4], vect[5]],
                                                 scale: [vect[6], vect[7]],
                                                 rotation: 0)
     */
    
    const float4 column2 = float4(params.uniforms().uv1_offset().x, 0, 0, 0);
    
    const float2x4 weights = float2x4(params.uniforms().custom_parameter(), column2);
    
    morph_geometry(params, weights, 5);
}

[[visible]]
void morph_geometry_target_count_6(realitykit::geometry_parameters params)
{
    
    const float2 uvOffset = params.uniforms().uv1_offset();
    
    const float4 column2 = float4(uvOffset.x, uvOffset.y, 0, 0);
    
    const float2x4 weights = float2x4(params.uniforms().custom_parameter(), column2);
    
    morph_geometry(params, weights, 6);
}

[[visible]]
void morph_geometry_target_count_7(realitykit::geometry_parameters params)
{
    
    float2x2 uvTransformMatrix = params.uniforms().uv1_transform();

    // Extracting scale
    float scaleX = length(uvTransformMatrix[0]);
    
    const float2 uvOffset = params.uniforms().uv1_offset();
    
    const float4 column2 = float4(uvOffset.x, uvOffset.y, scaleX, 0);
    
    const float2x4 weights = float2x4(params.uniforms().custom_parameter(), column2);
    
    morph_geometry(params, weights, 7);
}

[[visible]]
void morph_geometry_target_count_8(realitykit::geometry_parameters params)
{
    float2x2 uvTransformMatrix = params.uniforms().uv1_transform();

    // Extracting scale
    float scaleX = length(uvTransformMatrix[0]);
    
    float scaleY = length(uvTransformMatrix[1]);
    
    const float2 uvOffset = params.uniforms().uv1_offset();
    
    const float4 column2 = float4(uvOffset.x, uvOffset.y, scaleX, scaleY);
    
    const float2x4 weights = float2x4(params.uniforms().custom_parameter(), column2);
    
    morph_geometry(params, weights, 8);
}
