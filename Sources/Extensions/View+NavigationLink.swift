import SwiftUI

struct NavigationLinkModifier: ViewModifier {
  func body(content: Content) -> some View {
    HStack(spacing: .spacing200) {
      content 

      Spacer(minLength: .zero)

      Image(systemName: "chevron.right")
        .font(.footnote.bold())
        .foregroundStyle(Color(uiColor: .tertiaryLabel))
    }
    .contentShape(.rect)
  } 
} 

public extension View {
  func navigationLinkStyle() -> some View {
    modifier(NavigationLinkModifier())
  }
}
