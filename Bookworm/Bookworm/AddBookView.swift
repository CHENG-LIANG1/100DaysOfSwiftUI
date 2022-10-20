//
//  AddBookView.swift
//  Bookworm
//
//  Created by Cheng Liang(Louis) on 2022/10/19.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    @State private var showingAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "History", "Poetry",
    "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating, offColor: Color.gray.opacity(0.5))
                }header: {
                    Text("Write a review (Optional)")
                }
                
                Section {
                    Button("Save"){
                        if(title.isEmpty || author.isEmpty || genre.isEmpty){
                            showingAlert = true
                        }else {
                            let newBook = Book(context: moc)
                            newBook.id = UUID()
                            newBook.title = title
                            newBook.author = author
                            newBook.rating = Int16(rating)
                            newBook.genre = genre
                            newBook.review = review
                            newBook.date = Date.now
                            try? moc.save()
                            dismiss()
                        }
                        
                        

                        
                    }
                }
                .alert("Invalid book!", isPresented: $showingAlert) {
                    Button("Got it") {}
                } message: {
                    Text("Please fill all the fields.")
                }
            }
        }.navigationTitle("Add Book")
        
        
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
