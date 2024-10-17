import SwiftUI

class GuessNumberViewModel: ObservableObject {
    @Published var userGuess: String = ""
    @Published var randomNumber = Int.random(in: 1...10)
    @Published var feedback: String = ""
    @Published var chancesLeft = 3
    @Published var gameOver = false
    @Published var selectedDifficulty: Difficulty = .facile
    @Published var lostMessage: String = ""
    
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
            lostMessage = "Le nombre à deviner était \(randomNumber)."
            gameOver = true
        }
    }

    func resetGame() {
        randomNumber = Int.random(in: selectedDifficulty.range)
        userGuess = ""
        feedback = ""
        chancesLeft = 3
        gameOver = false
        lostMessage = ""
    }
}
