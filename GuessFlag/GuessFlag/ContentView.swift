//
//  ContentView.swift
//  GuessFlag
//
//  Created by 梁程 on 2022/7/12.
//

import SwiftUI


struct FlagImage: View {
    var path: String
        
    var body: some View {
        Image(path)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            
    }
}

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var playCount = 0
    
    @State private var showingResult = false
    
    @State private var msg = ""
    
    @State private var flipAnimation = 0
    
    @State private var opacity = 1.0
    
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        } label: {
                            
                            
                            FlagImage(path:countries[number])
                            
                                .rotation3DEffect(.degrees( number == correctAnswer ? Double(flipAnimation) : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(number == correctAnswer ?  1 : opacity)
                                
            
                        }
                        
                    }
                    
                    HStack{
                        Text("Score: \(score)")
                            .foregroundColor(.white)
                            .font(.title.bold())
                        
                        Text("Rounds: \(playCount)")
                            .foregroundColor(.white)
                            .font(.title.bold())
                    }
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
            
            
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(msg)
        }
        
        .alert("Final Score: \(score)", isPresented: $showingResult){
            Button("Restart", action: resetGame)
        }message: {
            Text("\(score)")
        }
        
    }
    
    func flagTapped(_ number: Int){
        
        if(number == correctAnswer){
            scoreTitle = "Correct"
            score += 1
            msg = "Your score is \(score)"
            withAnimation(.default) {
                flipAnimation += 360
                opacity = 0.25
            }

        }else{
            scoreTitle = "Wrong"
            msg = "This is \(countries[number])"
        }
        

        
        showingScore = true

        
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacity = 1
        
        if(playCount < 8){
            playCount += 1
        }else{
            showingResult = true
        }
    }
    
    func resetGame(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        playCount = 0
        opacity = 1
    }

    
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
