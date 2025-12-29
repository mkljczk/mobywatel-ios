import SwiftUI

extension Label where Title == Text, Icon == EmptyView {
  public init(title: String) {
    self.init(
      title: { Text(title) }, 
      icon: EmptyView.init
    )
  }
}

extension Label {
  public init(
    @ViewBuilder content: @escaping () -> Title, 
    @ViewBuilder item: @escaping () -> Icon 
  ) {
    self.init(
      title: content, 
      icon: item 
    )
  }
}
