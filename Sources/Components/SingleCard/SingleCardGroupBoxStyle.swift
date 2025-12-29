import SwiftUI

public struct SingleCardGroupBoxStyle: GroupBoxStyle {
  fileprivate var isReversed = false 
  @Environment(\.isEnabled) private var isEnabled 

  public func makeBody(configuration: Configuration) -> some View {
    VStack(alignment: .leading, spacing: .spacing50) {
      configuration.label
        .foregroundStyle(labelForegroundColor)
        .font(isReversed ? .body.weight(.semibold) : .footnote)
        .accessibilityIdentifier(.title)

      configuration.content
        .foregroundStyle(contentForegroundColor)
        .font(isReversed ? .footnote : .body.weight(.semibold))
        .accessibilityIdentifier(.description)
    }
    .fixedSize(horizontal: false, vertical: true)
    .multilineTextAlignment(.leading)
    .frame(
      maxWidth: .infinity, 
      minHeight: Constants.spacing550, 
      alignment: .leading
    )
    .accessibilityElement(children: .combine)
    .accessibilityRemoveTraits(.isHeader)
  } 
} 

public extension GroupBoxStyle where Self == SingleCardGroupBoxStyle {
  static var singleCard: Self { .init() }
}

private extension SingleCardGroupBoxStyle {
  var labelForegroundColor: Color {
    guard isEnabled 
    else { return Color.neutral60 }
    return isReversed ? Color.neutral500 : Color.neutral200
  }

  var contentForegroundColor: Color {
    guard isEnabled 
    else { return Color.neutral60 }
    return isReversed ? Color.neutral200 : Color.neutral500
  }
}

public extension SingleCardGroupBoxStyle {
  var reversed: Self {
    var mutable = self
    mutable.isReversed = true
    return mutable 
  }
}

private extension AccessibilityIdentifier {
  static let title: Self = .init("title")
  static let description: Self = .init("description")
}

private enum Constants {
  static let spacing550 = 44.0
}
