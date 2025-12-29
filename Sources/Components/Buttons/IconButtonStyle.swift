import SwiftUI

public struct IconButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled 
  @Environment(\.appTheme) private var appTheme 

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label 
      .frame(size: .spacing300)
      .frame(alignment: .center)
      .contentShape(.rect(cornerRadius: .radius200))
      .foregroundStyle(isEnabled ? appTheme.colors.primary900 : Color.neutral60)
      .rippleEffect(configuration.isPressed) 
  }
} 

public struct DestructiveIconButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled 

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label 
      .frame(size: .spacing300)
      .frame(alignment: .center)
      .contentShape(.rect(cornerRadius: .radius200))
      .foregroundStyle(isEnabled ? Color.red100 : Color.neutral60)
      .rippleEffect(configuration.isPressed) 
  }
} 

extension ButtonStyle where Self == IconButtonStyle {
  public static var icon: Self { .init() }
}

extension ButtonStyle where Self == DestructiveIconButtonStyle {
  public static var destructiveIcon: Self { .init() }
}
