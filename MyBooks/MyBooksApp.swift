//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Dilpreet Singh on 12/07/24.
//

import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
            
            
        }
        .modelContainer(for: Book.self)
    }
    
    init(){
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
