import SwiftUI

public struct TextButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled 
  @Environment(\.appTheme) private var appTheme 

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label 
      .font(.footnote.weight(.semibold)) 
      .frame(alignment: .center)
      .frame(minHeight: Constants.minHeight)
      .contentShape(.rect) 
      .foregroundStyle(isEnabled ? appTheme.colors.primary900 : Color.neutral60)
      .rippleEffect(configuration.isPressed) 
  }
} 

public struct DestructiveTextButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled 

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label 
      .font(.footnote.weight(.semibold)) 
      .frame(alignment: .center)
      .frame(minHeight: Constants.minHeight)
      .contentShape(.rect) 
      .foregroundStyle(isEnabled ? Color.red100 : Color.neutral60)
      .rippleEffect(configuration.isPressed) 
  }
} 

extension ButtonStyle where Self == TextButtonStyle {
  public static var text: Self { .init() }
}

extension ButtonStyle where Self == DestructiveTextButtonStyle {
  public static var destructiveText: Self { .init() }
}

private enum Constants {
  static let minHeight = 18.0
}
