import SwiftUI
import RealityKit

struct RealityKitPillView: View {
    @State private var rotationX: Float = 0.0
    @State private var rotationY: Float = 0.0
    @State private var rotationZ: Float = 0.0
    @State private var autoRotate: Bool = true

    var body: some View {
        ARViewContainer(rotationX: $rotationX, rotationY: $rotationY, rotationZ: $rotationZ, autoRotate: $autoRotate)
            .frame(height: 400)
            .cornerRadius(16)
            .shadow(radius: 5)
            .padding()
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        autoRotate = false
                        rotationY += Float(gesture.translation.width / 50)
                        rotationX += Float(gesture.translation.height / 50)
                    }
                    .onEnded { _ in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            autoRotate = true
                        }
                    }
            )
            .onAppear {
                autoRotate = true
            }
    }
}


struct ARViewContainer: UIViewRepresentable {
    @Binding var rotationX: Float
    @Binding var rotationY: Float
    @Binding var rotationZ: Float
    @Binding var autoRotate: Bool

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.environment.background = .color(.white)

        Task { @MainActor in
            let pillEntity = createPillEntity()
            let anchor = AnchorEntity(world: matrix_identity_float4x4)
            pillEntity.scale = SIMD3(2.5, 2.5, 2.5)
            pillEntity.position = SIMD3(0, -0.02, 0)

            anchor.addChild(pillEntity)
            arView.scene.addAnchor(anchor)

            context.coordinator.pillEntity = pillEntity
            autoRotatePill(context: context)
        }

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if autoRotate {
            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                rotationX += 0.2
                rotationY += 0.3
                rotationZ += 0.1
            }
        }

        context.coordinator.pillEntity?.transform.rotation = simd_quatf(angle: rotationX, axis: [1, 0, 0]) *
                                                              simd_quatf(angle: rotationY, axis: [0, 1, 0]) *
                                                              simd_quatf(angle: rotationZ, axis: [0, 0, 1])
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator {
        var pillEntity: Entity?
    }

    private func autoRotatePill(context: Context) {
        Task { @MainActor in
            while autoRotate {
                try? await Task.sleep(nanoseconds: 500_000_000)
                rotationX += Float.random(in: 0.1...0.3)
                rotationY += Float.random(in: 0.2...0.5)
                rotationZ += Float.random(in: 0.1...0.3)

                withAnimation(.linear(duration: 0.5)) {
                    context.coordinator.pillEntity?.transform.rotation =
                        simd_quatf(angle: rotationX, axis: [1, 0, 0]) *
                        simd_quatf(angle: rotationY, axis: [0, 1, 0]) *
                        simd_quatf(angle: rotationZ, axis: [0, 0, 1])
                }
            }
        }
    }
}


@MainActor
private func createPillEntity() -> Entity {
    let pillEntity = Entity()


    let topSphere = ModelEntity(mesh: .generateSphere(radius: 0.12))
    let topMaterial = SimpleMaterial(color: .blue, roughness: 0.3, isMetallic: false)
    topSphere.model?.materials = [topMaterial]
    topSphere.position = SIMD3(0, 0.18, 0) // Moved slightly up


    let bottomSphere = ModelEntity(mesh: .generateSphere(radius: 0.12))
    let bottomMaterial = SimpleMaterial(color: .red, roughness: 0.3, isMetallic: false)
    bottomSphere.model?.materials = [bottomMaterial]
    bottomSphere.position = SIMD3(0, -0.18, 0)

 
    let middleSpheres: [ModelEntity] = (0..<3).map { i in
        let sphere = ModelEntity(mesh: .generateSphere(radius: 0.12))
        let material = SimpleMaterial(color: .white, roughness: 0.3, isMetallic: false)
        sphere.model?.materials = [material]
        sphere.position = SIMD3(0, Float(i) * 0.12 - 0.12, 0)
        return sphere
    }

  
    let lightEntity = Entity()
    let light = DirectionalLightComponent(color: .white, intensity: 2000)
    lightEntity.components.set(light)
    lightEntity.position = SIMD3(0, 1.0, 0)


    pillEntity.transform.rotation = simd_quatf(angle: .pi / 6, axis: [1, 0, 0])


    pillEntity.scale = SIMD3(3.2, 3.2, 3.2)

 
    pillEntity.addChild(topSphere)
    pillEntity.addChild(bottomSphere)
    middleSpheres.forEach { pillEntity.addChild($0) }
    pillEntity.addChild(lightEntity)

    return pillEntity
}


struct RealityKitPillView_Previews: PreviewProvider {
    static var previews: some View {
        RealityKitPillView()
    }
}
