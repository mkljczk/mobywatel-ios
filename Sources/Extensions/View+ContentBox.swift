import SwiftUI

extension View {
  @warn_unqualified_access
  public func contentBox(
    padding: CGFloat = .spacing200, 
    color: Color = .white, 
    minHeight: CGFloat = 76.0, 
    shadow: Shadow? = .light200
  ) -> some View {
    modifier(
      ContentBoxModifier(
        padding: padding, 
        color: color, 
        minHeight: minHeight, 
        shadow: shadow 
      )
    )
  }
}

private struct ContentBoxModifier: ViewModifier {
  let padding: CGFloat
  let color: Color
  let minHeight: CGFloat
  let shadow: Shadow?

  func body(content: Content) -> some View {
    content 
      .padding(padding) 
      .frame(maxWidth: .infinity, minHeight: minHeight)
      .background(color) 
      .cornerRadius(.radius200) 
      .apply(if: shadow != nil) {
        $0.shadow(shadow ?? .light200)
      }
  } 
} 
