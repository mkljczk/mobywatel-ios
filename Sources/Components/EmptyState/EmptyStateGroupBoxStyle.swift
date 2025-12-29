import SwiftUI

public struct EmptyStateGroupBoxStyle: GroupBoxStyle {
  public func makeBody(configuration: Configuration) -> some View {
    VStack(spacing: .spacing200) {
      configuration.label
        .foregroundStyle(Color.neutral500)
        .font(.headline.weight(.semibold))
        .accessibilityIdentifier(.title)

      configuration.content
        .foregroundStyle(Color.neutral200)
        .font(.footnote)
        .buttonStyle(.text)
    }
    .multilineTextAlignment(.center)
    .frame(maxWidth: .infinity)
  } 
} 

public extension GroupBoxStyle where Self == EmptyStateGroupBoxStyle {
  static var emptyState: Self { .init() }
}

private extension AccessibilityIdentifier {
  static let title: Self = .init("title")
}
