import SwiftUI

struct SnackBarView: View {
  let item: Binding<SnackBar?>
  @Environment(\.sleep) private var sleep 

  var body: some View {
    if let item = self.item.wrappedValue {
      HStack(alignment: .top) {
        Text(item.title)
          .fixedSize(horizontal: false, vertical: true)
          .foregroundStyle(Color.white)
          .font(.footnote)
          .accessibilityIdentifier(.snackbarTitle)

        Spacer()

        if item.duration == nil {
          Button {
            self.item.wrappedValue = nil
          } label: {
            Icons.Outline.Navigation.xmark
              .resizable()
              .aspectRatio(contentMode: .fit)
              .foregroundStyle(Color.white)
              .frame(size: .smallIcon)
          }
        }
      }
      .padding(.spacing200)
      .background(
        RoundedRectangle(cornerRadius: .radius50)
          .fill(Color.neutral200)
      )
      .frame(minHeight: Constants.minHeight)
      .padding([.bottom, .horizontal], .spacing200)
      .shadow(.light600)
      .task {
        if let duration = item.duration, !Task.isCancelled {
          await sleep(nanoseconds: duration.nanoseconds)
          self.item.wrappedValue = nil
        }
      }
      .id(item)
    }
  } 
} 

private extension TimeInterval {
  var nanoseconds: UInt64 {
    UInt64((self * 1_000_000_000).rounded())
  }
}

private extension AccessibilityIdentifier {
  static let snackbarTitle: Self = .init("snackbarTitle")
}

private enum Constants {
  static let minHeight = 48.0
}
