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
    morph_geometry(params, 1);
}

[[visible]]
void morph_geometry_target_count_2(realitykit::geometry_parameters params)
{
    morph_geometry(params, 2);
}

[[visible]]
void morph_geometry_target_count_3(realitykit::geometry_parameters params)
{
    morph_geometry(params, 3);
}

[[visible]]
void morph_geometry_target_count_4(realitykit::geometry_parameters params)
{
    morph_geometry(params, 4);
}

[[visible]]
void morph_geometry_target_count_5(realitykit::geometry_parameters params)
{
    morph_geometry(params, 5);
}

[[visible]]
void morph_geometry_target_count_6(realitykit::geometry_parameters params)
{
    morph_geometry(params, 6);
}

[[visible]]
void morph_geometry_target_count_7(realitykit::geometry_parameters params)
{
    morph_geometry(params, 7);
}

[[visible]]
void morph_geometry_target_count_8(realitykit::geometry_parameters params)
{
    morph_geometry(params, 8);
}
