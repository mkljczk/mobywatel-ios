import A11y
import SwiftUI

public struct InlineAlert<TrailingItem, BottomItem>: View
where TrailingItem: View, BottomItem: View {
  public enum Style {
    case success
    case error
    case warning
    case info
    case announcement(icon: Image, color: Color, backgroundColor: Color)
  }

  private let style: Style 
  private var title: String?
  private let description: String
  private let trailingItem: TrailingItem 
  private let bottomItem: BottomItem 
  @Environment(\.accessibilityVoiceOverEnabled) private var isVoiceOverEnabled 

  public init(
    style: Style, 
    title: String? = nil, 
    description: String, 
    @ViewBuilder trailingItem: () -> TrailingItem = EmptyView.init, 
    @ViewBuilder bottomItem: () -> BottomItem = EmptyView.init
  ) {
    self.style = style 
    self.title = title 
    self.description = description 
    self.trailingItem = trailingItem()
    self.bottomItem = bottomItem()
  }

  public var body: some View {
    HStack(alignment: .top, spacing: .spacing100) {
      style.icon
        .padding(.trailing, .spacing100)
        .apply(if: isVoiceOverEnabled) { icon in
          if let accessibilityLabel = style.accessibilityLabel {
            icon 
              .accessibilityLabel(accessibilityLabel)
              .accessibilityRemoveTraits(.isImage)
          } else {
            icon 
              .accessibilityHidden(true)
          }
        }

      VStack(alignment: .leading, spacing: .spacing50) {
        if let title {
          Text(title)
            .font(.headline.weight(.semibold))
            .foregroundStyle(Color.neutral500)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        VStack(alignment: .leading, spacing: .spacing100) {
          Text(description)
            .font(.footnote)
            .foregroundStyle(Color.neutral500)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)

          bottomItem 
        }
      }
      .frame(minHeight: .spacing300)

      trailingItem 
        .frame(size: .spacing300)
        .foregroundStyle(Color.neutral200)
    }
    .contentBox(color: style.backgroundColor, shadow: nil)
  }
}

private extension InlineAlert.Style {
  var backgroundColor: Color {
    switch self {
    case .error:
      return .red20

    case .info:
      return .blue20

    case .warning:
      return .orange20

    case .success:
      return .green20

    case .announcement:
      return .white
    }
  }

  @ViewBuilder
  var icon: some View {
    switch self {
    case .error:
      Icons.Support.error
        .resizable()
        .foregroundStyle(Color.red100)
        .frame(size: .spacing300)

    case .info:
      Icons.Support.info
        .resizable()
        .foregroundStyle(Color.blue100)
        .frame(size: .spacing300)

    case .warning:
      Icons.Support.warning
        .resizable()
        .foregroundStyle(Color.orange100)
        .frame(size: .spacing300)

    case .success:
      Icons.Support.success
        .resizable()
        .foregroundStyle(Color.green100)
        .frame(size: .spacing300)

    case let .announcement(icon, color, backgroundColor):
      ZStack {
        Circle()
          .foregroundStyle(backgroundColor)
          .frame(size: .spacing600)

        icon 
          .resizable()
          .foregroundStyle(color)
          .frame(size: .spacing300)
      }
    }
  }

  var accessibilityLabel: String? {
    switch self {
    case .error:
      return A11y.commonAccessibilityCriticalInformation

    case .info:
      return A11y.commonAccessibilityInformation

    case .warning:
      return A11y.commonAccessibilityWarningInformation

    case .success:
      return A11y.commonAccessibilitySuccessInformation

    case .announcement:
      return nil
    }
  }
}
