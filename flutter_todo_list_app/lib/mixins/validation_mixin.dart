class ValidationMixin {
  String validateTodoName(String value) {
    if (value.length == 0) {
      return 'Todo name is required';
    } else if (value.length > 30) {
      return 'Todo name is length max 30 character';
    }
    return null;
  }
}
