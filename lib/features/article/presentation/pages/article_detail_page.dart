import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';

class ArticleDetailPage extends StatefulWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarked_articles') ?? [];
    setState(() {
      _isBookmarked = bookmarks.contains(widget.article.id);
    });
  }

  Future<void> _toggleBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarked_articles') ?? [];

    if (_isBookmarked) {
      bookmarks.remove(widget.article.id);
    } else {
      bookmarks.add(widget.article.id);
    }

    await prefs.setStringList('bookmarked_articles', bookmarks);
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isBookmarked
              ? 'Artikel disimpan ke Bookmark'
              : 'Artikel dihapus dari Bookmark'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Artikel'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            ),
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.article.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image, size: 80, color: Colors.grey),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.article.category,
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.calendar_today,
                          size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        widget.article.date,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.article.title,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    widget.article.content,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      height: 1.6, // line height
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
