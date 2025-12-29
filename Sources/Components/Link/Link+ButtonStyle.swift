import SwiftUI

public struct LinkButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled 
  @Environment(\.appTheme) private var appTheme 

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label 
      .underline(color: isEnabled ? appTheme.colors.primary900 : Color.neutral60)
      .font(.footnote.weight(.semibold)) 
      .multilineTextAlignment(.leading) 
      .fixedSize(horizontal: false, vertical: true)
      .foregroundStyle(isEnabled ? appTheme.colors.primary900 : Color.neutral60)
  }
} 

extension ButtonStyle where Self == LinkButtonStyle {
  public static var linkStyle: Self { .init() }
}
