import SwiftUI

struct GuessNumber: View {
    @StateObject private var viewModel = GuessNumberViewModel()

    var body: some View {
        ZStack {
            Image("guess")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Devine le nombre")
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .foregroundColor(.white)

                Picker("Choisir la difficulté", selection: $viewModel.selectedDifficulty) {
                    ForEach(GuessNumberViewModel.Difficulty.allCases) { difficulty in
                        Text(difficulty.rawValue).tag(difficulty)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(10)
                .frame(width: 300, height: 50)
                .onChange(of: viewModel.selectedDifficulty) {
                    viewModel.resetGame()
                }

                TextField("Entre ton nombre", text: $viewModel.userGuess)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 300, height: 50)
                    .disabled(viewModel.gameOver)
                    .font(.title2)

                Button("Valider") {
                    viewModel.checkGuess()
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(viewModel.gameOver)
                .font(.title.weight(.semibold))
                
                Text("Chances restantes : \(viewModel.chancesLeft)")
                    .font(.title.weight(.semibold))
                    .padding()
                    .foregroundColor(.white)
                Text(viewModel.feedback)
                    .font(.title2)
                    .padding()
                    .foregroundColor(viewModel.feedback.contains("Trop") ? .white : .yellow)

                if viewModel.gameOver {
                    Text(viewModel.lostMessage)
                        .font(.title2)
                        .foregroundColor(.red)
                        .padding()
                    
                    Button("Nouvelle partie") {
                        viewModel.resetGame()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.black.opacity(0.65))
            .cornerRadius(20)
        }
        .onAppear {
            viewModel.resetGame()
        }
    }
}

#Preview {
    GuessNumber()
}
