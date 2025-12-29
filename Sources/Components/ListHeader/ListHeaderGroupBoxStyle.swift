import SwiftUI

public struct ListHeaderGroupBoxStyle: GroupBoxStyle {
  public func makeBody(configuration: Configuration) -> some View {
    VStack(alignment: .leading, spacing: .spacing100) {
      configuration.label
        .font(.title2.weight(.bold))
        .foregroundStyle(Color.neutral500)
        .accessibilityIdentifier(.title)

      configuration.content
        .font(.footnote)
        .foregroundStyle(Color.neutral200)
        .accessibilityIdentifier(.description)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .fixedSize(horizontal: false, vertical: true)
    .multilineTextAlignment(.leading)
    .textCase(nil)
  } 
} 

public extension GroupBoxStyle where Self == ListHeaderGroupBoxStyle {
  static var listHeader: Self { .init() }
}

private extension AccessibilityIdentifier {
  static let title: Self = .init("title")
  static let description: Self = .init("description")
}
