import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';

class AdminArticleFormPage extends StatefulWidget {
  final Article? article;

  const AdminArticleFormPage({super.key, this.article});

  @override
  State<AdminArticleFormPage> createState() => _AdminArticleFormPageState();
}

class _AdminArticleFormPageState extends State<AdminArticleFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String category;
  late String date;
  late String imageUrl;
  late String content;

  @override
  void initState() {
    super.initState();
    title = widget.article?.title ?? '';
    category = widget.article?.category ?? '';
    date = widget.article?.date ?? DateTime.now().toIso8601String().split('T').first;
    imageUrl = widget.article?.imageUrl ?? '';
    content = widget.article?.content ?? '';
  }

  void addOrUpdateArticle() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final isUpdating = widget.article != null;

      if (isUpdating) {
        final article = Article(
          id: widget.article!.id,
          title: title,
          category: category,
          date: date,
          imageUrl: imageUrl,
          content: content,
        );
        await DatabaseHelper.instance.update(article);
      } else {
        final article = Article(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          category: category,
          date: date,
          imageUrl: imageUrl,
          content: content,
        );
        await DatabaseHelper.instance.create(article);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article == null ? 'Add Article' : 'Edit Article'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              validator: (value) => value != null && value.isEmpty ? 'Title cannot be empty' : null,
              onChanged: (value) => setState(() => title = value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: category,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              validator: (value) => value != null && value.isEmpty ? 'Category cannot be empty' : null,
              onChanged: (value) => setState(() => category = value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: date,
              decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)', border: OutlineInputBorder()),
              validator: (value) => value != null && value.isEmpty ? 'Date cannot be empty' : null,
              onChanged: (value) => setState(() => date = value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: imageUrl,
              decoration: const InputDecoration(labelText: 'Image URL', border: OutlineInputBorder()),
              onChanged: (value) => setState(() => imageUrl = value),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: content,
              decoration: const InputDecoration(labelText: 'Content', border: OutlineInputBorder()),
              maxLines: 5,
              validator: (value) => value != null && value.isEmpty ? 'Content cannot be empty' : null,
              onChanged: (value) => setState(() => content = value),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: addOrUpdateArticle,
              child: const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
