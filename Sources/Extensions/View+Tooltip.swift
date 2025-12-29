import SwiftUI

struct TooltipModifier<Tooltip>: ViewModifier where Tooltip: View {
  let isHidden: Bool
  let padding: CGFloat
  let tooltip: () -> Tooltip

  func body(content: Content) -> some View {
    VStack(alignment: .leading, spacing: padding) {
      content 

      if !isHidden {
        tooltip()
      }
    }
  } 
} 

extension View {
  @warn_unqualified_access
  public func tooltip<Tooltip>(
    isHidden: Bool = false, 
    padding: CGFloat = .spacing50, 
    @ViewBuilder _ tooltip: @escaping () -> Tooltip 
  ) -> some View where Tooltip: View {
    modifier(
      TooltipModifier(
        isHidden: isHidden, 
        padding: padding, 
        tooltip: tooltip 
      )
    )
  }
}

extension View {
  @warn_unqualified_access
  public func tooltipText(
    _ text: String, 
    padding: CGFloat = .spacing50, 
    isHidden: Bool = false
  ) -> some View {
    self
      .tooltip(isHidden: isHidden, padding: padding) {
        Text(text)
          .multilineTextAlignment(.leading)
          .foregroundStyle(Color.neutral200)
          .font(.caption)
          .accessibilityIdentifier(.tooltipText)
      }
  }
}

private extension AccessibilityIdentifier {
  static let tooltipText: Self = .init("tooltipText")
}
