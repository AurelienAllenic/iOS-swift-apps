import SwiftUI

struct MenuAppsView: View {
    @StateObject private var authModel = MainViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Image("pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(0.7)
                
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .overlay(
                        VStack {
                            Text("Liste des applications")
                                .font(.title.weight(.bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(25)

                            NavigationLink(destination: JackpotMachine()) {
                                ZStack {
                                    Image("jackpot")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 100)
                                        .cornerRadius(10)
                                    Color.black.opacity(0.4)
                                        .cornerRadius(10)
                                        .frame(width: 300, height: 100)

                                    Text("Jackpot machine")
                                        .padding(20)
                                        .foregroundColor(.white)
                                        .font(.title.weight(.semibold))
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
                                        .frame(width: 300, height: 100)

                                    Text("PaperScissors")
                                        .padding(20)
                                        .foregroundColor(.white)
                                        .font(.title.weight(.semibold))
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
                                        .frame(width: 300, height: 100)

                                    Text("Guess the number")
                                        .padding(20)
                                        .foregroundColor(.white)
                                        .font(.title.weight(.semibold))
                                }
                            }
                            .frame(height: 100)
                            
                            NavigationLink(destination: TicTacToeView()) {
                                ZStack {
                                    Image("tictactoe")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 100)
                                        .cornerRadius(10)

                                    Color.black.opacity(0.4)
                                        .cornerRadius(10)
                                        .frame(width: 300, height: 100)

                                    Text("Tic Tac Toe")
                                        .padding(20)
                                        .foregroundColor(.white)
                                        .font(.title.weight(.semibold))
                                }
                            }
                            .frame(height: 100)
                        }
                        
                        .padding()
                    )
            }
        }
    }
}

#Preview {
    MenuAppsView()
}
