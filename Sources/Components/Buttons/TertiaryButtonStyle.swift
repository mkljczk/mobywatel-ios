import SwiftUI

public struct TertiaryButtonStyle: ButtonStyle {
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
    .rippleEffect(configuration.isPressed)
  } 
} 

extension ButtonStyle where Self == TertiaryButtonStyle {
  public static func tertiary(_ type: ButtonType) -> Self {
    .init(type: type)
  }
}

private extension TertiaryButtonStyle {
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
}
