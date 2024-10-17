import SwiftUI

struct PaperScissors: View {
    @StateObject private var viewModel = PaperScissorsViewModel()

    var body: some View {
        ZStack {
            Image("paperScisors")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Pierre, Feuille, Ciseaux")
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .foregroundColor(.white)

                HStack {
                    ForEach(PaperScissorsViewModel.Choice.allCases, id: \.self) { choice in
                        VStack {
                            Button(action: {
                                if !viewModel.isGamePaused {
                                    viewModel.userChoice = choice
                                    viewModel.computerPlay()
                                    viewModel.determineWinner()
                                }
                            }) {
                                Image(choice.rawValue)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 110, height: 100)
                                    .cornerRadius(15)
                            }

                            Text(choice.rawValue.capitalized)
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        .cornerRadius(10)
                        .disabled(viewModel.isGamePaused)
                    }
                }

                if let userChoice = viewModel.userChoice, let computerChoice = viewModel.computerChoice {
                    VStack {
                        Text("Ton choix : \(userChoice.rawValue.capitalized)")
                        Text("Choix de l'ordinateur : \(computerChoice.rawValue.capitalized)")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .font(.title2.weight(.semibold))
                }

                Text(viewModel.result)
                    .padding()
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.bold))
                
                HStack {
                    Text("Victoires : \(viewModel.victories)")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                    Text("Défaites : \(viewModel.defeats)")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                }

                if !viewModel.result.isEmpty {
                    Button("Relancer la partie") {
                        viewModel.resetGame()
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.title.weight(.semibold))
                }
            }
            .padding()
            .background(Color.black.opacity(0.4))
            .cornerRadius(20)
        }
    }
}

#Preview {
    PaperScissors()
}
