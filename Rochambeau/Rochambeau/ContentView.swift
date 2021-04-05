//
//  ContentView.swift
//  Rochambeau
//
//  Created by Adrià Ros on 5/4/21.
//

import SwiftUI

enum GameOption: String {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

struct ContentView: View {
    
    private var options: [GameOption] = [.rock, .paper, .scissors]
        
    @State private var machine = 0
    @State private var player: GameOption = .rock
    
    @State private var isRockButtonDisabled = false
    @State private var isPaperButtonDisabled = false
    @State private var isScissorsButtonDisabled = false
    
    @State private var machineScore = 0 {
        didSet {
            if machineScore == 10 { toggleButtons() }
        }
    }
    
    @State private var playerScore = 0 {
        didSet {
            if playerScore == 10 { toggleButtons() }
        }
    }
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.yellow, .white, .white, .white, .yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                VStack {
                    Text("Rochambeau")
                        .font(.title)
                }
                .padding(40)
                
                Text("You choose: \(player.rawValue)")
                    .padding()
                Text("Machine chooses: \(options[machine].rawValue)")
                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 80, trailing: 0))
                
                VStack {
                    Button("Rock") {
                        onRockButton()
                    }
                    .padding(4)
                    .disabled(isRockButtonDisabled)
                    
                    Button("Paper") {
                        onPaperButton()
                    }
                    .padding(4)
                    .disabled(isPaperButtonDisabled)
                    
                    Button("Scissors") {
                        onScissorsButton()
                    }
                    .padding(4)
                    .disabled(isScissorsButtonDisabled)
                }
                
                Spacer()
            
                Button("Start Again") {
                    reset()
                }
                
                Spacer()
                
                HStack {
                    Text("Machine: \(machineScore)")
                        .padding()
                    Text("Player: \(playerScore)")
                }
            }
        }
    }
    
    private func onRockButton() {
        player = .rock
        machineTurn()
    }
    
    private func onPaperButton() {
        player = .paper
        machineTurn()
    }
    
    private func onScissorsButton() {
        player = .scissors
        machineTurn()
    }
    
    private func machineTurn() {
        machine = Int.random(in: 0...2)
        compare()
    }
    
    private func compare() {
        switch options[machine] {
        case .rock:
            if player == .scissors { machineScore += 1 }
            if player == .paper { playerScore += 1 }
        case .paper:
            print("AQUI 10")
            if player == .rock { machineScore += 1 }
            if player == .scissors { playerScore += 1 }
        case .scissors:
            print("AQUI 20")
            if player == .paper { machineScore += 1 }
            if player == .rock { playerScore += 1 }
        }
        print(machineScore)
        print(playerScore)
    }
    
    private func reset() {
        machine = 0
        player = .rock
        machineScore = 0
        playerScore = 0
        toggleButtons()
    }
    
    private func toggleButtons() {
        isRockButtonDisabled = !isRockButtonDisabled
        isPaperButtonDisabled = !isPaperButtonDisabled
        isScissorsButtonDisabled = !isScissorsButtonDisabled
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
