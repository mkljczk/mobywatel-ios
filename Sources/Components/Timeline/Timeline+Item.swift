import SwiftUI

extension Timeline {
  public struct Item: Equatable {
    let header: String
    let title: String
    let descriptions: [String]

    public init( 
      header: String,
      title: String,
      descriptions: [String] = [] 
    ) {
      self.header = header 
      self.title = title 
      self.descriptions = descriptions 
    }
  }
} 
