import SwiftUI

public struct SectionHeaderStyle: GroupBoxStyle {
  public func makeBody(configuration: Configuration) -> some View {
    VStack(alignment: .leading, spacing: .spacing200) {
      configuration.label
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline.weight(.semibold))
        .foregroundStyle(Color.neutral500)
        .accessibilityIdentifier(.title)

      configuration.content
    }
  } 
} 

public extension GroupBoxStyle where Self == SectionHeaderStyle {
  static var sectionHeader: Self {
    SectionHeaderStyle()
  }
}

private extension AccessibilityIdentifier {
  static let title: Self = .init("title")
}
