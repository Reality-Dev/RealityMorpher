#include <metal_stdlib>
#include <RealityKit/RealityKit.h>
#include "Morph_geometry.h"

using namespace metal;
using namespace realitykit;

// Could also use ModelDebugOptionsComponent(visualizationMode: .normal)
[[visible]]
void debug_normals(realitykit::surface_parameters params)
{
	half3 debug_color = (half3(params.geometry().normal()) + half3(1.)) * 0.5;
	params.surface().set_base_color(debug_color);
}

void morph_geometry(realitykit::geometry_parameters params,
                    float2x4 weights,
                    uint target_count)
{
	uint vertex_id = params.geometry().vertex_id();

    float3 output_normal = params.geometry().normal();
    
	float3 position_offset = float3(0);
    
	uint tex_width = params.textures().custom().get_width();
	
	for (uint target_id = 0; target_id < target_count; target_id ++) {
        
		uint position_id = ((vertex_id * target_count) + target_id) * 2;
        
		uint normal_id = position_id + 1;
        
		float3 target_offset = float3(params.textures().custom().read(uint2(position_id % tex_width, position_id / tex_width)).xyz);
        
        // Use normalOffsets instead of normals so that the shader does not have to sum up the target weights on each call.
		float3 target_normal_offset = float3(params.textures().custom().read(uint2(normal_id % tex_width, normal_id / tex_width)).xyz);
        
        float float_target_id = float(target_id);
        
        uint column = uint(step(4, float_target_id));
        
		float weight = weights[column][target_id - 4 * column];
        
		position_offset += target_offset * weight;
        
		output_normal += target_normal_offset * weight;
	}
	params.geometry().set_model_position_offset(position_offset);
    
	params.geometry().set_normal(normalize(output_normal));
}
