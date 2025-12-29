import SwiftUI

public struct PinInputTextField: View {
  private let numberOfCells: Int
  @Environment(\.appTheme) var appTheme
  @Environment(\.isValid) private var isValid
  @Binding private var value: String
  @FocusState private var isFocused: Bool

  public init( 
    value: Binding<String>, 
    numberOfCells: Int = 4
  ) {
    self._value = value 
    self.numberOfCells = numberOfCells 
  }

  public var body: some View {
    SecureField(
      "", 
      text: Binding(
        get: { self.value }, 
        set: { self.value = String($0.prefix(self.numberOfCells)) }
      ).removeDuplicates()
    )
    .focused(self.$isFocused)
    .textFieldStyle(
      PinInputTextFieldStyle(
        cells: (0..<self.numberOfCells).map {
          self.stateForCell(at: $0)
        }, 
        isFocused: self.$isFocused 
      )
    )
  }

  private func stateForCell(at index: Int) -> Cell.State {
    let configuration = Cell.State.Configuration(
      isValid: self.isValid, 
      appTheme: self.appTheme, 
      isBulletPresented: index < self.value.count
    )
    return index == self.value.count && self.isFocused
      ? .focused(with: configuration)
      : .unfocused(with: configuration)
  }
} 
