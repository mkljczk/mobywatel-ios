import SwiftUI

public struct NavigationLinkButtonStyle: ButtonStyle {
  public func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: .spacing200) {
      configuration.label
        .accessibilityElement(children: .combine)

      Spacer(minLength: .zero)

      Image(systemName: "chevron.right")
        .font(.footnote.bold())
        .foregroundStyle(Color(uiColor: .tertiaryLabel))
        .accessibilityHidden(true)
    }
    .contentShape(.rect)
  } 
} 

extension ButtonStyle where Self == NavigationLinkButtonStyle {
  public static var navigationLink: Self { .init() }
}
