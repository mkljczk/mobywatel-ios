import SwiftUI

public struct TrailingLabelStyle: LabelStyle {
  @Environment(\.isEnabled) private var isEnabled 

  public func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: .spacing200) {
      configuration.title
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)

      configuration.icon
        .apply(if: !isEnabled) { $0.opacity(Constants.disabledOpacity) }
    }
    .frame(
      maxWidth: .infinity, 
      minHeight: Constants.spacing550
    )
  } 
} 

public extension LabelStyle where Self == TrailingLabelStyle {
  static var trailing: Self { .init() }
}

private enum Constants {
  static let spacing550 = 44.0
  static let disabledOpacity = 0.3
}
