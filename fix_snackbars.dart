import 'dart:io';

void main() {
  final dir = Directory('c:/src/safenesia_1/lib');
  int count = 0;
  
  final regex = RegExp(r'showSnackBar\(\s*duration:\s*const\s*Duration\(milliseconds:\s*2500\),');
  
  for (var file in dir.listSync(recursive: true)) {
    if (file is File && file.path.endsWith('.dart')) {
      final content = file.readAsStringSync();
      
      if (regex.hasMatch(content)) {
        var newContent = content.replaceAll(regex, 'showSnackBar(');
        
        if (newContent != content) {
          file.writeAsStringSync(newContent);
          count++;
        }
      }
    }
  }
  print('Fixed \$count files.');
}
