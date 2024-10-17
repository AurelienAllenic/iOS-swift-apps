import SwiftUI

class JackpotMachineViewModel: ObservableObject {
    @Published var numbers = [0, 0, 0]
    @Published var message = ""
    @Published var credits = 100
    @Published var isSpinning = false
    @Published var isTextHidden = true
    @Published var isButtonHidden = true

    func spinReels() {
        if credits >= 10 {
            credits -= 10
            isSpinning = true
            isTextHidden = true

            for index in 0..<3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                    for count in 0..<20 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(count) * 0.1) {
                            self.numbers[index] = Int.random(in: 0...9)
                        }
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.numbers[index] = Int.random(in: 0...9)

                        if index == 2 {
                            self.isSpinning = false
                            self.checkResult()
                        }
                    }
                }
            }
        } else {
            message = "Pas assez de crédits !"
            isTextHidden = false
        }
    }

    func giveNewCredits() {
        credits += 100
        checkForCredits()
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
