import SwiftUI

public extension View {
  func withTrailingButton(@ViewBuilder _ trailingButton: () -> some View) -> some View {
    modifier(
      WithTrailingButtonModifier(trailingButton: trailingButton)
    )
  }
}

private struct WithTrailingButtonModifier<TrailingButton: View>: ViewModifier {
  private let trailingButton: TrailingButton
  @Environment(\.isEnabled) var isEnabled

  init(@ViewBuilder trailingButton: () -> TrailingButton) {
    self.trailingButton = trailingButton()
  }

  func body(content: Content) -> some View {
    HStack(spacing: .spacing100) {
      content 
        .frame(maxWidth: .infinity, alignment: .leading)

      trailingButton 
        .apply(if: !isEnabled) { $0.opacity(Constants.disabledOpacity) }
    }
    .frame(
      maxWidth: .infinity, 
      minHeight: Constants.spacing550
    )
  }
} 

private enum Constants {
  static let spacing550 = CGFloat(44)
  static let disabledOpacity = CGFloat(0.3)
}
