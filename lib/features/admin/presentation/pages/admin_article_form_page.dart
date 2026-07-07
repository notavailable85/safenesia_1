import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';

class AdminArticleFormPage extends StatefulWidget {
  final ArticleModel? article;

  const AdminArticleFormPage({super.key, this.article});

  @override
  State<AdminArticleFormPage> createState() => _AdminArticleFormPageState();
}

class _AdminArticleFormPageState extends State<AdminArticleFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _slugController;
  late TextEditingController _summaryController;
  late TextEditingController _contentController;
  late TextEditingController _thumbnailController;
  late TextEditingController _imagesController;
  late TextEditingController _authorIdController;
  late TextEditingController _tagsController;
  late TextEditingController _readingTimeController;
  late TextEditingController _sourceController;
  late TextEditingController _sourceUrlController;

  String _selectedCategory = 'Umum';
  bool _isFeatured = false;
  bool _isPublished = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.article?.title ?? '');
    _slugController = TextEditingController(text: widget.article?.slug ?? '');
    _summaryController = TextEditingController(text: widget.article?.summary ?? '');
    _contentController = TextEditingController(text: widget.article?.content ?? '');
    _thumbnailController = TextEditingController(text: widget.article?.thumbnail ?? '');
    _imagesController = TextEditingController(text: widget.article?.images.join(', ') ?? '');
    _authorIdController = TextEditingController(text: widget.article?.authorId ?? 'admin1');
    _tagsController = TextEditingController(text: widget.article?.tags.join(', ') ?? '');
    _readingTimeController = TextEditingController(text: widget.article?.readingTime.toString() ?? '5');
    _sourceController = TextEditingController(text: widget.article?.source ?? '');
    _sourceUrlController = TextEditingController(text: widget.article?.sourceUrl ?? '');

    if (widget.article != null) {
      _isFeatured = widget.article!.isFeatured;
      _isPublished = widget.article!.isPublished;
    }

    if (widget.article != null &&
        articleCategories.contains(widget.article!.categoryId)) {
      _selectedCategory = widget.article!.categoryId;
    } else if (widget.article != null) {
      _selectedCategory = 'Umum';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _slugController.dispose();
    _summaryController.dispose();
    _contentController.dispose();
    _thumbnailController.dispose();
    _imagesController.dispose();
    _authorIdController.dispose();
    _tagsController.dispose();
    _readingTimeController.dispose();
    _sourceController.dispose();
    _sourceUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveArticle() async {
    if (_formKey.currentState!.validate()) {
      final isUpdating = widget.article != null;

      final article = ArticleModel(
        id: isUpdating
            ? widget.article!.id
            : DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        slug: _slugController.text,
        summary: _summaryController.text,
        content: _contentController.text,
        thumbnail: _thumbnailController.text,
        images: _imagesController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        categoryId: _selectedCategory,
        authorId: _authorIdController.text,
        tags: _tagsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        readingTime: int.tryParse(_readingTimeController.text) ?? 5,
        likes: widget.article?.likes ?? 0,
        bookmarks: widget.article?.bookmarks ?? 0,
        shares: widget.article?.shares ?? 0,
        isFeatured: _isFeatured,
        isPublished: _isPublished,
        source: _sourceController.text,
        sourceUrl: _sourceUrlController.text,
        createdAt: widget.article?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        publishedAt: _isPublished ? (widget.article?.publishedAt ?? DateTime.now()) : null,
      );

      if (isUpdating) {
        await DatabaseHelper.instance.update(article);
      } else {
        await DatabaseHelper.instance.create(article);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1500),
            content: Text(
              isUpdating
                  ? 'Artikel berhasil diperbarui'
                  : 'Artikel berhasil ditambahkan',
            ),
          ),
        );
      }
    }
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1, bool isNumber = false, String? hint, bool isRequired = true}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          alignLabelWithHint: maxLines > 1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: isDark
              ? theme.colorScheme.surfaceContainerHighest
              : Colors.white,
        ),
        validator: isRequired 
          ? (value) => value == null || value.isEmpty
              ? '$label tidak boleh kosong'
              : null
          : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final formCategories = articleCategories
        .where((c) => c != 'Semua')
        .toList();
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
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Informasi Dasar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(_titleController, 'Judul Artikel'),
              _buildTextField(_slugController, 'Slug'),
              _buildTextField(_summaryController, 'Ringkasan', maxLines: 3),
              
              DropdownButtonFormField(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDark
                      ? theme.colorScheme.surfaceContainerHighest
                      : Colors.white,
                ),
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
              
              _buildTextField(_authorIdController, 'Author ID'),
              _buildTextField(_tagsController, 'Tags', hint: 'Pisahkan dengan koma'),
              _buildTextField(_readingTimeController, 'Waktu Baca (Menit)', isNumber: true),

              const SizedBox(height: 32),
              Text(
                'Media & Konten',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(_thumbnailController, 'URL Thumbnail'),
              _buildTextField(_imagesController, 'URL Gambar Tambahan', hint: 'Pisahkan dengan koma', isRequired: false),
              _buildTextField(_contentController, 'Konten / Isi Artikel', maxLines: 12),

              const SizedBox(height: 32),
              Text(
                'Sumber & Status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(_sourceController, 'Sumber', hint: 'e.g. Kemnaker', isRequired: false),
              _buildTextField(_sourceUrlController, 'URL Sumber', isRequired: false),
              
              SwitchListTile(
                title: const Text('Featured Article'),
                value: _isFeatured,
                onChanged: (bool value) {
                  setState(() {
                    _isFeatured = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Published'),
                value: _isPublished,
                onChanged: (bool value) {
                  setState(() {
                    _isPublished = value;
                  });
                },
              ),

              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveArticle,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  widget.article == null
                      ? 'Simpan Artikel'
                      : 'Perbarui Artikel',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
