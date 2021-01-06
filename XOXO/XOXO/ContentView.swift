//
//  ContentView.swift
//  XOXO
//
//  Created by mohamad on 1/5/21.
//

import SwiftUI

struct ContentView: View {
    @State var fields : [[Field]] = .init(repeating: .init(repeating: Field(player : "" , enabled: true ) , count:3 ), count: 3)
    @State var playerTurn : String = "X"
    @State var winner = ""
    @State var winStatus = false
    @State var drawCounter = 0
    func chckWinner(){
        let r0 = fields[0][0].player == playerTurn &&  fields[0][1].player == playerTurn && fields[0][2].player == playerTurn
        let r1 = fields[1][0].player == playerTurn &&  fields[1][1].player == playerTurn && fields[1][2].player == playerTurn
        let r2 = fields[2][0].player == playerTurn &&  fields[2][1].player == playerTurn && fields[2][2].player == playerTurn
        let c0 = fields[0][0].player == playerTurn &&  fields[1][0].player == playerTurn && fields[2][0].player == playerTurn
        let c1 = fields[0][1].player == playerTurn &&  fields[1][1].player == playerTurn && fields[2][1].player == playerTurn
        let c2 = fields[0][2].player == playerTurn &&  fields[1][2].player == playerTurn && fields[2][2].player == playerTurn
        let d1 = fields[0][0].player == playerTurn &&  fields[1][1].player == playerTurn && fields[2][2].player == playerTurn
        let d2 = fields[0][2].player == playerTurn &&  fields[1][1].player == playerTurn && fields[2][0].player == playerTurn
        if r0 || r1 || r2 || c0 || c1 || c2 || d1 || d2 {
            winner = ("\(playerTurn) win")
            winStatus = true
        }
        else if drawCounter == 9 {
            winner = "Draw"
            winStatus = true
        }
    }
    func restartG() {
        fields = .init(repeating: .init(repeating: Field(player : "" , enabled: true ) , count:3 ), count: 3)
        playerTurn = "X"
        winner = ""
        winStatus = false
        drawCounter = 0
    }
    var body: some View {
        ZStack{
            Color.gray
                .ignoresSafeArea()
            VStack(spacing : 10){
                Text("\(winner) ")
                ForEach(0 ..< 3) { r in
                    HStack(spacing : 10){
                        ForEach(0 ..< 3) { c in
                            Button(action: {
                                if fields[r][c].enabled{
                                    fields[r][c].player = playerTurn
                                    drawCounter += 1
                                    chckWinner()
                                    if winStatus == false {
                                        playerTurn = playerTurn == "X" ? "O" : "X"
                                        fields[r][c].enabled = false
                                    }
                                    else {
                                        for i in 0..<2 {
                                            for j in 0..<2 {
                                                fields[i][j].enabled = false
                                            }
                                        }
                                    }
                                }
                            }, label: {
                                Text(fields[r][c].player)
                                    .font(.system(size: 60))
                                    .foregroundColor(Color.black)
                                    .frame(width: 90 , height: 90 , alignment : .center)
                                    .background(Color.white)
                            })
                        }
                        
                    }
                }
                if winner != "" {
                    Button(action: {
                        restartG()
                    }, label: {
                        Text("Restart")
                            .padding()
                    })
                }
            }
            
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
