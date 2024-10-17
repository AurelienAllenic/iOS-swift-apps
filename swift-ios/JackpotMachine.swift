import SwiftUI

struct JackpotMachine: View {
    @StateObject private var viewModel = JackpotMachineViewModel()

    var body: some View {
        ZStack {
            Image("jackpot")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            VStack {
                Text("Jackpot Machine")
                    .font(.largeTitle.weight(.semibold))
                    .padding()
                    .foregroundColor(.white)

                Text("Credits: \(viewModel.credits)")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)

                HStack {
                    ForEach(0..<3, id: \.self) { index in
                        Text("\(viewModel.numbers[index])")
                            .font(.system(size: 60))
                            .padding()
                            .frame(width: 80, height: 100)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .offset(y: viewModel.isSpinning ? 20 : 0)
                            .animation(
                                viewModel.isSpinning ? Animation.linear(duration: 0.1)
                                    .repeatCount(20, autoreverses: true) : .default,
                                value: viewModel.isSpinning
                            )
                    }
                }
                .padding()

                if !viewModel.isTextHidden {
                    Text(viewModel.message)
                        .font(.title.weight(.semibold))
                        .padding()
                        .foregroundColor(.white)
                }

                Button(action: {
                    viewModel.spinReels()
                }) {
                    Text("Test your luck !")
                        .font(.title)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(viewModel.isSpinning)

                if !viewModel.isButtonHidden {
                    Button(action: {
                        viewModel.giveNewCredits()
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
            .background(Color.black.opacity(0.4))
            .cornerRadius(20)
            .padding()
        }
    }
}

#Preview {
    JackpotMachine()
}
