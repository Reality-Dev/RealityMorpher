//
//  Header.h
//  
//
//  Created by Grant Jarvis on 12/15/23.
//

// Morph_geometry.h

#ifndef MORPH_GEOMETRY_H
#define MORPH_GEOMETRY_H

#include <metal_stdlib>
#include <RealityKit/RealityKit.h>

void morph_geometry(realitykit::geometry_parameters params, metal::float2x4 weights, uint target_count);

#endif

