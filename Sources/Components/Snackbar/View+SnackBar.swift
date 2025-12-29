import SwiftUI

public struct SnackBar: Hashable {
  let title: String
  let duration: TimeInterval?

  public init( 
    title: String,
    duration: TimeInterval? = nil 
  ) {
    self.title = title 
    self.duration = duration 
  }
} 

private struct SnackBarViewModifier: ViewModifier {
  let item: Binding<SnackBar?>

  func body(content: Content) -> some View {
    content 
      .overlay(alignment: .bottom) {
        SnackBarView(item: self.item)
    }
  } 
} 

extension View {
  @warn_unqualified_access
  public func snackBar(item: Binding<SnackBar?>) -> some View {
    modifier(SnackBarViewModifier(item: item))
  }
}
