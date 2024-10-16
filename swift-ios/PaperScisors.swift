import SwiftUI

struct PaperScissors: View {
    // Énumération pour les choix possibles
    enum Choice: String, CaseIterable {
        case pierre = "rock"    // Assure-toi que le nom de l'image est "rock"
        case feuille = "paper"   // Assure-toi que le nom de l'image est "paper"
        case ciseaux = "scisor" // Assure-toi que le nom de l'image est "scissor"
    }
    
    // Variables d'état
    @State private var userChoice: Choice?
    @State private var computerChoice: Choice?
    @State private var result: String = ""
    
    // Fonction pour déterminer le résultat
    func determineWinner() {
        guard let userChoice = userChoice, let computerChoice = computerChoice else { return }
        
        if userChoice == computerChoice {
            result = "Égalité !"
        } else if (userChoice == .pierre && computerChoice == .ciseaux) ||
                    (userChoice == .feuille && computerChoice == .pierre) ||
                    (userChoice == .ciseaux && computerChoice == .feuille) {
            result = "Tu as gagné !"
        } else {
            result = "L'ordinateur a gagné !"
        }
    }
    
    // Fonction pour générer le choix aléatoire de l'ordinateur
    func computerPlay() {
        computerChoice = Choice.allCases.randomElement()
    }
    
    // Fonction pour réinitialiser le jeu
    func resetGame() {
        userChoice = nil
        computerChoice = nil
        result = ""
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Pierre, Feuille, Ciseaux")
                .font(.largeTitle)
                .padding()

            HStack {
                // Boucle pour créer les boutons avec des images
                ForEach(Choice.allCases, id: \.self) { choice in
                    Button(action: {
                        userChoice = choice
                        computerPlay()
                        determineWinner()
                    }) {
                        Image(choice.rawValue) // Utilise le nom de l'énumération pour l'image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100) // Ajuste la taille des images
                    }
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                }
            }

            // Affichage des choix
            if let userChoice = userChoice, let computerChoice = computerChoice {
                VStack {
                    Text("Ton choix : \(userChoice.rawValue.capitalized)")
                    Text("Choix de l'ordinateur : \(computerChoice.rawValue.capitalized)")
                }
                .padding()
            }

            // Affichage du résultat
            Text(result)
                .font(.title)
                .padding()

            // Bouton pour relancer la partie
            if !result.isEmpty {
                Button("Relancer la partie") {
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
    PaperScissors()
}
