import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_detail_page.dart';
import 'package:safenesia_1/core/database/database_helper.dart';

class ArticleSearchPage extends StatefulWidget {
  const ArticleSearchPage({super.key});

  @override
  State<ArticleSearchPage> createState() => _ArticleSearchPageState();
}

class _ArticleSearchPageState extends State<ArticleSearchPage> {
  String _searchQuery = '';
  List<Article> _allArticles = [];
  List<Article> _searchResults = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    final articles = await DatabaseHelper.instance.readAllArticles();
    setState(() {
      _allArticles = articles;
      _searchResults = articles;
      _isLoading = false;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _searchResults = _allArticles;
      } else {
        _searchResults = _allArticles
            .where((article) =>
                article.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Cari artikel...',
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.white54, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.white54, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.white, width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white12,
            hintStyle: TextStyle(color: Colors.white70),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.white70,
              size: 20,
            ),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18),
          onChanged: _onSearchChanged,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        'Tidak menemukan artikel "$_searchQuery"',
                        style: GoogleFonts.inter(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final article = _searchResults[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            article.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.image),
                            ),
                          ),
                        ),
                        title: Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            article.category,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ArticleDetailPage(article: article),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
