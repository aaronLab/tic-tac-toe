//
//  ContentView.swift
//  Tic Tac Toe
//
//  Created by Aaron Lee on 2020-12-25.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    @State private var isFirstUser: Bool = true
    @State private var picked: [String] = Array(repeating: "", count: 9)
    @State private var winnerExisting: Bool = false
    @State private var winner: Player = .none
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ForEach(0...2, id: \.self) { vIndex in
                VStack(alignment: .center, spacing: 16) {
                    
                    self.makeRow(in: 0...2)
                    self.makeRow(in: 3...5)
                    self.makeRow(in: 6...8)
                    
                } //: V
                .padding(16)
                .disabled(winnerExisting)
            }
            
            if winnerExisting {
                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                
                self.makeAlertView()
            }
        } //: Z
    }
    
    
}

// MARK: - VIEW METHODS

extension ContentView {
    
    /// GET CELL WIDTH
    private func getWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return (screenWidth - (16 * 4)) / 3
    }
    
    /// DISABLE TAPPED CELL
    private func isAvailableCell(at index: Int) -> Bool {
        return self.picked[index] == ""
    }
    
    /// ROW
    private func makeRow(in range: ClosedRange<Int>) -> some View {
        return HStack(alignment: .center, spacing: 16) {
            ForEach(range, id: \.self) { hIndex in
                
                Button(action: {
                    self.cellDidTapped(at: hIndex)
                    self.checkWin()
                }, label: {
                    Text(picked[hIndex])
                        .foregroundColor(self.picked[hIndex] == "" ? .black : .white)
                        .font(.system(size: 40, weight: .heavy, design: .default))
                        .frame(width: getWidth(), height: getWidth())
                        .background(self.picked[hIndex] == "" ? Color.white : Color.orange)
                        .cornerRadius(16)
                })
                .disabled(!self.isAvailableCell(at: hIndex))
                .rotation3DEffect(
                    .init(degrees: self.picked[hIndex] == "" ? 0 : 180),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: .center,
                    anchorZ: 0,
                    perspective: 1
                )
            }
        } //: H
    }
    
    /// ALERT VIEW
    private func makeAlertView() -> some View {
        return VStack {
            
            Spacer(minLength: 0)
            
            Text(winner != .none ? "YOU WIN!\n\nPlayer: \(winner.rawValue)" : "Draw!")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .bold, design: .default))
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 0)
            
            Divider()
            
            HStack {
                
                Button(action: {
                    self.replay()
                }) {
                    Text("Replay")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .padding(16)
                        .frame(width: UIScreen.main.bounds.width - 40)
                }

            }
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 3)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: -5, y: -5)
    }
    
}

// MARK: - GAME METHODS

extension ContentView {
    
    /// WHEN A CELL IS TAPPED
    private func cellDidTapped(at index: Int) {
        if isFirstUser {
            withAnimation() {
                self.picked[index] = Player.firstPlayer.rawValue
            }
        } else {
            withAnimation() {
                self.picked[index] = Player.secondPlayer.rawValue
            }
        }
        self.isFirstUser.toggle()
    }
    
    /// CHECK WINNER
    private func checkWin() {
        let rows = self.picked.chunked(into: 3)
        
        self.checkRows(with: rows)
        self.checkColumns(with: rows)
        self.checkDiag(with: rows)
        self.checkDraw()
    }
    
    /// CHECK ROWS
    private func checkRows(with rows: [[String]]) {
        for row in rows {
            if row.dropLast().allSatisfy({ $0 == row.last }) && !row.contains("") {
                self.winner = row[0] == Player.firstPlayer.rawValue ? .firstPlayer : .secondPlayer
                DispatchQueue.main.async {
                    withAnimation() {
                        self.winnerExisting = true
                    }
                }
            }
        }
    }
    
    /// CHECK COLUMNS
    private func checkColumns(with rows: [[String]]) {
        for rowIndex in 0..<rows.count {
            let column = rows.getColumn(column: rowIndex)
            
            if column.dropLast().allSatisfy({ $0 == column.last }) && !column.contains("") {
                self.winner = column[0] == Player.firstPlayer.rawValue ? .firstPlayer : .secondPlayer
                DispatchQueue.main.async {
                    withAnimation() {
                        self.winnerExisting = true
                    }
                }
            }
        }
    }
    
    /// CHECK DIAG
    private func checkDiag(with rows: [[String]]) {
        var firstDiag = [String]()
        var secondDiag = [String]()
        
        for rowIndex in 0..<rows.count {
            firstDiag.append(rows[rowIndex][rowIndex])
            secondDiag.append(rows[rowIndex].reversed()[rowIndex])
        }
        
        if firstDiag.dropLast().allSatisfy({ $0 == firstDiag.last }) && !firstDiag.contains("") {
            self.winner = firstDiag[0] == Player.firstPlayer.rawValue ? .firstPlayer : .secondPlayer
            DispatchQueue.main.async {
                withAnimation() {
                    self.winnerExisting = true
                }
            }
        }
        
        if secondDiag.dropLast().allSatisfy({ $0 == secondDiag.last }) && !secondDiag.contains("") {
            self.winner = secondDiag[0] == Player.firstPlayer.rawValue ? .firstPlayer : .secondPlayer
            DispatchQueue.main.async {
                withAnimation() {
                    self.winnerExisting = true
                }
            }
        }
    }
    
    /// CHECK DRAW
    private func checkDraw() {
        if !self.picked.contains("") {
            DispatchQueue.main.async {
                withAnimation() {
                    self.winnerExisting = true
                }
            }
        }
    }
    
    /// REPLAY GAME
    private func replay() {
        DispatchQueue.main.async {
            withAnimation() {
                self.isFirstUser = true
                self.winnerExisting = false
                self.picked = Array(repeating: "", count: 9)
                self.winner = .none
            }
        }
    }
    
}

extension ContentView {
    
    private enum Player: String {
        case firstPlayer = "X"
        case secondPlayer = "O"
        case none
    }
    
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

extension Array where Element : Collection {
    func getColumn(column : Element.Index) -> [ Element.Iterator.Element ] {
        return self.map { $0[ column ] }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
