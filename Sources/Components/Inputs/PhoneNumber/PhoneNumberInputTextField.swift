import A11y
import SwiftUI

public struct PhoneNumberFieldsConfiguration<ID: Hashable> {
  public struct FieldConfiguration {
    let id: ID 
    let prompt: Text 
    let validationMessage: String?
    @Binding var text: String

    public init(
      id: ID, 
      text: Binding<String>, 
      validationMessage: String?, 
      prompt: String = ""
    ) {
      self.id = id 
      self.prompt = Text(prompt)
      self.validationMessage = validationMessage 
      self._text = text 
    }
  }

  let countryCode: FieldConfiguration 
  let localNumber: FieldConfiguration 

  public init(
    countryCode: FieldConfiguration, 
    localNumber: FieldConfiguration 
  ) {
    self.countryCode = countryCode 
    self.localNumber = localNumber 
  }

  public var validationMessage: String? {
    let message = [ 
      self.countryCode.validationMessage, 
      self.localNumber.validationMessage
    ] 
      .compactMap { $0 }
      .joined(separator: " ")

    return message.isEmpty ? nil : message 
  }
}

public struct PhoneNumberInputTextField<ID: Hashable>: View {
  private let label: String?
  private let fieldsConfiguration: PhoneNumberFieldsConfiguration<ID>
  private var accessibilityFocusState: AccessibilityFocusState<ID?>.Binding
  private var focusState: FocusState<ID?>.Binding
  @Environment(\.accessibilityVoiceOverEnabled) private var isVoiceOverEnabled
  @Environment(\.isEnabled) private var isEnabled

  public init( 
    label: String = "", 
    fieldsConfiguration: PhoneNumberFieldsConfiguration<ID>, 
    accessibilityFocusState: AccessibilityFocusState<ID?>.Binding,
    focusState: FocusState<ID?>.Binding
  ) {
    self.label = label 
    self.fieldsConfiguration = fieldsConfiguration 
    self.accessibilityFocusState = accessibilityFocusState 
    self.focusState = focusState 
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: .spacing50) {
      if let label {
        Text(label)
          .frame(alignment: .leading)
          .font(.footnote)
          .accessibilityIdentifier(.inputTitle)
          .accessibilityHidden(self.isVoiceOverEnabled)
      }

      HStack(spacing: .spacing100) {
        TextField(
          "", 
          text: self.fieldsConfiguration.countryCode.$text, 
          prompt: self.fieldsConfiguration.countryCode.prompt
            .foregroundColor(self.isEnabled ? Color.neutral100 : Color.neutral60)
        )
        .foregroundStyle(self.isEnabled ? Color.neutral500 : Color.neutral60)
        .padding(.spacing200)
        .onSubmit { self.focusState.wrappedValue = self.fieldsConfiguration.localNumber.id }
        .submitLabel(.next)
        .frame(
          width: Constants.countryCodeFieldWidth, 
          height: Constants.textFieldHeight
        )
        .multilineTextAlignment(.center)
        .focused(
          self.focusState, 
          equals: self.fieldsConfiguration.countryCode.id
        )
        .accessibilityFocused(
          self.accessibilityFocusState, 
          equals: self.fieldsConfiguration.countryCode.id
        )
        .accessibilityIdentifier(.countryCodeTextField)
        .accessibilityLabel(self.countryCodeAccessibilityLabel)
        .id(self.fieldsConfiguration.countryCode.id)
        .inputTextFieldBackground(
          isFocused: self.focusState.wrappedValue == self.fieldsConfiguration.countryCode.id, 
          isValid: self.fieldsConfiguration.countryCode.validationMessage == nil
        )

        HStack(spacing: .zero) {
          TextField(
            "", 
            text: self.fieldsConfiguration.localNumber.$text, 
            prompt: self.fieldsConfiguration.localNumber.prompt
              .foregroundColor(self.isEnabled ? Color.neutral100 : Color.neutral60)
          )
          .foregroundStyle(self.isEnabled ? Color.neutral500 : Color.neutral60)
          .submitLabel(.done)
          .focused(
            self.focusState, 
            equals: self.fieldsConfiguration.localNumber.id
          )
          .accessibilityFocused(
            self.accessibilityFocusState, 
            equals: self.fieldsConfiguration.localNumber.id
          )
          .accessibilityIdentifier(.phoneNumberTextField)
          .accessibilityLabel(self.phoneNumberAccessibilityLabel)
          .id(self.fieldsConfiguration.localNumber.id)

          if
            self.focusState.wrappedValue == self.fieldsConfiguration.localNumber.id, 
            !self.fieldsConfiguration.localNumber.text.isEmpty
          {
            Button(
              action: { self.fieldsConfiguration.localNumber.$text.wrappedValue.removeAll() }, 
              label: { Icons.Outline.Symbols.fail }
            )
            .padding(.leading, .spacing100)
            .accessibilityIdentifier(.phoneNumberClearButton)
            .accessibilityLabel(A11y.commonAccessibilityClearField)
          }
        }
        .padding(.spacing200)
        .frame(height: Constants.textFieldHeight)
        .inputTextFieldBackground(
          isFocused: self.focusState.wrappedValue == self.fieldsConfiguration.localNumber.id, 
          isValid: self.fieldsConfiguration.localNumber.validationMessage == nil
        )
      }
      .autocapitalization(.none)
      .keyboardType(.phonePad)
      .autocorrectionDisabled()
      .frame(maxWidth: .infinity)
    }
    .foregroundStyle(self.isEnabled ? Color.neutral200 : Color.neutral60)
    .validation(self.fieldsConfiguration.validationMessage)
  }
} 

private extension PhoneNumberInputTextField {
  var countryCodeAccessibilityLabel: String {
    (label ?? "") + ", " + A11y.commonAccessibilityCountryCode
  }

  var phoneNumberAccessibilityLabel: String {
    (label ?? "") + ", " + A11y.commonAccessibilityPhoneNumber
  }
}

private extension AccessibilityIdentifier {
  static let inputTitle = AccessibilityIdentifier("inputTitle")
  static let phoneNumberTextField = AccessibilityIdentifier("phoneNumberTextField")
  static let phoneNumberClearButton = AccessibilityIdentifier("phoneNumberClearButton")
  static let countryCodeTextField = AccessibilityIdentifier("countryCodeTextField")
}

private enum Constants {
  static let countryCodeFieldWidth = 110.0
  static let textFieldHeight = 56.0
}
