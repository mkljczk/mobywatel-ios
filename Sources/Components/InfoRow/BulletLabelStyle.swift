import SwiftUI

extension LabelStyle where Self == BulletLabelStyle {
  public static var bullet: Self { .init() }
}

public struct BulletLabelStyle: LabelStyle {
  public func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: .top, spacing: .spacing100) {
      Icons.Outline.Symbols.bullet
        .resizable()
        .frame(size: .spacing300)
        .aspectRatio(contentMode: .fit)
        .accessibilityHidden(true)

      configuration.title
        .frame(maxWidth: .infinity, minHeight: .spacing300, alignment: .leading)
        .multilineTextAlignment(.leading)
        .fixedSize(horizontal: false, vertical: true)
    }
    .foregroundStyle(Color.neutral200)
  } 
} 
