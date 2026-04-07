class Validators {
  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return "Email required";

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(v)) return "Invalid email";
    return null;
  }

  static String? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return "Password required";
    if (v.length < 6) return "Min 6 characters";
    return null;
  }
}