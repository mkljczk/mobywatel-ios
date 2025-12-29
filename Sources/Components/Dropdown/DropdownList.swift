import SwiftUI

public struct DropdownList<Item: Selectable, RowContent: View>: View {
  private let items: [Item]
  private let rowContent: (Item) -> RowContent
  @Binding var selectedItem: Item?
  @Environment(\.dismiss) private var dismiss 
  @Environment(\.appTheme) private var appTheme 

  public init( 
    _ items: [Item], 
    selectedItem: Binding<Item?>, 
    @ViewBuilder rowContent: @escaping (Item) -> RowContent
  ) {
    self.items = items 
    _selectedItem = selectedItem 
    self.rowContent = rowContent 
  }

  public var body: some View {
    if #available(iOS 17.0, *) {
      list 
        .onChange(of: selectedItem) { _, _ in dismiss() }
    } else {
      list 
        .onChange(of: selectedItem) { _ in dismiss() }
    }
  }
} 

public extension DropdownList where RowContent == Text {
  init(
    _ items: [Item], 
    selectedItem: Binding<Item?>
  ) {
    self.init(
      items, 
      selectedItem: selectedItem, 
      rowContent: {
        Text($0.text)
          .font(.headline.weight(.semibold))
      }
    )
  }
}

private extension DropdownList {
  var list: some View {
    List(items, id: \.self, selection: $selectedItem) { item in
      HStack {
        self.rowContent(item)

        Spacer()

        if item == selectedItem {
          Image(systemName: "checkmark")
            .foregroundStyle(appTheme.colors.primary900)
            .font(.headline.weight(.semibold))
        }
      }
      .listRowBackground(Color.white)
      .padding(.vertical, .spacing200)
    }
    .environment(\.editMode, .constant(.active))
  }
}
