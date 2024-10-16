import SwiftUI

struct GuessNumber: View {
    @State private var userGuess: String = ""
    @State private var randomNumber = Int.random(in: 1...10)
    @State private var feedback: String = ""
    @State private var chancesLeft = 3  // Nombre de chances restantes
    @State private var gameOver = false // Indicateur de fin de partie

    func checkGuess() {
        guard let guess = Int(userGuess) else {
            feedback = "Entre un nombre valide !"
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
        
        chancesLeft -= 1  // Réduction des chances après chaque tentative

        if chancesLeft == 0 {
            feedback = "Désolé, tu as épuisé tes chances !"
            gameOver = true
        }
    }

    func resetGame() {
        randomNumber = Int.random(in: 1...10)
        userGuess = ""
        feedback = ""
        chancesLeft = 3
        gameOver = false
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Devine le nombre (1 à 10)")
                .font(.title)
                .padding()

            TextField("Entre ton nombre", text: $userGuess)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(width: 200)
                .disabled(gameOver)

            Button("Valider") {
                checkGuess()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(gameOver)

            Text(feedback)
                .font(.title2)
                .padding()

            Text("Chances restantes : \(chancesLeft)")
                .font(.headline)
                .padding()

            if gameOver {
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
    }
}

#Preview {
    MenuAppsView()
}
