import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_detail_page.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_search_page.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_category_page.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_bookmark_page.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/article/presentation/pages/admin/admin_article_list_page.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  String _selectedKategori = 'Semua';
  late Future<List<Article>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _refreshArticles();
  }

  Future<void> _refreshArticles() async {
    setState(() {
      _articlesFuture = DatabaseHelper.instance.readAllArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Artikel K3',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminArticleListPage(),
                ),
              );
              _refreshArticles();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ArticleSearchPage(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ArticleBookmarkPage(),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshArticles,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kategori Scroll View
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategori',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArticleCategoryPage(),
                      ),
                    ),
                    child: Text(
                      'Lihat Semua',
                      style: TextStyle(color: theme.colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: articleCategories.length,
                itemBuilder: (context, i) {
                  final isSelected = _selectedKategori == articleCategories[i];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        articleCategories[i],
                        style: TextStyle(
                          color: isSelected
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurface,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (val) {
                        setState(
                          () => _selectedKategori = articleCategories[i],
                        );
                      },
                      selectedColor: theme.colorScheme.primary,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      showCheckmark: false,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Daftar Artikel
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: _articlesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Terjadi kesalahan: \${snapshot.error}',
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'Tidak ada artikel.',
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                    );
                  }

                  final allArticles = snapshot.data!;
                  final filteredArticles = _selectedKategori == 'Semua'
                      ? allArticles
                      : allArticles
                            .where((a) => a.category == _selectedKategori)
                            .toList();

                  if (filteredArticles.isEmpty) {
                    return Center(
                      child: Text(
                        'Tidak ada artikel untuk kategori ini.',
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filteredArticles.length,
                    itemBuilder: (context, i) {
                      final article = filteredArticles[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        clipBehavior: Clip.antiAlias,
                        elevation: isDark ? 2 : 4,
                        shadowColor: isDark
                            ? Colors.transparent
                            : Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ArticleDetailPage(article: article),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: 'article_image_\${article.id}',
                                child: Image.network(
                                  article.imageUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 180,
                                      width: double.infinity,
                                      color: theme
                                          .colorScheme
                                          .surfaceContainerHighest,
                                      child: Icon(
                                        Icons.image,
                                        size: 50,
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            theme.colorScheme.primaryContainer,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        article.category,
                                        style: TextStyle(
                                          color: theme
                                              .colorScheme
                                              .onPrimaryContainer,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      article.title,
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 14,
                                          color: theme
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          article.date,
                                          style: TextStyle(
                                            color: theme
                                                .colorScheme
                                                .onSurfaceVariant,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
