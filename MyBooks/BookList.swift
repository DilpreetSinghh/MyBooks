//
//  BookList.swift
//  MyBooks
//
//  Created by Dilpreet Singh on 29/07/24.
//

import SwiftUI
import SwiftData

struct BookList: View {
    
    /// Access to the data model context, necessary for performing data operations
    @Environment(\.modelContext) private var context
    
    /// Dynamic fetching of books based on sorting descriptors applied to the query
    @Query(sort: \Book.status) private var books: [Book]
    
    /// The initializer accepts a SortOrder enumeration value to determine the sorting behavior of the books array.
    ///
    /// - Sort descriptors are configured accordingly.
    /// - `let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {...}`, Sorts logic based on the sortOrder input
    init(sortOrder: SortOrder){
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
            case .status:
                [SortDescriptor(\Book.status), SortDescriptor(\Book.title)]
            case .title:
                [SortDescriptor(\Book.title)]
            case .author:
                [SortDescriptor(\Book.author)]
        }
        _books = Query(sort: sortDescriptors)
    }
    var body: some View {
        Group {
            if books.isEmpty {
                ContentUnavailableView("Enter Your First Book", systemImage: "book.fill")
            } else {
                List{
                    ForEach(books) {book in
                        NavigationLink(destination: EditBookView(book: book)) {
                            //Label
                            HStack(spacing: 10){
                                book.icon
                                VStack(alignment: .leading) {
                                    Text(book.title).font(.title2)
                                    Text(book.author).foregroundStyle(.secondary)
                                    if let rating = book.rating {
                                        HStack{
                                            ForEach(1..<rating, id: \.self){
                                                _ in
                                                Image(systemName: "star.fill")
                                                    .imageScale(.small)
                                                    .foregroundStyle(.yellow)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let book = books[index]
                            context.delete(book)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExample(Book.sampleBooks)
    return NavigationStack {
        BookList(sortOrder: .status)
    }
        .modelContainer(preview.container)
    
}
