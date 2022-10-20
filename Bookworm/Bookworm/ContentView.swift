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
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    let df = DateFormatter()

    var body: some View {
        

        NavigationView {
            List{
                ForEach(books) {
                    book in
                    NavigationLink{
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown")
                                    .font(.system(size: 18))
                                    .foregroundColor(book.rating < 3 ? Color.red : Color.black)
                                Text(book.author ?? "Unknown")
                                    .font(.system(size: 10))
                                
                            }
                            
                            Spacer()
                            
                            Text(df.string(from: book.date ?? Date.now) )
                                .font(.system(size: 10))
                        }
                    }
                }
                .onDelete(perform: deleteBooks(at:))
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                
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
        .onAppear {
            df.dateFormat = "MMM d, yyyy"
        }
        
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
