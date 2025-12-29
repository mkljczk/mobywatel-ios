import SwiftUI
import UIKit

public func setupAppearance(appTheme: AppTheme) {
  UITabBar.setupAppearance(appTheme: appTheme)
  UIPageControl.setupAppearance(appTheme: appTheme)
  UINavigationBar.setupAppearance(appTheme: appTheme)
  UITableView.setupAppearance()
  UITextView.setupAppearance()
}

extension UITableView {
  static func setupAppearance() {
    Self.appearance().backgroundColor = UIColor(Color.background)
  }
}

extension UITextView {
  static func setupAppearance() {
    Self.appearance().textContainerInset = .zero
  }
}

extension UITabBar {
  static func setupAppearance(appTheme: AppTheme) {
    Self.appearance().standardAppearance = appTheme.tabBarAppearance
    Self.appearance().scrollEdgeAppearance = appTheme.tabBarAppearance
  }
}

extension UIPageControl {
  static func setupAppearance(appTheme: AppTheme) {
    Self.appearance().pageIndicatorTintColor = UIColor(.neutral80)
    Self.appearance().currentPageIndicatorTintColor = UIColor(appTheme.colors.primary900)
    Self.appearance().preferredIndicatorImage = UIImage(systemName: "circle")
    Self.appearance().preferredCurrentPageIndicatorImage = UIImage(systemName: "circle.fill")
  }
}

extension UINavigationBar {
  static func setupAppearance(appTheme: AppTheme) {
    let scrollEdgeAppearance = appTheme.navigationBarAppearance.scrollEdge
    let standardAppearance = appTheme.navigationBarAppearance.standard

    UINavigationBar.appearance().standardAppearance = standardAppearance 
    UINavigationBar.appearance().compactAppearance = standardAppearance 
    UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance 
    UINavigationBar.appearance().barTintColor = UIColor(appTheme.colors.primary900)
  }
}
