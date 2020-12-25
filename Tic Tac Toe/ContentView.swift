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
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ForEach(1...3, id: \.self) { vIndex in
                VStack(alignment: .center, spacing: 16) {
                    
                    HStack(alignment: .center, spacing: 16) {
                        ForEach(1...3, id: \.self) { hIndex in
                            
                            Button(action: {
                                
                            }, label: {
                                Text("")
                                    .foregroundColor(.black)
                                    .frame(width: getWidth(), height: getWidth())
                                    .background(Color.white)
                                    .cornerRadius(16)
                            })
                        }
                    } //: H
                    
                    HStack(alignment: .center, spacing: 16) {
                        ForEach(4...6, id: \.self) { hIndex in
                            
                            Button(action: {
                                
                            }, label: {
                                Text("")
                                    .foregroundColor(.black)
                                    .frame(width: getWidth(), height: getWidth())
                                    .background(Color.white)
                                    .cornerRadius(16)
                            })
                        }
                    } //: H
                    
                    HStack(alignment: .center, spacing: 16) {
                        ForEach(7...9, id: \.self) { hIndex in
                            
                            Button(action: {
                                
                            }, label: {
                                Text("")
                                    .foregroundColor(.black)
                                    .frame(width: getWidth(), height: getWidth())
                                    .background(Color.white)
                                    .cornerRadius(16)
                            })
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
    func getWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return (screenWidth - (16 * 4)) / 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
