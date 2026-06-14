import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';

class AdminArticleFormPage extends StatefulWidget {
  final Article? article; // null if creating, not null if editing

  const AdminArticleFormPage({super.key, this.article});

  @override
  State<AdminArticleFormPage> createState() => _AdminArticleFormPageState();
}

class _AdminArticleFormPageState extends State<AdminArticleFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _imageUrlController;
  late TextEditingController _contentController;
  late TextEditingController _dateController;
  
  String _selectedCategory = 'Umum';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.article?.title ?? '');
    _imageUrlController = TextEditingController(text: widget.article?.imageUrl ?? '');
    _contentController = TextEditingController(text: widget.article?.content ?? '');
    
    final now = DateTime.now();
    final List<String> months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final defaultDate = '${now.day} ${months[now.month]} ${now.year}';
    
    _dateController = TextEditingController(
      text: widget.article?.date ?? defaultDate,
    );
    
    if (widget.article != null && articleCategories.contains(widget.article!.category)) {
      _selectedCategory = widget.article!.category;
    } else if (widget.article != null) {
      // If the category is not in the list, default to 'Umum'
      _selectedCategory = 'Umum';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageUrlController.dispose();
    _contentController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _saveArticle() async {
    if (_formKey.currentState!.validate()) {
      final isUpdating = widget.article != null;
      
      final article = Article(
        id: isUpdating ? widget.article!.id : DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        category: _selectedCategory,
        date: _dateController.text,
        imageUrl: _imageUrlController.text,
        content: _contentController.text,
      );

      if (isUpdating) {
        await DatabaseHelper.instance.update(article);
      } else {
        await DatabaseHelper.instance.create(article);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isUpdating ? 'Artikel berhasil diperbarui' : 'Artikel berhasil ditambahkan')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter out "Semua" from categories for the form
    final formCategories = articleCategories.where((c) => c != 'Semua').toList();
    if (!formCategories.contains(_selectedCategory)) {
        if (formCategories.isNotEmpty) {
           _selectedCategory = formCategories.first;
        }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article == null ? 'Tambah Artikel' : 'Edit Artikel'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul Artikel', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Kategori', border: OutlineInputBorder()),
                items: formCategories.map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Tanggal (e.g., 12 Agustus 2026)', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Tanggal tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL Gambar', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'URL Gambar tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Konten', border: OutlineInputBorder()),
                maxLines: 10,
                validator: (value) => value == null || value.isEmpty ? 'Konten tidak boleh kosong' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveArticle,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text(widget.article == null ? 'Simpan' : 'Perbarui', style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
