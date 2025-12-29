import SwiftUI

public struct HeaderView<Content: View>: View {
  private let icon: Image
  private let iconColor: Color?
  private let iconBackgroundColor: Color
  private let title: String
  private let description: String?
  private let useDefaultBackground: Bool
  private let content: Content

  public init( 
    icon: Image,
    iconColor: Color? = nil, 
    iconBackgroundColor: Color,
    title: String,
    description: String? = nil, 
    useDefaultBackground: Bool = true, 
    @ViewBuilder content: () -> Content
  ) {
    self.icon = icon 
    self.iconColor = iconColor 
    self.iconBackgroundColor = iconBackgroundColor 
    self.title = title 
    self.description = description 
    self.useDefaultBackground = useDefaultBackground 
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: .spacing200) {
      ZStack {
        Circle()
          .fill(iconBackgroundColor)
          .frame(size: Constants.iconBackgroundSize)

        icon 
          .resizable()
          .apply(ifLet: iconColor) { $0.foregroundStyle($1) }
          .aspectRatio(contentMode: .fit)
          .frame(size: Constants.iconSize)
      }
      .accessibilityHidden(true)
      .frame(maxWidth: .infinity, alignment: .leading)

      VStack(alignment: .leading, spacing: .spacing100) {
        Text(title)
          .font(.largeTitle.weight(.bold))
          .foregroundStyle(Color.neutral500)
          .multilineTextAlignment(.leading)
          .fixedSize(horizontal: false, vertical: true)
          .accessibilityIdentifier(.headerViewTitle)
          .frame(maxWidth: .infinity, alignment: .leading)

        if let description {
          Text(description)
            .font(.body)
            .foregroundStyle(Color.neutral200)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .accessibilityIdentifier(.headerViewSubtitle)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
      }

      content 
        .padding(.top, .spacing100)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .apply(if: self.useDefaultBackground) { content in
      content.background(Color.background.ignoresSafeArea())
    }
  }
} 

private extension AccessibilityIdentifier {
  static let headerViewTitle: Self = .init("headerViewTitle")
  static let headerViewSubtitle: Self = .init("headerViewSubtitle")
}

private enum Constants {
  static let iconBackgroundSize = 72.0
  static let iconSize = 40.0
}
