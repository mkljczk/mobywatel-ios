import SwiftUI

public struct ShortcutCard: View {
  private let foregroundColor: Color
  private let image: Image
  private let title: String

  public init( 
    _ title: String,
    image: Image,
    foregroundColor: Color
  ) {
    self.foregroundColor = foregroundColor 
    self.image = image 
    self.title = title 
  }

  public var body: some View {
    VStack(spacing: .spacing100) {
      ZStack {
        Circle()
          .fill(.white)
          .frame(size: Constants.backgroundSize)
          .shadow(.light200)

        image 
          .resizable()
          .scaledToFit()
          .frame(size: .regularIcon)
          .foregroundStyle(foregroundColor)
      }

      Text(title)
        .font(.caption)
        .foregroundStyle(Color.neutral500)
        .multilineTextAlignment(.center)
    }
    .frame(width: Constants.maxWidth)
  }
} 

private enum Constants {
  static let maxWidth = 80.0
  static let backgroundSize = 48.0
}
