import Foundation

public protocol Selectable: Equatable, Hashable {
  var text: String { get }
} 
