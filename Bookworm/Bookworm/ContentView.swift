//
//  ContentView.swift
//  Bookworm
//
//  Created by Cheng Liang(Louis) on 2022/10/7.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
        

    }
}

//struct Student {
//    var id: UUID
//    var name: String
//}

struct ContentView: View {
    @State private var rememberMe = false
    @AppStorage("notes") private var notes = ""
    
//    @FetchRequest(sortDescriptors:[]) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            List{
                ForEach(books) {
                    book in
                    NavigationLink{
                        Text(book.title ?? "Unknown")
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown")
                                .font(.headline)
                            Text(book.author ?? "Unknown")
                    
                        }
                    }
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus.circle")
                    }
                }
            }
        }.sheet(isPresented: $showingAddScreen) {
            AddBookView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
