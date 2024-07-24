# Working of RatingView
It's a file in project, responsible for changing the rating with tapGesture


## Behind the Scene
1.    State Management:
    •    @Binding var currentRating: Int?: This binding allows RatingsView to modify the currentRating state in its parent view. When a star is tapped, currentRating is updated.
    2.    Gesture Handling:
    •    The .onTapGesture modifier is attached to each star image. When a star is tapped, the closure inside .onTapGesture is executed, updating the currentRating.
    3.    Conditional Rendering with ViewModifier:
    •    The fillImage(_:) view modifier is used to apply the filled variant of the SF Symbol based on the current rating.
    •    correctImage(for:) method checks if the current star’s rating is less than the currentRating. If it is, it returns true, indicating that the star should be filled.

## Example Workflow

1.    Initial Render: The view is rendered with all stars in an unfilled state initially.
2.    User Taps a Star: When a user taps a star, the onTapGesture updates the currentRating to the index of the tapped star plus one.
3.    State Update Triggers Re-render: Updating the currentRating triggers a re-render of the RatingsView.
4.    Conditional Rendering:  During the re-render, the correctImage(for:) method is called for each star. The stars with indices less than currentRating are rendered with the filled variant.

## Example Scenario

If a user taps the third star:

- `currentRating` is updated to 4 (because the star indices start from 1 and the array index is 0-based).
- The view re-renders, calling `correctImage(for:)` for each star.
- The first three stars (indices 1, 2, and 3) return true for `correctImage(for:)` and are rendered with the filled variant.
- The remaining stars are rendered unfilled.

---
This mechanism ensures that the correct number of stars are filled based on the user’s interaction, providing immediate visual feedback for the rating.
