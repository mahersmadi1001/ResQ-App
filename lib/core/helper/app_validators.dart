enum IdentityType { nationalID, passport, none }

class AppValidators {
  static final RegExp _nationalIdRegex = RegExp(r'^(0[1-9]|1[0-4])[0-9]{9}$');
  static final RegExp _passportRegex = RegExp(r'^[a-zA-Z0-9]{6,12}$');

  static final RegExp _nameRegex = RegExp(r'^[\u0600-\u06FFa-zA-Z\s]{2,30}$');

  static final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
  );
  static IdentityType getIdentityType(String value) {
    if (_nationalIdRegex.hasMatch(value)) return IdentityType.nationalID;
    if (_passportRegex.hasMatch(value)) return IdentityType.passport;
    return IdentityType.none;
  }

  static String? validateIDOrPassport(String? value) {
    if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';

    final trimmedValue = value.trim();
    if (_nationalIdRegex.hasMatch(trimmedValue) ||
        _passportRegex.hasMatch(trimmedValue)) {
      return null;
    }
    return 'رقم وطني أو جواز سفر غير صالح';
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال الاسم';
    if (!_nameRegex.hasMatch(value)) return 'الاسم يجب أن يحتوي على حروف فقط';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال البريد الإلكتروني';
    if (!_emailRegex.hasMatch(value)) return 'صيغة البريد الإلكتروني غير صحيحة';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'يرجى إدخال كلمة السر';
    if (!_passwordRegex.hasMatch(value)) {
      return 'يجب أن تحتوي على حروف كبيرة وصغيرة وأرقام ورموز';
    }
    return null;
  }
}
