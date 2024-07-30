//
//  BookListView.swift
//  MyBooks
//
//  Created by Dilpreet Singh on 12/07/24.
//

import SwiftUI
import SwiftData

enum SortOrder: String, Identifiable, CaseIterable {
    case status, title, author
    var id: Self {
        self
    }
}

struct BookListView: View {
    @State private var createNewBook = false
    @State private var sortOrder = SortOrder.status
    var body: some View {
        NavigationStack{
            Picker("Sort by", selection: $sortOrder){
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)            
            BookList(sortOrder: sortOrder)
                .navigationTitle("My Books")
                .toolbar{
                    Button{
                        createNewBook = true
                    }label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                .sheet(isPresented: $createNewBook) {
                    NewBookView()
                        .presentationDetents([.medium])
                }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExample(Book.sampleBooks)
    return BookListView() // not just a single line in #preview{...}
        .modelContainer(preview.container)
}
