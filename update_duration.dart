// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  final dir = Directory('c:/src/safenesia_1/lib');
  int count = 0;
  
  for (var file in dir.listSync(recursive: true)) {
    if (file is File && file.path.endsWith('.dart')) {
      final content = file.readAsStringSync();
      
      if (content.contains('Duration(milliseconds: 2500)')) {
        var newContent = content.replaceAll(
          'Duration(milliseconds: 2500)', 
          'Duration(milliseconds: 1500)'
        );
        
        if (newContent != content) {
          file.writeAsStringSync(newContent);
          count++;
        }
      }
    }
  }
  print('Updated duration in $count files.');
}
