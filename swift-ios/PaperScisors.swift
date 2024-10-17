import SwiftUI

struct PaperScissors: View {

    enum Choice: String, CaseIterable {
        case pierre = "rock"
        case feuille = "paper"
        case ciseaux = "scisor"
    }

    @State private var userChoice: Choice?
    @State private var computerChoice: Choice?
    @State private var result: String = ""
    @State private var victories: Int = 0
    @State private var defeats: Int = 0
    @State private var isGamePaused: Bool = false

    func determineWinner() {
        guard let userChoice = userChoice, let computerChoice = computerChoice else { return }
        
        if userChoice == computerChoice {
            result = "Égalité !"
        } else if (userChoice == .pierre && computerChoice == .ciseaux) ||
                  (userChoice == .feuille && computerChoice == .pierre) ||
                  (userChoice == .ciseaux && computerChoice == .feuille) {
            result = "Tu as gagné !"
            victories += 1 // Incrémente les victoires
        } else {
            result = "Tu as perdu !"
            defeats += 1 // Incrémente les défaites
        }
        
        isGamePaused = true // Met le jeu en pause
    }
    
    func computerPlay() {
        computerChoice = Choice.allCases.randomElement()
    }
    
    func resetGame() {
        userChoice = nil
        computerChoice = nil
        result = ""
        isGamePaused = false // Réactive le jeu
    }
    
    var body: some View {
        ZStack {
            Image("paperScisors")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.6)

            VStack(spacing: 20) {
                Text("Pierre, Feuille, Ciseaux")
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .foregroundColor(.white)

                HStack {
                    ForEach(Choice.allCases, id: \.self) { choice in
                        Button(action: {
                            if !isGamePaused { // Vérifie si le jeu n'est pas en pause
                                userChoice = choice
                                computerPlay()
                                determineWinner()
                            }
                        }) {
                            Image(choice.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 110, height: 100)
                        }
                        .cornerRadius(10)
                        .disabled(isGamePaused) // Désactive les boutons si le jeu est en pause
                    }
                }

                if let userChoice = userChoice, let computerChoice = computerChoice {
                    VStack {
                        Text("Ton choix : \(userChoice.rawValue.capitalized)")
                        Text("Choix de l'ordinateur : \(computerChoice.rawValue.capitalized)")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .font(.title2.weight(.semibold))
                }

                Text(result)
                    .padding()
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.bold))
                HStack{
                    Text("Victoires : \(victories)")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                    Text("Défaites : \(defeats)")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                }
                if !result.isEmpty {
                    Button("Relancer la partie") {
                        resetGame()
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
