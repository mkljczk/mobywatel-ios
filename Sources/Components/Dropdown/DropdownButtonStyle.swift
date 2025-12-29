import SwiftUI

public struct DropdownButtonStyle: ButtonStyle {
  let label: String
  @Environment(\.isValid) private var isValid
  @Environment(\.isEnabled) private var isEnabled
  @Environment(\.appTheme) private var appTheme

  public init(label: String) {
    self.label = label 
  }

  public func makeBody(configuration: Configuration) -> some View {
    VStack(alignment: .leading, spacing: .spacing50) {
      Text(label)
        .font(.footnote)
        .foregroundStyle(isEnabled ? Color.neutral200 : Color.neutral60)

      HStack {
        configuration.label

        Spacer()

        Icons.Outline.Navigation.chevronDown
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(size: Constants.iconSize)
          .foregroundStyle(isEnabled ? Color.neutral200 : Color.neutral60)
      }
      .contentShape(.rect)
      .padding(.spacing200)
      .background(
        ZStack {
          RoundedRectangle(cornerRadius: appTheme.cornerRadius.border)
            .fill(Color.white)

          RoundedRectangle(cornerRadius: appTheme.cornerRadius.border)
            .stroke(borderColor, lineWidth: Constants.borderWidth)
        }
      )
    }
  }
} 

private extension DropdownButtonStyle {
  var borderColor: Color {
    guard isValid else { return .red100 }
    return isEnabled ? .neutral80 : .neutral30
  }
}

extension ButtonStyle where Self == DropdownButtonStyle {
  public static func dropdown(_ label: String) -> Self { .init(label: label) }
}

private enum Constants {
  static let borderWidth = 1.0
  static let iconSize = 24.0
}
