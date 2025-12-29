import SwiftUI

public extension View {
  func primaryStyle(appTheme: AppTheme) -> some View {
    self
      .tint(appTheme.colors.primary900)
  }
}
