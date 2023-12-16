//
//  MorphEnvironment.swift
//  RealityMorpher
//
//  Created by Oliver Dew on 10/08/2023.
//

import Metal
import RealityKit
import RealityMorpherKernels

final class MorphEnvironment {
	static private(set) var shared = MorphEnvironment()
	
	static let maxTargetCount = 8
	
	let morphGeometryModifiers: [CustomMaterial.GeometryModifier]
	let debugShader: CustomMaterial.SurfaceShader
	
	private init() {
		guard let device = MTLCreateSystemDefaultDevice() else { fatalError("Metal not supported") }
		let library = try! device.makeDefaultLibrary(bundle: .kernelsModule())
		morphGeometryModifiers = (1...Self.maxTargetCount).map { count in
			CustomMaterial.GeometryModifier(named: "morph_geometry_target_count_\(count)", in: library)
		}
		debugShader = CustomMaterial.SurfaceShader(named: "debug_normals", in: library)
		MorphSystem.registerSystem()
	}
}

/// System that animates updates to meshes when a ``MorphComponent`` has an update
private struct MorphSystem: System {
	
	private let query = EntityQuery(where: .has(MorphComponent.self) && .has(ModelComponent.self))

	fileprivate init(scene: Scene) {}

	fileprivate func update(context: SceneUpdateContext) {
		for entity in context.scene.performQuery(query) {
			guard let morpher = (entity.components[MorphComponent.self] as? MorphComponent)?.updated(deltaTime: context.deltaTime),
				  var model = entity.components[ModelComponent.self] as? ModelComponent
			else { continue }
			
			model.materials = model.materials.enumerated().map { index, material in
				guard var customMaterial = material as? CustomMaterial else { return material }
				let resource = morpher.textureResources[index]
                customMaterial.storeData(from: morpher.currentWeights)
				customMaterial.custom.texture = .init(resource)
				return customMaterial
			}
			entity.components.set(model)
			entity.components.set(morpher)
		}
	}
}

extension CustomMaterial {
    mutating func storeData(from vect: SIMD8<Float>) {
        
        custom.value = vect.lowHalf
        
        // We need somewhere else to pass the data to the shader.
        // We use `secondaryTextureCoordinateTransform` because it is typically not made use of as often for other purposes.
        secondaryTextureCoordinateTransform = .init(offset: [vect[4], vect[5]],
                                                    scale: [vect[6], vect[7]],
                                                    rotation: 0)
        
        // The rest of the 16 elements are not used. We currently only support up to 8 elements.
    }
}
