import SwiftUI

public struct DocumentCard<TrailingItem: View>: View {
  private let title: String
  private let backgroundImage: Image
  private let trailingItem: TrailingItem

  public init( 
    title: String,
    backgroundImage: Image,
    @ViewBuilder trailingItem: () -> TrailingItem
  ) {
    self.trailingItem = trailingItem()
    self.title = title 
    self.backgroundImage = backgroundImage 
  }

  public var body: some View {
    VStack {
      HStack(alignment: .center, spacing: .spacing100) {
        Text(title)
          .font(.headline.weight(.semibold))
          .foregroundStyle(Color.white)
          .multilineTextAlignment(.leading)
          .lineLimit(Constants.lineLimit)
          .frame(maxWidth: .infinity, minHeight: Constants.spacing550, alignment: .leading)

        trailingItem 
          .frame(size: Constants.spacing550)
      }

      Spacer()
    }
    .padding(.top, .spacing100)
    .padding([.bottom, .horizontal], .spacing200)
    .frame(height: Constants.cardHeight)
    .background(backgroundImage.resizable().aspectRatio(contentMode: .fill))
    .clipShape(.rect(cornerRadius: .radius200))
    .shadow(.light600)
  }
} 

private enum Constants {
  static let cardHeight = 226.0
  static let spacing550 = 44.0
  static let lineLimit = 2
}
