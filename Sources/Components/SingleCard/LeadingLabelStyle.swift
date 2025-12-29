import SwiftUI

public struct LeadingLabelStyle: LabelStyle {
  public enum LeadingStyle {
    case icon 
    case image 
    case placeholder 
    case clickable 
    case destructive 
    case custom 
  }

  private var style: LeadingStyle 
  @Environment(\.isEnabled) private var isEnabled 
  @Environment(\.appTheme) private var appTheme 

  public init(style: LeadingStyle) {
    self.style = style 
  }

  public func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: .center, spacing: .spacing200) {
      configuration.icon
        .apply(if: iconSize != nil) { $0.frame(size: iconSize ?? .regularIcon) }
        .apply(if: iconForegroundColor != nil) { $0.foregroundStyle(iconForegroundColor ?? .neutral200) }
        .apply(if: !isEnabled) { $0.opacity(Constants.disabledOpacity) }
        .apply(if: style == .placeholder) {
          $0
            .padding(Constants.spacing125)
            .background(Color.background)
        }
        .apply(if: style == .placeholder || style == .image) {
          $0.clipShape(.rect(cornerRadius: .radius150))
        }

      configuration.title
        .foregroundStyle(foregroundColor(isEnabled))
        .font(.headline.weight(.semibold))
        .frame(minHeight: .spacing300)
        .accessibilityElement(children: .combine)
    }
    .multilineTextAlignment(.leading)
    .frame(
      maxWidth: .infinity, 
      minHeight: Constants.spacing550, 
      alignment: .leading
    )
  }
} 

public extension LabelStyle where Self == LeadingLabelStyle {
  static func leading(_ style: LeadingLabelStyle.LeadingStyle) -> Self {
    .init(style: style)
  }
}

private extension LeadingLabelStyle {
  var iconSize: CGFloat? {
    switch self.style {
    case
        .icon, 
        .placeholder, 
        .destructive, 
        .clickable:
      return .regularIcon

    case .image:
      return Constants.spacing550

    case .custom:
      return nil
    }
  }

  var iconForegroundColor: Color? {
    switch self.style {
    case .clickable:
      return appTheme.colors.primary900

    case .destructive:
      return Color.red100

    case .custom:
      return nil

    case
        .icon, 
        .placeholder, 
        .image:
      return Color.neutral200
    }
  }

  func foregroundColor(_ isEnabled: Bool) -> Color {
    guard isEnabled 
    else { return Color.neutral60 }

    switch self.style {
    case .clickable:
      return appTheme.colors.primary900

    case .destructive:
      return Color.red100

    case
        .icon, 
        .placeholder, 
        .image, 
        .custom:
      return Color.neutral500
    }
  }
}

private enum Constants {
  static let spacing550 = 44.0
  static let spacing125 = 10.0
  static let disabledOpacity = 0.3
}
