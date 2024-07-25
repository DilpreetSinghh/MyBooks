# Saving Data in Document folder

We were using `MyBooksApp.swift` file in order to change the location of storing data


### Setting up
- First we create a `ModelContainer` in `struct MyBooksApp {...}` in `var container`.
- Added configurations using `ModelConfiguration()` in `let config`.
- Add details of `ModelContainer` in `container` enclosed in `init()`.
- As `container` might throw some error, so use `do` `catch` for easy debugging.

@TabNavigator{
    @Tab("After"){
        ```swift
        import SwiftUI
        import SwiftData

        @main
        struct MyBooksApp: App {
            let container: ModelContainer
            var body: some Scene {
                WindowGroup {
                    BookListView()   
                }
                .modelContainer(container)
            }
            
            init(){
                let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
                do {
                    container = try ModelContainer(for: Book.self, configurations: config)
                } catch {
                    fatalError("Could not configure the container")
                }
                print(URL.documentsDirectory.path())
            }
        }
        ```
    }
    @Tab("Before"){
        ```swift
        import SwiftUI
        import SwiftData

        @main
        struct MyBooksApp: App {
            let container: ModelContainer
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
        ```
    }
}


