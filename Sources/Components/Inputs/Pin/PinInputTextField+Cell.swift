import SwiftUI

extension PinInputTextField {
  struct Cell: View {
    struct State: Identifiable {
      let id: UUID
      let strokeColor: Color
      let strokeWidth: CGFloat
      let cornerRadius: CGFloat
      let isBulletPresented: Bool
    }

    var state: State 

    var body: some View {
      RoundedRectangle(cornerRadius: self.state.cornerRadius)
        .stroke(
          self.state.strokeColor, 
          lineWidth: self.state.strokeWidth
        )
        .frame(
          width: Self.width, 
          height: Self.height
        )
        .background(
          Color.white.cornerRadius(self.state.cornerRadius)
        )
        .overlay {
          if self.state.isBulletPresented {
            Circle()
              .fill(Color.neutral500)
              .frame(size: 6)
          }
        }
    }
  }
} 

extension PinInputTextField.Cell.State {
  struct Configuration {
    let isValid: Bool
    let appTheme: AppTheme 
    let isBulletPresented: Bool
  }

  static func focused(with configuration: Configuration) -> Self {
    PinInputTextField.Cell.State(
      id: UUID(), 
      strokeColor: configuration.isValid
        ? configuration.appTheme.colors.primary900
        : .red100, 
      strokeWidth: Constants.selectedLineWidth, 
      cornerRadius: configuration.appTheme.cornerRadius.border, 
      isBulletPresented: configuration.isBulletPresented
    )
  }

  static func unfocused(with configuration: Configuration) -> Self {
    PinInputTextField.Cell.State(
      id: UUID(), 
      strokeColor: configuration.isValid ? .neutral80 : .red100, 
      strokeWidth: Constants.unselectedLineWidth, 
      cornerRadius: configuration.appTheme.cornerRadius.border, 
      isBulletPresented: configuration.isBulletPresented
    )
  }
}

extension PinInputTextField.Cell {
  static let width = 40.0
  static let height = 48.0
}

private enum Constants {
  static let unselectedLineWidth = 1.0
  static let selectedLineWidth = 2.0
}
