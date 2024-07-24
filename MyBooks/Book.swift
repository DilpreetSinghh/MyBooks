//
//  Book.swift
//  MyBooks
//
//  Created by Dilpreet Singh on 12/07/24.
//

import SwiftUI
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var summary: String
    var rating: Int?
    var status: Status
    
    // Initializer for the Book class with default values for some parameters
    init(
        title: String,
        author: String,
        dateAdded: Date = Date.now, // Defaults to the current date and time
        dateStarted: Date = Date.distantPast, // Defaults to a distant past date
        dateCompleted: Date = Date.distantPast, // Defaults to a distant past date
        summary: String = "", // Defaults to an empty string
        rating: Int? = nil, // Defaults to nil, meaning no rating
        status: Status = .onShelf // Defaults to .onShelf status
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
    }
    
    // Computed property that returns an appropriate icon based on the book's status
    var icon: Image {
        switch status {
            case .onShelf:
                Image(systemName: "checkmark.diamond.fill")
            case .inProgress:
                Image(systemName: "book.fill")
            case .completed:
                Image(systemName: "books.vertical.fill")
        }
    }
}

/// Represents the status of a book with constraints
///
/// Use of Constraints:
///  - `Codable`: Allows the Status enum to be encoded and decoded easily, useful for saving/loading data from JSON or network.
///  - `Identifiable`: Conforms to the Identifiable protocol, which helps SwiftUI to uniquely identify each instance when rendering lists or other dynamic content. Making it easier to use with SwiftUI's List and ForEach.
///  - `CaseIterable`: Protocol provides a collection of all the enum cases, Helpful when you need to iterate through all possible values of the enum. Useful for displaying options in a picker or menu, or for testing purposes.
enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    
    /// 1.   `var id:`
    ///    -    This declares a property called `id`.
    ///
    /// 2.    `Self { self }`
    ///    -    `Self` refers to the type that conforms to the protocol. In this case, it refers to the `Status` enum
    ///    -   `self` is a keyword that refers to the current instance of the type. Here, it means the current value of the `Status` enum.
    var id: Self {
        self
    }
    
    var descr: String {
        switch self {
            case .onShelf:
                "On Shelf"
            case .inProgress:
                "In Progress"
            case .completed:
                "Completed"
        }
    }
}
