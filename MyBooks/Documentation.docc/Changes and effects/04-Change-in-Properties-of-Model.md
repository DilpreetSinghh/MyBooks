# Change in Properties of Model
Adding and Renaming properties along with learning more light migrations

## Overview
We will try different methods to add and rename properties in model after sucessfully creating a project using light migration, including learning other light migrations.

## Case 1
> Work Done:
If we are adding a new property with optional value and default value as `nil`, After compliling project you will see no error and in database there will be new property with `NULL` value assigned to it.

```swift
import SwiftUI
import SwiftData

@Model
class Book {
    // ........
    var recommendedBy: String?

    init(
        // ........
        recommendedBy: String? = nil //Defaults to nil
    ) {
        // ........
        self.recommendedBy = recommendedBy
    }
}
```
---
## Case 2
> Work Done:
We removed optional properties and instead of keeping `recommendedBy` as `nil` we changed it to empty string `""`.

```swift
import SwiftUI
import SwiftData

@Model
class Book {
    // ........
    var recommendedBy: String

    init(
        // ........
        recommendedBy: String = "" // Defaults to empty string
    ) {
        // ........
        self.recommendedBy = recommendedBy
    }
}
```
But in this case database crashed

The error you're encountering is related to a failed attempt to migrate the data in your persistent store (database) to a new schema version. This is happening in the context of Core Data, which is used for data management in iOS and macOS applications.

### Error Explanation:
- **Error Domain=NSCocoaErrorDomain Code=134110**: Indicates an issue with persistent store migration.
- **Validation error missing attribute values on mandatory destination attribute**: This part of the error message reveals that the new schema version of your database expects a value for the `recommendedBy` attribute in the `Book` entity, but during migration, not all existing records in the database were provided with a value for this newly added attribute.

### Key Points from the Error:
- The migration is trying to be performed "in-place," which means it is attempting to update the existing store directly.
- The `recommendedBy` attribute, which has likely been marked as mandatory (non-optional), does not have values for some or all of the existing records, which leads to a validation failure during migration.

### Solutions:
1. **Review Attribute Optionality**: If the `recommendedBy` attribute is not essential for all existing records, consider setting it as optional in your data model. This change would prevent the migration from failing due to missing values.

2. **Provide Default Values**: During the migration, provide a default value for the `recommendedBy` attribute. You can do this by setting a default value in the data model or by using a custom migration policy that sets this value for existing records.

3. **Custom Migration Policy**: Implement a custom migration policy class where you can define how data is transformed from the old schema to the new schema. This class can include logic to handle missing values for the `recommendedBy` attribute.

4. **Incremental Migrations**: Ensure your migration steps are incremental and handle one change at a time, making sure each step provides a fallback or default for newly required fields.

By addressing these areas, you should be able to resolve the migration error and ensure that your application's data model updates smoothly without causing crashes or data loss.

## Case 2: Fixing Error


```swift
import SwiftUI
import SwiftData

@Model
class Book {
    // ........
    var recommendedBy: String = "" // Change here
    // ........
}
```
---

## LightWeight Migrations in SwiftData

- **Add new models**
- **Add new properties**
  - Must be optional or have default value
  - `@Attribute(originalname: "summary")`
  - `var avatar: Data`
- **Delete properties**
- `@Attribute(externalStorage)`
  - `var avatar: Data`
- `@Attribute(allowsCloudEncryption)`
  - `var sin: String`
- `@Attribute(unique)`
  - `var title: String`
- `@Relationship(deleteRule: .cascade)`
  - `var quotes: [Quote]?`


