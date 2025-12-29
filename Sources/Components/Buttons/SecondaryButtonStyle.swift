import SwiftUI

public struct SecondaryButtonStyle: ButtonStyle {
  let type: ButtonType
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.appTheme) private var appTheme

  public func makeBody(configuration: Configuration) -> some View {
    Group {
      switch type {
      case .large, .largeDestructive:
        configuration.label.baseStyle

      case .small, .smallDestructive:
        configuration.label.smallBaseStyle

      case .iconLarge, .iconLargeDestructive:
        configuration.label.iconBaseStyle

      case .iconSmall, .iconSmallDestructive:
        configuration.label.iconSmallBaseStyle
      }
    }
    .foregroundStyle(foregroundColor)
    .background(
      RoundedRectangle(cornerRadius: radius)
        .stroke(strokeColor, lineWidth: Constants.borderWidth)
    )
    .rippleEffect(configuration.isPressed)
  } 
} 

extension ButtonStyle where Self == SecondaryButtonStyle {
  public static func secondary(_ type: ButtonType) -> Self {
    .init(type: type)
  }
}

private enum Constants {
  static let borderWidth = 1.0
}

private extension SecondaryButtonStyle {
  var strokeColor: Color {
    guard isEnabled 
    else { return Color.neutral30 }

    switch type {
    case .large, .small, .iconLarge, .iconSmall:
      return appTheme.colors.primary900

    case .largeDestructive, .smallDestructive, .iconLargeDestructive, .iconSmallDestructive:
      return .red100
    }
  }

  var foregroundColor: Color {
    guard isEnabled 
    else { return Color.neutral60 }

    switch type {
    case .large, .small, .iconLarge, .iconSmall:
      return appTheme.colors.primary900

    case .largeDestructive, .smallDestructive, .iconLargeDestructive, .iconSmallDestructive:
      return Color.red100
    }
  }

  var radius: CGFloat {
    switch type {
    case .iconLarge, .iconLargeDestructive:
      return .radius300

    case .iconSmall, .iconSmallDestructive:
      return .radius200

    case .large, .largeDestructive, .small, .smallDestructive:
      return appTheme.cornerRadius.button
    }
  }
}
