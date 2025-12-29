import SwiftUI

public enum StatusBadge: Equatable {
  case informativeDot 
  case positiveDot 
  case negativeDot 
  case warningDot 
  case informativeIcon 
  case positiveIcon 
  case negativeIcon 
  case noticeIcon 
  case minusIcon 
  case borderedInformativeIcon 
  case borderedPositiveIcon 
  case borderedNegativeIcon 
  case borderedNoticeIcon 
  case borderedMinusIcon 
}

extension LabelStyle where Self == StatusBadgeLabelStyle {
  public static func status(_ badge: StatusBadge) -> Self {
    .init(badge: badge)
  }
}

public struct StatusBadgeLabelStyle: LabelStyle {
  private let badge: StatusBadge

  public init(badge: StatusBadge) {
    self.badge = badge 
  }

  public func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: .spacing50) {
      HStack(alignment: .center, spacing: .zero) {
        badge.icon
          .frame(size: badge.size)
          .accessibilityHidden(true)
      }
      .frame(size: Constants.iconSize)

      configuration.title
        .font(badge.font)
        .multilineTextAlignment(.leading)
    }
    .apply(if: !badge.isBordered) {
      $0.frame(maxWidth: .infinity, minHeight: Constants.minHeight, alignment: .leading)
    }
    .apply(if: badge.isBordered) {
      $0
        .padding(.horizontal, .spacing100)
        .frame(minHeight: Constants.minBorderedHeight)
        .background(
          Capsule()
            .strokeBorder(Color.neutral60, lineWidth: Constants.lineWidth)
        )
    }
  }
} 

extension StatusBadge {
  var size: CGFloat {
    switch self {
    case
        .informativeDot, 
        .positiveDot, 
        .negativeDot, 
        .warningDot:
      return Constants.dotSize

    default:
      return Constants.iconSize
    }
  }

  var font: Font {
    switch self {
    case
        .borderedInformativeIcon, 
        .borderedPositiveIcon, 
        .borderedNegativeIcon, 
        .borderedNoticeIcon, 
        .borderedMinusIcon:
      return .caption

    default:
      return .body.weight(.semibold)
    }
  }

  var isBordered: Bool {
    switch self {
    case
        .borderedInformativeIcon, 
        .borderedPositiveIcon, 
        .borderedNegativeIcon, 
        .borderedNoticeIcon, 
        .borderedMinusIcon:
      return true

    default:
      return false
    }
  }

  @ViewBuilder
  var icon: some View {
    switch self {
    case .informativeDot:
      Icons.Dedicated.badge.badge(color: .blue100)

    case .positiveDot:
      Icons.Dedicated.badge.badge(color: .green100)

    case .negativeDot:
      Icons.Dedicated.badge.badge(color: .red100)

    case .warningDot:
      Icons.Dedicated.badge.badge(color: .orange100)

    case .informativeIcon, .borderedInformativeIcon:
      Icons.Filled.info.badge(color: .blue100)

    case .positiveIcon, .borderedPositiveIcon:
      Icons.Filled.checkMark.badge(color: .green100)

    case .negativeIcon, .borderedNegativeIcon:
      Icons.Filled.xMark.badge(color: .red100)

    case .noticeIcon, .borderedNoticeIcon:
      Icons.Filled.noticeMark.badge()

    case .minusIcon, .borderedMinusIcon:
      Icons.Filled.minus.badge(color: .neutral200)
    }
  }
}

extension Image {
  @ViewBuilder
  fileprivate func badge(color: Color? = nil) -> some View {
    self
      .resizable()
      .apply(ifLet: color) { $0.foregroundStyle($1) }
  }
}

extension AccessibilityIdentifier {
  private static let status: Self = .init("status")
}

private enum Constants {
  static let lineWidth = 1.0
  static let dotSize = 8.0
  static let iconSize = 16.0
  static let minBorderedHeight = 32.0
  static let minHeight = 22.0
}
