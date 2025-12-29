import SwiftUI

public struct AppTheme {
  public let colors: Colors 
  public let cornerRadius: CornerRadius 
  public let navigationBarAppearance: NavigationBarAppearance 
  public let tabBarAppearance: UITabBarAppearance 

  public struct Colors {
    public let primary900: Color 
    public let secondary900: Color 

    public init(
      primary900: Color = .primary900, 
      secondary900: Color = .secondary900
    ) {
      self.primary900 = primary900 
      self.secondary900 = secondary900 
    }
  }

  public struct NavigationBarAppearance {
    public let scrollEdge: UINavigationBarAppearance 
    public let standard: UINavigationBarAppearance 

    public init(
      scrollEdge: UINavigationBarAppearance = .defaultScrollEdgeAppearance, 
      standard: UINavigationBarAppearance = .defaultStandardAppearance
    ) {
      self.scrollEdge = scrollEdge 
      self.standard = standard 
    }
  }

  public struct CornerRadius {
    public let border: CGFloat 
    public let button: CGFloat 

    public init(
      border: CGFloat = .radius50, 
      button: CGFloat = .radius300
    ) {
      self.border = border 
      self.button = button 
    }
  }

  public init(
    colors: Colors = .init(), 
    cornerRadius: CornerRadius = .init(), 
    navigationBarAppearance: NavigationBarAppearance = .init(), 
    tabBarAppearance: UITabBarAppearance = .defaultAppearance(colors: .init())
  ) {
    self.colors = colors 
    self.cornerRadius = cornerRadius 
    self.navigationBarAppearance = navigationBarAppearance 
    self.tabBarAppearance = tabBarAppearance 
  }
}

extension AppTheme {
  @available(*, deprecated, message: "Use 'colors.primary900' instead.")
  public var primary900: Color {
    self.colors.primary900
  }

  @available(*, deprecated, message: "Use 'colors.secondary900' instead.")
  public var secondary900: Color {
    self.colors.secondary900
  }

  @available(*, deprecated, message: "Use 'cornerRadius.border' instead.")
  public var borderRadius: CGFloat {
    self.cornerRadius.border
  }

  @available(*, deprecated, message: "Use 'cornerRadius.button' instead.")
  public var buttonRadius: CGFloat {
    self.cornerRadius.button
  }
}

extension AppTheme {
  public static let wallet = Self(
    colors: .init(
      primary900: .walletPrimary900, 
      secondary900: .walletSecondary900
    ), 
    cornerRadius: .init(
      border: .radius150, 
      button: .radius150
    )
  )
}

private enum AppThemeKey: EnvironmentKey {
  static let defaultValue = AppTheme() 
}

extension EnvironmentValues {
  public var appTheme: AppTheme {
    get { self[AppThemeKey.self] }
    set { self[AppThemeKey.self] = newValue }
  }
}

public extension UITabBarAppearance {
  static func defaultAppearance(colors: AppTheme.Colors) -> UITabBarAppearance {
    let appearance = UITabBarAppearance()
    appearance.configureWithDefaultBackground()
    appearance.backgroundColor = UIColor(.background)
    appearance.stackedLayoutAppearance.normal.iconColor = UIColor(.neutral200)
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [ 
      .foregroundColor: UIColor(.neutral200)
    ] 
    appearance.stackedLayoutAppearance.selected.iconColor = UIColor(colors.primary900)
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [ 
      .foregroundColor: UIColor(colors.primary900)
    ] 
    return appearance 
  }
}

public extension UINavigationBarAppearance {
  static var defaultScrollEdgeAppearance: UINavigationBarAppearance {
    let scrollEdgeAppearance = UINavigationBarAppearance()
    scrollEdgeAppearance.configureWithTransparentBackground()
    scrollEdgeAppearance.backgroundColor = UIColor(Color.background)
    scrollEdgeAppearance.titleTextAttributes = [ 
      .foregroundColor: UIColor(Color.neutral500), 
      .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
    ] 
    return scrollEdgeAppearance 
  }

  static var defaultStandardAppearance: UINavigationBarAppearance {
    let standardAppearance = UINavigationBarAppearance()
    standardAppearance.configureWithDefaultBackground()
    standardAppearance.backgroundColor = UIColor(Color.background)
    standardAppearance.titleTextAttributes = [ 
      .foregroundColor: UIColor(Color.neutral500), 
      .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
    ] 
    return standardAppearance 
  }
}

private extension Color {
  
  
  static let walletPrimary900 = Color("walletPrimary900", bundle: .module)
  
  
  static let walletSecondary900 = Color("walletSecondary900", bundle: .module)
}
