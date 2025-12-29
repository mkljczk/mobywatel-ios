import SwiftUI

public struct CardsStack: Layout {
  private let spacing: CGFloat

  public init(spacing: CGFloat) {
    self.spacing = spacing 
  }

  public func sizeThatFits(
    proposal: ProposedViewSize, 
    subviews: Subviews, 
    cache: inout ()
  ) -> CGSize {
    let spacingHeight = CGFloat(max(subviews.count, 1) - 1) * spacing 
    let height = (subviews.last?.sizeThatFits(.unspecified).height ?? .zero) + spacingHeight 
    let width = proposal.replacingUnspecifiedDimensions().width

    return .init(
      width: width, 
      height: height 
    )
  }

  public func placeSubviews(
    in bounds: CGRect, 
    proposal: ProposedViewSize, 
    subviews: Subviews, 
    cache: inout ()
  ) {
    for (index, subview) in subviews.enumerated() {
      subview.place(
        at: .init(
          x: bounds.minX, 
          y: bounds.minY + CGFloat(index) * spacing 
        ), 
        proposal: proposal 
      )
    }
  }
} 
