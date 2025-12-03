import 'dart:io';

void main() {
  final directory = Directory('.'); // folder project Dart/Flutter
  final dartFiles = directory
      .listSync(recursive: true)
      .where((f) => f.path.endsWith('.dart'));

  for (var file in dartFiles) {
    final content = File(file.path).readAsStringSync();
    // hapus single-line comments
    var cleaned = content.replaceAll(RegExp(r'//.*'), '');
    // hapus multi-line comments
    cleaned = cleaned.replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '');
    File(file.path).writeAsStringSync(cleaned);
    print('Cleaned: ${file.path}');
  }
}
