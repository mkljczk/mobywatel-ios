import SwiftUI

public struct SmallDocumentCard<LeadingItem: View>: View {
  private let title: String
  private let backgroundImage: Image
  private let leadingItem: LeadingItem

  public init( 
    title: String,
    backgroundImage: Image,
    @ViewBuilder leadingItem: () -> LeadingItem
  ) {
    self.leadingItem = leadingItem()
    self.title = title 
    self.backgroundImage = backgroundImage 
  }

  public var body: some View {
    VStack(alignment: .leading) {
      leadingItem 
        .frame(size: Constants.spacing450, alignment: .leading)

      Spacer()

      Text(title)
        .font(.subheadline.weight(.semibold))
        .foregroundStyle(Color.white)
        .multilineTextAlignment(.leading)
        .lineLimit(Constants.lineLimit)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.spacing200)
    .aspectRatio(Constants.aspectRatio, contentMode: .fit)
    .background(backgroundImage.resizable().aspectRatio(contentMode: .fill))
    .clipShape(.rect(cornerRadius: .radius200))
    .shadow(.light600)
  }
} 

private enum Constants {
  static let aspectRatio = 1.0
  static let spacing450 = 36.0
  static let lineLimit = 3
}
