String? validateEmail(String value) {
  if (value.isEmpty) {
    return "This field is required";
  }

  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? validateInput(String value) {
  if (value.isEmpty) {
    return "This field is required";
  }

  return null;
}
