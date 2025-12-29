import SwiftUI

public struct IllustrationPage<Illustration, Content>: View
where Illustration: View, Content: View {
  private let title: String
  private let description: String?
  private let illustration: Illustration 
  private let content: Content 

  public init(
    title: String, 
    description: String? = nil, 
    @ViewBuilder illustration: @escaping () -> Illustration, 
    @ViewBuilder content: @escaping () -> Content = EmptyView.init
  ) {
    self.title = title 
    self.description = description 
    self.illustration = illustration()
    self.content = content()
  }

  public var body: some View {
    VStack(spacing: .spacing200) {
      illustration 
        .frame(maxWidth: .infinity)
        .accessibilityHidden(true)

      Group {
        Text(title)
          .font(.title2.bold())
          .foregroundStyle(Color.neutral500)
          .fixedSize(horizontal: false, vertical: true)

        if let description {
          Text(description)
            .foregroundStyle(Color.neutral200)
            .fixedSize(horizontal: false, vertical: true)
        }
      }
      .multilineTextAlignment(.center)

      content 
    }
    .padding(.horizontal, .spacing200)
    .frame(maxHeight: .infinity, alignment: .top)
  }
}

private enum Constants {
  static let illustrationHeightProportion = 0.3
}
