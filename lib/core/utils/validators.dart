class Validators {
  static String? email(String value) {
    if (value.isEmpty) return "Email required";
    if (!value.contains("@")) return "Invalid email";
    return null;
  }

  static String? password(String value) {
    if (value.isEmpty) return "Password required";
    if (value.length < 6) return "Min 6 characters";
    return null;
  }
}

// this is password validation atleast 6 character must should be compulsory.