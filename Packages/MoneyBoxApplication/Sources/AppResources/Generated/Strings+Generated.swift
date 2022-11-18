// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  public enum Account {
    /// Hello %@!
    public static func name(_ p1: Any) -> String {
      return Strings.tr("Localizable", "account.name", String(describing: p1), fallback: "Hello %@!")
    }
    /// User Account
    public static let title = Strings.tr("Localizable", "account.title", fallback: "User Account")
    /// Total Plan Value: %@%@
    public static func totalPlan(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "account.totalPlan", String(describing: p1), String(describing: p2), fallback: "Total Plan Value: %@%@")
    }
    public enum Cell {
      /// Moneybox: %@%@
      public static func moneyboxValue(_ p1: Any, _ p2: Any) -> String {
        return Strings.tr("Localizable", "account.cell.moneybox-value", String(describing: p1), String(describing: p2), fallback: "Moneybox: %@%@")
      }
      /// Plan Value: %@%@
      public static func planValue(_ p1: Any, _ p2: Any) -> String {
        return Strings.tr("Localizable", "account.cell.plan-value", String(describing: p1), String(describing: p2), fallback: "Plan Value: %@%@")
      }
    }
  }
  public enum Login {
    /// Login
    public static let loginButtonTitle = Strings.tr("Localizable", "login.login_button_title", fallback: "Login")
    /// Email
    public static let loginPlaceholder = Strings.tr("Localizable", "login.login_placeholder", fallback: "Email")
    /// Password
    public static let passwordPlaceholder = Strings.tr("Localizable", "login.password_placeholder", fallback: "Password")
  }
  public enum ProductDetails {
    /// Add %@%@
    public static func add(_ p1: Any, _ p2: Any) -> String {
      return Strings.tr("Localizable", "product_details.add", String(describing: p1), String(describing: p2), fallback: "Add %@%@")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
