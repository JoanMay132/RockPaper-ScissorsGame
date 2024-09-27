//
//  ContentView.swift
//  RockPaper&ScissorsGame
//
//  Created by Joan May on 25/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var weapon : [String] = ["👊🏻","🧻","✄"]
    @State private var randomMove: Int = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var showingResults = false
    @State private var score = 0
    @State private var questionCount = 0
    @State private var gameMessage = ""
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [.init(color: Color(red: 0.612, green: 0.710, blue: 0.690), location: 0.4)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Computer has played...")
                    .font(.headline)
                
                VStack {
                    Text(weapon[randomMove])
                        .font(.system(size: 200))
                    
                    if shouldWin {
                        Text("Which one wins?")
                            .foregroundStyle(.green)
                            .font(.title)
                    }else {
                        Text("Which one loses?")
                            .foregroundStyle(.red)
                            .font(.title)
                    }
                    //
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Button(weapon[number]){
                                //handle move tap
                                playGame(choice: number)
                            }
                            .font(.system(size: 80))
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("Score: \(score)")
                    .font(.title.weight(.bold))
                    
                Spacer()
                
            }
            .padding(20)
     
           
           
            .alert("Game Over", isPresented: $showingResults){
                Button("Play again", action: resetGame)
            } message: {
                Text(gameMessage)
            }
            
        }
        
    }
    func playGame(choice: Int) {
        let winningMoves = [1,2,0]
        let didWin : Bool
        
        if choice == randomMove {
           
            showingResults = true
            gameMessage = "It is a tieee"
        }
        else if shouldWin {
            didWin = choice == winningMoves[randomMove]
            score += didWin ? 1 : 0
            gameMessage = "Your score was \(score)"
            
        }else {
            didWin = winningMoves[choice] == randomMove
            score += didWin ? 1 : -1
            gameMessage = "Your score was \(score)"
        }
        
        
        if questionCount == 2 {
            showingResults = true
        }else {
            
            randomMove = Int.random(in: 0..<3)
            shouldWin.toggle()
            questionCount += 1
        }
        
        
    }
    
    func resetGame(){
        randomMove = Int.random(in: 0..<3)
        score = 0
        shouldWin = Bool.random()
        questionCount = 0
        gameMessage = ""
    }
}

#Preview {
    ContentView()
}
