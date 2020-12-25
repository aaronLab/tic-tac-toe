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
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ForEach(0...2, id: \.self) { vIndex in
                VStack(alignment: .center, spacing: 16) {
                    
                    HStack(alignment: .center, spacing: 16) {
                        ForEach(0...2, id: \.self) { hIndex in
                            
                            Button(action: {
                                self.cellDidTapped(at: hIndex)
                            }, label: {
                                Text(picked[hIndex])
                                    .foregroundColor(.black)
                                    .frame(width: getWidth(), height: getWidth())
                                    .background(Color.white)
                                    .cornerRadius(16)
                            })
                            .disabled(!self.isAvailableCell(at: hIndex))
                        }
                    } //: H
                    
                    HStack(alignment: .center, spacing: 16) {
                        ForEach(3...5, id: \.self) { hIndex in
                            
                            Button(action: {
                                self.cellDidTapped(at: hIndex)
                            }, label: {
                                Text(picked[hIndex])
                                    .foregroundColor(.black)
                                    .frame(width: getWidth(), height: getWidth())
                                    .background(Color.white)
                                    .cornerRadius(16)
                            })
                            .disabled(!self.isAvailableCell(at: hIndex))
                        }
                    } //: H
                    
                    HStack(alignment: .center, spacing: 16) {
                        ForEach(6...8, id: \.self) { hIndex in
                            
                            Button(action: {
                                self.cellDidTapped(at: hIndex)
                            }, label: {
                                Text(picked[hIndex])
                                    .foregroundColor(.black)
                                    .frame(width: getWidth(), height: getWidth())
                                    .background(Color.white)
                                    .cornerRadius(16)
                            })
                            .disabled(!self.isAvailableCell(at: hIndex))
                        }
                    } //: H
                } //: V
                .padding(16)
            }
        } //: Z
    }
    
    
}

// MARK: - METHODS

extension ContentView {
    
    private func getWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return (screenWidth - (16 * 4)) / 3
    }
    
    private func isAvailableCell(at index: Int) -> Bool {
        return self.picked[index] == ""
    }
    
    private func cellDidTapped(at index: Int) {
        if isFirstUser {
            self.picked[index] = Player.firstPlayer.rawValue
        } else {
            self.picked[index] = Player.secondPlayer.rawValue
        }
        self.isFirstUser.toggle()
    }
    
}

extension ContentView {
    
    private enum Player: String {
        case firstPlayer = "O"
        case secondPlayer = "X"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
