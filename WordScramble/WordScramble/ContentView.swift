//
//  ContentView.swift
//  WordScramble
//
//  Created by Cheng Liang(Louis) on 2022/8/13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = "Dick"
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    

    var body: some View {
        
        NavigationView{
            List {
                Section{
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self){
                        word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                                .renderingMode(.original)
                            Text(word)
                        }
                        
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .toolbar {
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(EdgeInsets.init(top:8 , leading: 20, bottom: 8, trailing: 20))
                    .background(.red)
                    .clipShape(Capsule())
                
                Button("Refresh", action: startGame)
                    .font(.headline)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(EdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 10))
                    .background(.indigo)
                    .clipShape(Capsule())
                    .scaleEffect()
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {
                    
                }
            } message: {
                Text(errorMessage)
            }
            
        }

        
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 2 else {return}
        
        guard isOriginal(word: answer) else {
            wordEror(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordEror(title: "Word not possible", message: "You can't spell that word from \(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordEror(title: "Word not recognized", message: "You can't make up words!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            score += 1
        }
        
        newWord = ""
        
    }
    
    func startGame(){
        print("starting ")
        usedWords = []
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            print("loaded ")
            if let startWords = try?  String(contentsOf: startWordsUrl){
                let allWords = startWords.components(separatedBy: "\n")
                print(allWords.count)
                rootWord = allWords.randomElement()!
                print(rootWord)
                return
            }
                
        }
        
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String ) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en"
        )
        
        return misspelledRange.location == NSNotFound
    }
    
    
    func wordEror(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

 
