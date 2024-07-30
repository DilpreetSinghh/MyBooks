# Sorting
Adding sorting feature in the application with `title`, `author` and `status`

# Adding Sorting as per `Status`

@TabNavigator {
    @Tab("Status"){
        ```swift
        
        @Query(sort: \Book.status) private var books: [Book]
        
        ```
    }
    @Tab("Title"){
        ```swift
        
        @Query(sort: \Book.title) private var books: [Book]
        
        ```
    }
    @Tab("Author"){
        ```swift
        
        @Query(sort: \Book.author) private var books: [Book]
        
        ```
    }
}

Just change from `title` to `author`, there will no issue arise, but in case of sorting as per `status` we can't say the same.

> Error:
> Macro `Query(filter:sort:order:transaction:)` requires that `Status` conform to `Comparable`.
> Do you mean to use `.rawValue`?


Solution seems from here is simple. Use `.rawValue` at in `@Query`.

```swift

@Query(sort: \Book.status.rawValue) private var books: [Book]

```
> Now our preview is crashing due to the following reasons:
> - We are utilizing an `enum` as a property. 
>- While SwiftData correctly stores the raw value,
  the `@Query` annotation does not effectively handle sorting and filtering based on `rawValue`.
>- This issue underlines the limitations of `@Query` in managing enum properties in SwiftData.


**Resolution for the Preview Crash:**

1. **Model Update in `Book.swift`:**
   Modifications were made to the `Book.swift` model to handle the enum issue. See image: ![Changes in Book.swift](03.2-Book.jpg)

2. **Picker Issue in `EditBookView.swift`:**
   The `picker` in `EditBookView.swift` was still utilizing the `Status` enum directly. To fix this, updates now use the raw value of the status (`status.rawValue`). See image: ![Changes in EditBookView.swift](03.1-EditBookView.jpg)

3. **Compile and Run:**
   After making these changes, the app compiles without errors.

4. **In Case of Crashes:**
   If the app crashes, delete it from the simulator or device and run it again.

>Data Loss:
>All data might be lost after these operations. This issue will be addressed in a future "Migration" section to ensure data persistence.

---
## Giving User to choose sorting option

In case of sorting by preference we can use `Picker` with tags of `Title`, `Author`, and `Status`. 

```swift
Picker("Sort by", selection: $sortOrder){
    ForEach(SortOrder.allCases) { sortOrder in
        Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
    }
}
 ```
> Error: 
>Here is a problem, `Picker` and `@Query` unable to update list as per sorting option selected. 

**Reason**:
- Our Query Macro is sorting by a fixed keypath and we want this to be dynamic based on the selection. 
- If sortOrder updates don’t trigger a recomputation or re-sorting of the books array, the UI will not reflect the selected sorting order.
- The linkage between the Picker selection and the views that display the data (i.e., the List) might be missing or not reactive enough.

**Solution**:
- In order to make keypath dynamic, We have to do some steps:
- Move `Query` and its listing to its own separate view, so we can reinitialise the `Query` every time selection is made.
- We create a new swiftUI view named as `BookList.swift`.
- Move the `Group{...}` along `context` and `books`  in `BookList.swift` file.

    ```swift
    @Environment(\.modelContext) private var context
    @Query(sort: \Book.status) private var books: [Book]
    ```
- and addition of `init(){...}` in `BookList.swift`
    ```swift
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
    ```
