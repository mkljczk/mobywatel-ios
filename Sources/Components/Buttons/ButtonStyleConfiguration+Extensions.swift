import SwiftUI

extension ButtonStyleConfiguration.Label {
  var baseStyle: some View {
    self
      .font(.callout.weight(.semibold))
      .padding(.horizontal, .spacing200)
      .padding(.vertical, .spacing100)
      .frame(alignment: .center)
      .frame(maxWidth: .infinity, minHeight: .spacing600)
      .contentShape(.rect(cornerRadius: .radius300))
  }

  var iconBaseStyle: some View {
    self
      .frame(size: .spacing300)
      .padding(.spacing150)
      .frame(alignment: .center)
      .contentShape(.rect(cornerRadius: .radius300))
  }

  var smallBaseStyle: some View {
    self
      .font(.footnote.weight(.semibold))
      .padding(.horizontal, .spacing200)
      .padding(.vertical, .spacing50)
      .frame(alignment: .center)
      .frame(minHeight: .spacing400)
      .contentShape(.rect(cornerRadius: .radius200))
  }

  var iconSmallBaseStyle: some View {
    self
      .frame(size: .spacing300)
      .padding(.spacing50)
      .frame(alignment: .center)
      .contentShape(.rect(cornerRadius: .radius200))
  }
}
