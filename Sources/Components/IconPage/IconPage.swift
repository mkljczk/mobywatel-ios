import SwiftUI

public struct IconPage<Icon, Content>: View
where Icon: View, Content: View {
  private let icon: Icon 
  private let title: String
  private let description: String?
  private let subDescription: String?
  private let content: Content 

  public init(
    title: String, 
    description: String? = nil, 
    subDescription: String? = nil, 
    @ViewBuilder icon: @escaping () -> Icon, 
    @ViewBuilder content: @escaping () -> Content = EmptyView.init
  ) {
    self.title = title 
    self.description = description 
    self.subDescription = subDescription 
    self.icon = icon()
    self.content = content()
  }

  public var body: some View {
    VStack(spacing: .spacing200) {
      Spacer()

      icon 
        .accessibilityHidden(true)

      Group {
        Text(title)
          .font(.title2.bold())
          .foregroundStyle(Color.neutral500)
          .fixedSize(horizontal: false, vertical: true)
          .frame(maxWidth: .infinity)

        if let description {
          Text(description)
            .fixedSize(horizontal: false, vertical: true)
        }
        if let subDescription {
          Text(subDescription)
            .fixedSize(horizontal: false, vertical: true)
        }
      }
      .foregroundStyle(Color.neutral200)
      .multilineTextAlignment(.center)

      content 

      Spacer()
    }
    .padding(.horizontal, .spacing200)
  }
}
