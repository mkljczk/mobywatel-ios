public extension InputTextField {
  enum FieldType {
    case text
    case secure(Bool = true)
  }
}

extension InputTextField.FieldType {
  mutating func toogleSecureValue() {
    switch self {
    case let .secure(value):
      self = .secure(!value)

    default:
      break
    }
  }

  var isSecure: Bool {
    switch self {
    case let .secure(value):
      return value 

    default:
      return false
    }
  }
}
