import SwiftUI

struct MenuAppsView: View {
    @StateObject private var authModel = MainViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: JackpotMachine()) {
                    ZStack {
                        Image("jackpot")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 100)
                            .cornerRadius(10)
                        
                        Color.black.opacity(0.4)
                            .cornerRadius(10)

                        Text("Jackpot machine")
                            .padding(20)
                            .foregroundColor(.white)
                            .font(.title.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .frame(height: 100)

                NavigationLink(destination: PaperScissors()) {
                    ZStack {
                        Image("paperScisors")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 100)
                            .cornerRadius(10)
                        Color.black.opacity(0.4)
                            .cornerRadius(10)
                        
                        Text("PaperScissors")
                            .padding(20)
                            .foregroundColor(.white)
                            .font(.title.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .frame(height: 100)
                
                NavigationLink(destination: GuessNumber()) {
                    ZStack {
                        Image("guess")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 100)
                            .cornerRadius(10)
                        Color.black.opacity(0.4)
                            .cornerRadius(10)
                        
                        Text("Guess the number")
                            .padding(20)
                            .foregroundColor(.white)
                            .font(.title.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .frame(height: 100)
            }
            .navigationTitle("Liste des applications")
            .padding(50)
            .font(.title)
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    MenuAppsView()
}
