import SwiftUI

struct UserGreetingView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .background(Circle().fill(Color.white).shadow(radius: 5))
            
            VStack(alignment: .leading) {
                Text("Hello, Cindy!")
                    .font(.title2).bold()
                HStack {
                    Image(systemName: "flame.fill").foregroundColor(.orange)
                    Text("15 Day Streak | 750 XP")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 3))
    }
}
