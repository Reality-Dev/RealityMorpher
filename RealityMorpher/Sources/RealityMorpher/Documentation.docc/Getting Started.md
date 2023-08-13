# Getting Started

Follow these steps to get up and running

## Overview

Each ModelEntity can have up to three Morph Targets. The targets must all be topologically identical to the base model.

### Registration

You must call the static registration method ``MorpherComponent/registerComponent()`` on ``MorpherComponent`` before you start using RealityNorpher.

### Specifying Morph Targets

When you instantiate a ``MorpherComponent`` you pass the base Entity you intend to add the component to, as well as an array of the target models: ``MorpherComponent/init(entity:targets:options:)``. After creating the component, you must add it to the base entity:

```swift
MorpherComponent.registerComponent()
do {
	let model = try ModelEntity.loadModel(named: "rock"),
	let target = try ModelEntity.loadModel(named: "rock_shattered").model
	let morpherComponent = try MorpherComponent(entity: model, targets: [target].compactMap { $0 })
	model.components.set(morpherComponent)
} catch {
	// handle errors
}
```

### Blending between Morph Targets

Animate between the different Morph Targets by assigning a weight for each target. Up to 3 weights are contained in the ``MorpherWeights`` object. A weight of 0
- ``MorpherComponent/setTargetWeights(_:animation:)``

### Describing the weight of each target

- ``MorpherWeights/init(_:)``

### Specifying how a change in weight should be animated

- ``MorpherAnimation/init(duration:mode:)``