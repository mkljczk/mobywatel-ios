import A11y
import SwiftUI

public struct Accordion<Content>: View where Content: View {
  let title: String
  let isExpanded: Binding<Bool>
  let content: Content

  public init( 
    _ title: String,
    isExpanded: Binding<Bool>, 
    @ViewBuilder content: () -> Content
  ) {
    self.title = title 
    self.content = content()
    self.isExpanded = isExpanded 
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: .spacing200) {
      Button { isExpanded.wrappedValue.toggle() } label: {
        HStack(spacing: .spacing100) {
          Text(title)
            .foregroundStyle(Color.neutral500)
            .font(.headline.weight(.semibold))
            .multilineTextAlignment(.leading)

          Spacer()

          Icons.Outline.Navigation.chevronDown
            .resizable()
            .frame(size: Constants.iconSize)
            .foregroundColor(.neutral200)
            .rotationEffect(
              .degrees(
                isExpanded.wrappedValue ? Constants.rotationDegrees : .zero
              )
            )
            .animation(.easeInOut, value: isExpanded.wrappedValue)
        }
      }
      .accessibilityIdentifier(.toggleExpandedButton)
      .accessibilityLabel(
        Text(
          title 
          + ", "
          + (
            isExpanded.wrappedValue
              ? A11y.commonAccessibilityExpanded
              : A11y.commonAccessibilityNotExpanded
          )
        )
      )

      if isExpanded.wrappedValue {
        VStack(spacing: .spacing200) {
          content 
        }
      }
    }
    .fixedSize(horizontal: false, vertical: true)
  }
} 

private enum Constants {
  static let iconSize = 24.0
  static let rotationDegrees = 180.0
}

private extension AccessibilityIdentifier {
  static let toggleExpandedButton: Self = .init("toggleExpandedButton")
}
