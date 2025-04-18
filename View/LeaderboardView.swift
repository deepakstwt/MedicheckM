import SwiftUI

struct LeaderboardView: View {
    let leaderboard = [
        ("Sarah K.", 1250, "🏆"),
        ("You", 750, "⭐"),
        ("Mike", 620, "🥉")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("🏅 Top Medicine Managers")
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(leaderboard.indices, id: \ .self) { index in
                HStack {
                    Text("\(leaderboard[index].2) \(leaderboard[index].0)")
                        .fontWeight(leaderboard[index].0 == "You" ? .bold : .regular)
                        .foregroundColor(leaderboard[index].0 == "You" ? .blue : .black)
                    Spacer()
                    Text("\(leaderboard[index].1) XP")
                        .foregroundColor(.gray)
                        .scaleEffect(leaderboard[index].0 == "You" ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.5), value: leaderboard[index].0 == "You")
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(radius: leaderboard[index].0 == "You" ? 6 : 3)
                )
            }
        }
        .padding()
    }
}
