import SwiftUI

public struct SmallCard: View {
  private let foregroundColor: Color
  private let image: Image
  private let title: String

  public init( 
    foregroundColor: Color,
    image: Image,
    title: String
  ) {
    self.foregroundColor = foregroundColor 
    self.image = image 
    self.title = title 
  }

  public var body: some View {
    VStack(spacing: .spacing100) {
      ZStack {
        iconBackground 
        icon 
      }

      text 
    }
  }
} 

private extension SmallCard {
  var iconBackground: some View {
    Constants.smallCardBackground
      .resizable()
      .frame(size: Constants.iconBackgroundSize)
      .shadow(.light200)
  }

  var icon: some View {
    image 
      .resizable()
      .renderingMode(.template)
      .foregroundStyle(foregroundColor)
      .aspectRatio(contentMode: .fit)
      .frame(size: Constants.iconSize)
  }

  var text: some View {
    Text(title)
      .font(.caption)
      .foregroundStyle(Color.neutral200)
      .lineLimit(Constants.lineLimit)
      .multilineTextAlignment(.center)
      .frame(
        maxWidth: Constants.textMaxWidth, 
        maxHeight: .infinity, 
        alignment: .top
      )
  }
}

private enum Constants {
  static let lineLimit = 2
  static let textMaxWidth = 92.0
  static let iconBackgroundSize = 80.0
  static let iconSize = 32.0
  static let smallCardBackground = Image("smallCardBackground", bundle: .module)
}
