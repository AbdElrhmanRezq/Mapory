String? Function(String?)? emptyValidator(String fieldName) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  };
}
