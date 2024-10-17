import Foundation

struct TicTacToeModel {
    var board: [[String]]
    var currentPlayer: String
    var gameOver: Bool
    var winner: String?

    init() {
        board = [["", "", ""], ["", "", ""], ["", "", ""]]
        currentPlayer = "X"
        gameOver = false
        winner = nil
    }

    mutating func makeMove(row: Int, col: Int) {
        guard board[row][col].isEmpty else { return }
        board[row][col] = currentPlayer
        checkForWinner()
        currentPlayer = currentPlayer == "X" ? "O" : "X"
    }

    mutating func checkForWinner() {
        let winningCombination: [[(Int, Int)]] = [
            [(0, 0), (0, 1), (0, 2)],
            [(1, 0), (1, 1), (1, 2)],
            [(2, 0), (2, 1), (2, 2)],
            [(0, 0), (1, 0), (2, 0)],
            [(0, 1), (1, 1), (2, 1)],
            [(0, 2), (1, 2), (2, 2)],
            [(0, 0), (1, 1), (2, 2)],
            [(0, 2), (1, 1), (2, 0)]
        ]

        for combination in winningCombination {
            let first = board[combination[0].0][combination[0].1]
            if !first.isEmpty && first == board[combination[1].0][combination[1].1] && first == board[combination[2].0][combination[2].1] {
                winner = first
                gameOver = true
                return
            }
        }

        if board.flatMap({ $0 }).allSatisfy({ !$0.isEmpty }) {
            gameOver = true
        }
    }

    mutating func resetGame() {
        board = [["", "", ""], ["", "", ""], ["", "", ""]]
        currentPlayer = "X"
        gameOver = false
        winner = nil
    }
}
