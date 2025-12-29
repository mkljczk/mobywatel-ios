import SwiftUI

extension View {
  @warn_unqualified_access
  func rippleEffect(_ isPressed: Bool) -> some View {
    self
      .opacity(isPressed ? Constants.pressedOpacity : Constants.fullOpacity)
  }
}

private enum Constants {
  static let pressedOpacity = 0.5
  static let fullOpacity = 1.0
}
