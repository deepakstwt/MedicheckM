import SwiftUI

struct ConfettiView: View {
    @State private var confettiParticles = [ConfettiParticle]()

    var body: some View {
        ZStack {
            ForEach(confettiParticles) { particle in
                Circle()
                    .frame(width: particle.size, height: particle.size)
                    .foregroundColor(particle.color)
                    .offset(x: particle.offsetX, y: particle.offsetY)
                    .opacity(particle.opacity)
                    .animation(.easeOut(duration: 1.5), value: particle.opacity)
            }
        }
        .onAppear {
            startConfetti()
        }
    }

    private func startConfetti() {
        confettiParticles = (0..<15).map { _ in
            ConfettiParticle(
                offsetX: CGFloat.random(in: -50...50),
                offsetY: CGFloat.random(in: -100...0),
                size: CGFloat.random(in: 8...14),
                color: Color.random,
                opacity: 1.0
            )
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            confettiParticles = confettiParticles.map {
                ConfettiParticle(
                    offsetX: $0.offsetX,
                    offsetY: $0.offsetY - 100,  // Move particles upwards
                    size: $0.size,
                    color: $0.color,
                    opacity: 0.0  // Fade out
                )
            }
        }
    }
}


extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0.5...1),
            green: .random(in: 0.5...1),
            blue: .random(in: 0.5...1)
        )
    }
}


struct ConfettiParticle: Identifiable {
    let id = UUID()
    let offsetX: CGFloat
    let offsetY: CGFloat
    let size: CGFloat
    let color: Color
    let opacity: Double
}
