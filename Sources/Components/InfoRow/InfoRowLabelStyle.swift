import SwiftUI

extension Label where Title == GroupBox<Text, Text>, Icon: View {
  public init(
    title: String, 
    description: String, 
    @ViewBuilder icon: @escaping () -> Icon 
  ) {
    self.init(
      title: {
        GroupBox(title) {
          Text(description)
        }
      }, 
      icon: icon 
    )
  }
}

extension LabelStyle where Self == InfoRowLabelStyle {
  public static var infoRow: Self { .init() }
}

public struct InfoRowLabelStyle: LabelStyle {
  public func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: .top, spacing: .spacing100) {
      configuration.icon
        .frame(size: .spacing400)
        .aspectRatio(contentMode: .fit)

      configuration.title
        .groupBoxStyle(.singleCard.reversed)
    }
  } 
} 
