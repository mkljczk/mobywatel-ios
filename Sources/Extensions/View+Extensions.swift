import SwiftUI

extension View {
  @warn_unqualified_access
  public func frame(
    size: CGFloat, 
    alignment: Alignment = .center
  ) -> some View {
    frame(
      width: size, 
      height: size, 
      alignment: alignment 
    )
  }

  @warn_unqualified_access
  @ViewBuilder
  public func apply<Content: View>(
    if condition: Bool, 
    transformation: (Self) -> Content 
  ) -> some View {
    if condition {
      transformation(self)
    } else {
      self
    }
  }

  @warn_unqualified_access
  @ViewBuilder
  public func apply<Value, Content: View>(
    ifLet value: Value?, 
    transformation: (Self, Value) -> Content 
  ) -> some View {
    if let value {
      transformation(self, value)
    } else {
      self
    }
  }

  @warn_unqualified_access
  @ViewBuilder
  public func accessibilityLabel(
    _ label: String, 
    validationMessage: String?
  ) -> some View {
    self.apply(ifLet: validationMessage) {
      $0.accessibilityLabel($1 + ", " + label)
    }
  }
}
