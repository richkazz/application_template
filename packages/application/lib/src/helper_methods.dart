Map<String, dynamic> convertTheKeysFirstCharacterToSmallAlphabet(
  Map<String, dynamic> json,
) {
  final updatedJson = <String, dynamic>{};
  json.forEach((key, value) {
    final updatedKey = key[0].toLowerCase() + key.substring(1);
    updatedJson[updatedKey] = value;
  });
  return updatedJson;
}
