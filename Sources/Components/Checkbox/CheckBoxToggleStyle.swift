import SwiftUI

extension ToggleStyle where Self == CheckBoxToggleStyle {
  public static func checkBox(_ alignment: VerticalAlignment = .center) -> Self {
    .init(alignment: alignment)
  }
}

public struct CheckBoxToggleStyle: ToggleStyle {
  private let alignment: VerticalAlignment
  @Environment(\.isValid) private var isValid
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.appTheme) private var appTheme

  public init(alignment: VerticalAlignment = .center) {
    self.alignment = alignment 
  }

  public func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: alignment, spacing: .spacing200) {
      Group {
        if configuration.isOn {
          selectedContent 
        } else {
          unselectedContent 
        }
      }
      .frame(size: .spacing250)
      .padding(.spacing25)
      .shadow(.light200)

      configuration.label
        .foregroundStyle(Color.neutral500)
        .frame(minHeight: .spacing300)

      Spacer(minLength: .zero)
    }
    .frame(maxWidth: .infinity)
    .contentShape(.rect)
    .onTapGesture { configuration.isOn.toggle() }
  }
} 

private extension CheckBoxToggleStyle {
  var selectedContent: some View {
    Icons.Dedicated.checkboxMark
      .resizable()
      .frame(size: Constants.iconSize)
      .aspectRatio(contentMode: .fit)
      .foregroundStyle(Color.white)
      .padding(.spacing50)
      .background(selectedBackgroundColor)
      .cornerRadius(.radius50)
  }

  var unselectedContent: some View {
    RoundedRectangle(cornerRadius: .radius50)
      .strokeBorder(borderColor, lineWidth: Constants.strokeWidth)
  }

  var selectedBackgroundColor: Color {
    guard isValid else { return .red100 }
    return isEnabled ? appTheme.colors.primary900 : .neutral30
  }

  var borderColor: Color {
    guard isValid else { return .red100 }
    return isEnabled ? .neutral80 : .neutral30
  }
}

private enum Constants {
  static let strokeWidth = 2.0
  static let iconSize = 12.0
}
