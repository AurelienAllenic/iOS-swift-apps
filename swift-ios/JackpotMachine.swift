import SwiftUI

struct JackpotMachine: View {
    @State private var numbers = [0, 0, 0]
    @State private var message = ""
    @State private var credits = 100
    @State private var isSpinning = false
    @State private var isTextHidden = true
    @State private var isButtonHidden = true

    var body: some View {
        ZStack {
            // Image en fond
            Image("jackpot")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.6) // Ajuste l'opacité si tu veux que l'image soit plus discrète

            // Contenu du jeu
            VStack {
                Text("Jackpot Machine")
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .foregroundColor(.white)

                Text("Credits: \(credits)")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)

                HStack {
                    ForEach(0..<3, id: \.self) { index in
                        Text("\(numbers[index])")
                            .font(.system(size: 60))
                            .padding()
                            .frame(width: 80, height: 100)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .offset(y: isSpinning ? 20 : 0)
                            .animation(
                                isSpinning ? Animation.linear(duration: 0.1)
                                    .repeatCount(20, autoreverses: true) : .default,
                                value: isSpinning
                            )
                    }
                }
                .padding()

                if !isTextHidden {
                    Text(message)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                }

                Button(action: {
                    spinReels()
                }) {
                    Text("Test your luck !")
                        .font(.title)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(isSpinning)

                if !isButtonHidden {
                    Button(action: {
                        giveNewCredits()
                    }) {
                        Text("Ajouter Crédit")
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .padding()
            .background(Color.black.opacity(0.4)) // Fond noir avec opacité autour de la VStack
            .cornerRadius(20) // Coins arrondis pour le rectangle

            // Ajout d'un rectangle en fond avec opacité
            .padding()
        }
    }

    private func giveNewCredits() {
        credits += 100
        checkForCredits()
    }

    private func spinReels() {
        if credits >= 10 {
            credits -= 10
            isSpinning = true
            isTextHidden = true

            for index in 0..<3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                    for count in 0..<20 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(count) * 0.1) {
                            numbers[index] = Int.random(in: 0...9)
                        }
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        numbers[index] = Int.random(in: 0...9)

                        if index == 2 {
                            isSpinning = false
                            checkResult()
                        }
                    }
                }
            }
        } else {
            message = "Pas assez de crédits !"
            isTextHidden = false
        }
    }

    private func checkForCredits() {
        isButtonHidden = credits > 0
    }

    private func checkResult() {
        isTextHidden = false
        if numbers[0] == numbers[1] && numbers[1] == numbers[2] {
            credits += 100
            message = "Jackpot ! +100 crédits"
        } else {
            message = "Essayez encore !"
        }
        checkForCredits()
    }
}

#Preview {
    JackpotMachine()
}
