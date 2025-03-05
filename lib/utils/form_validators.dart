class FormValidators {
  static String? isNameValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    value = value.trim();
    final nameParts = value.split(' ');
    nameParts.removeWhere((element) => element.isEmpty);
    if (nameParts.length == 1) {
      return 'Please provide both first and last name';
    }
    for (var name in nameParts) {
      name = name.trim();
      if (name.length < 2) {
        return "Name must be at least 2 characters";
      }
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email address is required";
    }
    if (!RegExp(r'^[\w-/.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(email)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password is required";
    }
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%]).{8,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(password)) {
      return '''Password must be at least 8 characters,\ninclude an uppercase letter, number and symbol.''';
    }
    return null;
  }

  static String? checkIfPasswordSame(String? password, String? val) {
    if (password != val) {
      return 'Passwords do not match';
    }
    return null;
  }
} 