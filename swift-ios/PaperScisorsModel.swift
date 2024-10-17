import Foundation
import SwiftUI

class PaperScissorsViewModel: ObservableObject {
    enum Choice: String, CaseIterable {
        case pierre = "rock"
        case feuille = "paper"
        case ciseaux = "scisor"
    }

    @Published var userChoice: Choice?
    @Published var computerChoice: Choice?
    @Published var result: String = ""
    @Published var victories: Int = 0
    @Published var defeats: Int = 0
    @Published var isGamePaused: Bool = false

    func determineWinner() {
        guard let userChoice = userChoice, let computerChoice = computerChoice else { return }
        
        if userChoice == computerChoice {
            result = "Égalité !"
        } else if (userChoice == .pierre && computerChoice == .ciseaux) ||
                  (userChoice == .feuille && computerChoice == .pierre) ||
                  (userChoice == .ciseaux && computerChoice == .feuille) {
            result = "Tu as gagné !"
            victories += 1
        } else {
            result = "Tu as perdu !"
            defeats += 1
        }
        
        isGamePaused = true
    }
    
    func computerPlay() {
        computerChoice = Choice.allCases.randomElement()
    }
    
    func resetGame() {
        userChoice = nil
        computerChoice = nil
        result = ""
        isGamePaused = false
    }
}
