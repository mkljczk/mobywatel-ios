import SwiftUI

public struct RadioButton<Label: View, Content: View>: View {
  private let label: Label
  private let content: Content
  @Binding private var isOn: Bool
  @Environment(\.isValid) private var isValid

  public init( 
    @ViewBuilder label: () -> Label,
    @ViewBuilder content: () -> Content = EmptyView.init,
    isOn: Binding<Bool>
  ) {
    self.label = label()
    self.content = content()
    _isOn = isOn 
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: .spacing100) {
      Toggle(isOn: $isOn) { label }
        .toggleStyle(.radio)

      if isOn {
        content 
          .padding(.leading, .spacing500)
          .animation(.easeInOut, value: isOn)
      }
    }
  }
} 

extension RadioButton where Label == Text {
  public init(
    label: String, 
    @ViewBuilder content: () -> Content = EmptyView.init, 
    isOn: Binding<Bool>
  ) {
    self.label = Text(label)
    self.content = content()
    _isOn = isOn 
  }
}
