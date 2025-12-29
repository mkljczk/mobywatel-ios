import SwiftUI

typealias Cell = PinInputTextField.Cell

struct PinInputTextFieldStyle: TextFieldStyle {
  private let cells: [Cell.State]
  private let isFocused: FocusState<Bool>.Binding

  init( 
    cells: [Cell.State], 
    isFocused: FocusState<Bool>.Binding
  ) {
    self.cells = cells 
    self.isFocused = isFocused 
  }

  
  public func _body(configuration: TextField<Self._Label>) -> some View {
    ZStack {
      configuration 
        .keyboardType(.numberPad)
        .frame(
          width: Constants.allCellsWidthAndSpacing(self.cells.count), 
          height: Cell.height
        )
        .invisible

      HStack(spacing: Constants.cellSpacing) {
        ForEach(self.cells) {
          Cell(state: $0)
        }
      }
      .onLongPressGesture {}
    }
    .onTapGesture { self.isFocused.wrappedValue = true }
  }
} 

private enum Constants {
  static let cellSpacing = CGFloat.spacing150

  static func allCellsWidthAndSpacing(_ numberOfCells: Int) -> CGFloat {
    Constants.allCellWidth(numberOfCells) + Constants.allCellsSpacing(numberOfCells)
  }

  static func allCellWidth(_ numberOfCells: Int) -> CGFloat {
    Cell.width * CGFloat(numberOfCells)
  }

  static func allCellsSpacing(_ numberOfCells: Int) -> CGFloat {
    CGFloat(numberOfCells - 1) * cellSpacing 
  }
}
