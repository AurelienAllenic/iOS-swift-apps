import SwiftUI

struct TicTacToeView: View {
    @State private var model = TicTacToeModel()

    var body: some View {
        ZStack {
            Image("tictactoe")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Text("Tic Tac Toe")
                    .font(.largeTitle.weight(.bold))
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(25)

                ForEach(0..<3) { row in
                    HStack {
                        ForEach(0..<3) { col in
                            Button(action: {
                                self.model.makeMove(row: row, col: col)
                            }) {
                                Text(self.model.board[row][col])
                                    .font(.system(size: 64))
                                    .foregroundColor(self.model.board[row][col] == "X" ? .red : .green)
                                    .frame(width: 100, height: 100)
                                    .background(Color.black.opacity(0.7))
                                    .cornerRadius(10)
                            }
                            .disabled(model.gameOver || !model.board[row][col].isEmpty)
                        }
                    }
                }

                if model.gameOver {
                    Text(model.winner != nil ? "\(model.winner!) a gagné!" : "Match nul!")
                        .font(.title)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(15)

                    Button("Recommencer") {
                        model.resetGame()
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.title2.weight(.semibold))
                }
            }
            .padding()
        }
    }
}

#Preview {
    TicTacToeView()
}
