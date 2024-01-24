//
//  Create Matrix.swift
//  Sudoku
//
//  Created by İbrahim Türk on 31.12.2023.
//

import UIKit
struct createMatrix{
    func createRandNumber(randomCount: Int) -> [Int] {
        var randomArray: [Int] = []
        while randomArray.count < randomCount {
            let randomInt = Int.random(in: 1..<82)
            // Aynı sayıyı iki kere eklememek için kontrol yapalım
            if !randomArray.contains(randomInt) {
                randomArray.append(randomInt)
            }
        }
        return randomArray
    }
    
    func createMatrix() -> [[Int]]{
        let sizeMatrix = 9
        var matrix = [[Int]](repeating: [Int](repeating: 0, count: sizeMatrix), count: sizeMatrix)
        let firstRow = [1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled()
        for i in 0..<sizeMatrix {
            matrix[0][i] = firstRow[i]
        }

        func isValidMove(_ matrix: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
            for i in 0..<sizeMatrix {
                if matrix[row][i] == num || matrix[i][col] == num {
                    return false
                }
            }
            let startRow = row - row % 3
            let startCol = col - col % 3
            for i in 0..<3 {
                for j in 0..<3 {
                    if matrix[startRow + i][startCol + j] == num {
                        return false
                    }
                }
            }

            return true
        }

        func solveSudoku(_ matrix: inout [[Int]], _ row: Int, _ col: Int) -> Bool {
            if row == sizeMatrix - 1 && col == sizeMatrix {
                return true
            }

            if col == sizeMatrix {
                return solveSudoku(&matrix, row + 1, 0)
            }

            if matrix[row][col] == 0 {
                for num in 1...sizeMatrix {
                    if isValidMove(matrix, row, col, num) {
                        matrix[row][col] = num
                        if solveSudoku(&matrix, row, col + 1) {
                            return true
                        }
                        matrix[row][col] = 0
                    }
                }
                return false
            } else {
                return solveSudoku(&matrix, row, col + 1)
            }
        }

            solveSudoku(&matrix, 1, 0)  // Start from the second row

        // Print the Sudoku matrix
        for i in 0..<sizeMatrix {
            for j in 0..<sizeMatrix {
                print(matrix[i][j], terminator: " ")
            }
            print()
        }
        return matrix
    }
    func createAlert(vc: UIViewController){
        let alert = UIAlertController(title: "TEBRİKLER", message: "Oyunu Kazandınız", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        vc.present(alert, animated: true)
        

    }
}
