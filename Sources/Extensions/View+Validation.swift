import SwiftUI

private enum IsValidKey: EnvironmentKey {
  static var defaultValue = true 
}

extension EnvironmentValues {
  public var isValid: Bool {
    get { self[IsValidKey.self] }
    set { self[IsValidKey.self] = newValue }
  }
}

private struct ValidationModifier: ViewModifier {
  let validationMessage: String?
  let alignment: Alignment
  let padding: CGFloat
  @Environment(\.accessibilityVoiceOverEnabled) private var isVoiceOverEnabled: Bool

  func body(content: Content) -> some View {
    VStack(spacing: padding) {
      content 
        .environment(\.isValid, validationMessage == nil)

      if let validationMessage {
        Label(
          title: { Text(validationMessage) }, 
          icon: {
            Icons.Dedicated.errorMarkSmall
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(size: .smallIcon)
          }
        )
        .labelStyle(.error)
        .frame(maxWidth: .infinity, alignment: alignment)
        .accessibilityIdentifier(.errorLabel)
        .fixedSize(horizontal: false, vertical: true)
      }
    }
    .apply(if: isVoiceOverEnabled) {
      $0
        .accessibilityElement(children: .contain)
        .accessibilityLabel(validationMessage ?? "")
    }
  } 
} 

extension View {
  @warn_unqualified_access
  public func validation(
    _ validationMessage: String?, 
    alignment: Alignment = .leading, 
    padding: CGFloat = .spacing50
  ) -> some View {
    self.modifier(
      ValidationModifier(
        validationMessage: validationMessage, 
        alignment: alignment, 
        padding: padding 
      )
    )
  }
}

extension LabelStyle where Self == ErrorLabelStyle {
  static var error: Self { .init() }
}

private struct ErrorLabelStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: .spacing50) {
      configuration.icon
        .frame(size: .smallIcon)

      configuration.title
        .font(.caption)
        .multilineTextAlignment(.leading)
    }
    .foregroundStyle(Color.red100)
  } 
} 

private extension AccessibilityIdentifier {
  static let errorLabel: Self = .init("errorLabel")
}
