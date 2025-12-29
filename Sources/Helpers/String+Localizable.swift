import Foundation

extension String {
  static let accessibilityClose = localized("accessibility_close", fallback: "Zamknij")
  static let accessibilityInfo = localized("accessibility_info", fallback: "Informacje")
  static let accessibilityFindOutMore = localized("accessibility_find_out_more", fallback: "Dowiedz się więcej")

  private static func localized(
    _ key: StaticString, 
    fallback value: String.LocalizationValue 
  ) -> Self {
    Self(
      localized: key, 
      defaultValue: value, 
      table: "Localizable", 
      bundle: bundle 
    )
  }
}
