import SwiftUI

extension Binding where Value: Equatable {
  public func removeDuplicates() -> Self {
    .init(
      get: { wrappedValue }, 
      set: { newValue, transaction in
        guard newValue != wrappedValue else { return }
        self.transaction(transaction).wrappedValue = newValue 
      }
    )
  }
}

extension Binding where Value == String {
  static var empty: Self { .constant("") }
}
