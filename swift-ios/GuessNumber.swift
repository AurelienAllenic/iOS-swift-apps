import SwiftUI

struct GuessNumber: View {
    @State private var userGuess: String = ""
    @State private var randomNumber = Int.random(in: 1...10)
    @State private var feedback: String = ""
    @State private var chancesLeft = 3
    @State private var gameOver = false
    
    @State private var selectedDifficulty: Difficulty = .facile
    @State private var lostMessage: String = "" // Message pour afficher le nombre à deviner
    
    enum Difficulty: String, CaseIterable, Identifiable {
        case facile = "1 - 10"
        case moyen = "1 - 50"
        case difficile = "1 - 100"
        
        var id: String { self.rawValue }
        var range: ClosedRange<Int> {
            switch self {
            case .facile:
                return 1...10
            case .moyen:
                return 1...50
            case .difficile:
                return 1...100
            }
        }
    }
    
    func checkGuess() {
        guard let guess = Int(userGuess) else {
            feedback = "Entre un nombre valide !"
            return
        }
        
        if guess < selectedDifficulty.range.lowerBound || guess > selectedDifficulty.range.upperBound {
            feedback = "Entre un nombre entre \(selectedDifficulty.range.lowerBound) et \(selectedDifficulty.range.upperBound) !"
            return
        }
        
        if guess < randomNumber {
            feedback = "Trop petit !"
        } else if guess > randomNumber {
            feedback = "Trop grand !"
        } else {
            feedback = "Correct ! Bravo 🎉"
            gameOver = true
            return
        }
        
        chancesLeft -= 1
        if chancesLeft == 0 {
            feedback = "Désolé, tu as épuisé tes chances !"
            lostMessage = "Le nombre à deviner était \(randomNumber)." // Message pour afficher le nombre perdu
            gameOver = true
        }
    }

    func resetGame() {
        randomNumber = Int.random(in: selectedDifficulty.range) // Assurez-vous de générer un nombre en fonction de la difficulté sélectionnée
        userGuess = ""
        feedback = ""
        chancesLeft = 3
        gameOver = false
        lostMessage = "" // Réinitialise le message de perte
    }

    var body: some View {
        ZStack {
            Image("guess")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.6)

            VStack(spacing: 20) {
                Text("Devine le nombre")
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .foregroundColor(.white)

                Picker("Choisir la difficulté", selection: $selectedDifficulty) {
                    ForEach(Difficulty.allCases) { difficulty in
                        Text(difficulty.rawValue).tag(difficulty)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(10)
                .frame(width: 300, height: 50)
                .onChange(of: selectedDifficulty) { _ in
                    resetGame() // Réinitialisez le jeu lorsque la difficulté change
                }
                
                TextField("Entre ton nombre", text: $userGuess)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(width: 300, height: 50)
                    .disabled(gameOver)
                    .font(.title2)

                Button("Valider") {
                    checkGuess()
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(gameOver)
                .font(.title2)
                
                Text("Chances restantes : \(chancesLeft)")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                Text(feedback)
                    .font(.title2)
                    .padding()
                    .foregroundColor(feedback.contains("Trop") ? .white : .yellow)
                
                // Affiche le message de perte si le jeu est terminé
                if gameOver {
                    Text(lostMessage)
                        .font(.title2)
                        .foregroundColor(.red)
                        .padding()
                    
                    Button("Nouvelle partie") {
                        resetGame()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.black.opacity(0.4))
            .cornerRadius(20)
        }
        .onAppear {
            resetGame() // Reset game on appear to set the random number based on difficulty
        }
    }
}

#Preview {
    GuessNumber()
}
