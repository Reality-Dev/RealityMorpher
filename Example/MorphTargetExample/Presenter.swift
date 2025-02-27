//
//  Presenter.swift
//  MorphTargetExample
//
//  Created by Oliver Dew on 09/08/2023.
//

import RealityKit
import SwiftUI
import RealityMorpher

@Observable
final class Presenter {
	private var clothEntity: ModelEntity?
	
	init() {}
	
	func setup(scene: RealityKit.Scene) {
		guard let model = try? ModelEntity.loadModel(named: "cloth0", in: .main),
			  let target = try? ModelEntity.loadModel(named: "cloth1", in: .main).model
		else { return }
		let light = DirectionalLight()
		light.look(at: .zero, from: [4, 6, -1], relativeTo: nil)
		
		let camera = PerspectiveCamera()
		camera.look(at: .zero, from: [2, 3, -3], relativeTo: nil)
		
		let root = AnchorEntity()
		root.addChild(model)
		root.addChild(light)
		root.addChild(camera)
		scene.addAnchor(root)
		
		model.generateCollisionShapes(recursive: true)
		model.components.set(Rotatable())
		model.components.set(Draggable())
		model.name = "Cloth"
		let morphComponent = try! MorphComponent(entity: model, targets: [target])
		clothEntity = model
		model.components.set(morphComponent)
	}
	
	func setupDebug(scene: RealityKit.Scene) {
		BillboardSystem.registerSystem()
		Billboard.registerComponent()
		
		setup(scene: scene)
		guard let clothEntity, let materials = clothEntity.model?.materials as? [CustomMaterial] else { return }
		for (i, material) in materials.enumerated() {
			guard let resource = material.custom.texture?.resource else { continue }
			let height = Float(resource.height) / 100
			var debugMat = UnlitMaterial()
			debugMat.color.texture = .init(resource)
			let plane = ModelEntity(mesh: .generatePlane(width: Float(resource.width) / 100, height: height), materials: [debugMat])
			plane.components.set(Billboard())
			clothEntity.addChild(plane)
			plane.transform.translation = [0, -0.5 + (Float(i) * height), 0]
		}
	}
	
	func onTap() {
		guard var morphComponent = clothEntity?.components[MorphComponent.self] as? MorphComponent else { return }
		let currentWeight = morphComponent.weights[0]
		morphComponent.setTargetWeights([1 - currentWeight, 0, 0], animation: .spring(duration: 1, bounce: 0.5))
		clothEntity?.components.set(morphComponent)
	}
}
