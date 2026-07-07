import 'dart:io';

void main() {
  final dir = Directory('c:/src/safenesia_1/lib');
  int count = 0;

  for (var file in dir.listSync(recursive: true)) {
    if (file is File && file.path.endsWith('.dart')) {
      final content = file.readAsStringSync();
      
      if (content.contains('SnackBar(')) {
        var newContent = content.replaceAll(
          'SnackBar(content:', 
          'SnackBar(duration: const Duration(milliseconds: 2500), content:'
        );
        newContent = newContent.replaceAll(
          'SnackBar(\n', 
          'SnackBar(\nduration: const Duration(milliseconds: 2500),\n'
        );
        newContent = newContent.replaceAll(
          'SnackBar(  content:', 
          'SnackBar(duration: const Duration(milliseconds: 2500), content:'
        );
        
        if (newContent != content) {
          file.writeAsStringSync(newContent);
          count++;
        }
      }
    }
  }
  print('Updated \$count files.');
}
