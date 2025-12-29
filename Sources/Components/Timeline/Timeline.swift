import SwiftUI

public struct Timeline: View {
  private let items: [Item]

  public init(items: [Item]) {
    self.items = items 
  }

  public var body: some View {
    LazyVStack(alignment: .leading, spacing: .zero) {
      ForEach(items.zipped, id: \.0) { _, item in
        HStack(alignment: .center, spacing: .spacing200) {
          Circle()
            .foregroundStyle(Color.neutral200)
            .frame(size: .spacing100)

          Text(item.header)
            .font(.footnote)
            .foregroundStyle(Color.neutral200)
        }

        HStack(alignment: .center, spacing: .spacing200) {
          if item != items.last {
            HStack(alignment: .center, spacing: .zero) {
              Rectangle()
                .foregroundStyle(Color.neutral80)
                .frame(width: Constants.lineWidth)
            }
            .frame(width: .spacing100)
          }

          VStack(alignment: .leading, spacing: .zero) {
            Text(item.title)
              .multilineTextAlignment(.leading)
              .foregroundColor(.neutral500)
              .font(.headline.weight(.semibold))
              .padding(.vertical, .spacing25)

            ForEach(item.descriptions.zipped, id: \.0) { _, description in
              Text(description)
                .multilineTextAlignment(.leading)
                .foregroundColor(.neutral200)
                .lineSpacing(.spacing25)
                .font(.footnote)
            }
          }
          .padding(.bottom, .spacing250)
          .padding(.leading, item == items.last ? .spacing300 : .zero)
        }
      }
    }
  }
} 

private extension Array where Element: Equatable {
  var zipped: [(Int, Element)] {
    let zipped = zip(self.indices, self)
    return .init(zipped)
  }
}

private enum Constants {
  static let lineWidth = 1.0
}
