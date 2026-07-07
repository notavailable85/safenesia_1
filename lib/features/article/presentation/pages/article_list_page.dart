import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_detail_page.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_search_page.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_category_page.dart';
import 'package:safenesia_1/features/article/presentation/pages/article_bookmark_page.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:safenesia_1/core/widgets/standard_search_field.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  String _selectedKategori = 'Semua';
  late Future<List<ArticleModel>> _articlesFuture;
  Set<String> _bookmarkedArticleIds = {};
  String _searchQuery = '';
  String _sortBy = 'Terbaru';

  @override
  void initState() {
    super.initState();
    _refreshArticles();
  }

  Future<void> _refreshArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarked_articles') ?? [];
    
    setState(() {
      _bookmarkedArticleIds = bookmarks.toSet();
      _articlesFuture = DatabaseHelper.instance.readAllArticles();
    });
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Artikel',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          color: Theme.of(context).colorScheme.onSurface,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Urutkan',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: ['Terbaru', 'Terlama', 'Terpopuler'].map((sortType) {
                      final isSelected = _sortBy == sortType;
                      return ChoiceChip(
                        label: Text(' $sortType '),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setModalState(() => _sortBy = sortType);
                            setState(() => _sortBy = sortType);
                          }
                        },
                        selectedColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                          ),
                        ),
                        showCheckmark: false,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Terapkan',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final tabs = articleCategories;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: StandardSearchField(
            hintText: 'Cari artikel...',
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterModal,
            ),
            IconButton(
              icon: const Icon(Icons.bookmark_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArticleBookmarkPage(),
                  ),
                ).then((_) => _refreshArticles());
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(58),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 2,
                  thickness: 2,
                  color: isDark ? Colors.black : Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black26
                            : theme.primaryColor.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: -8,
                      vertical: 6,
                    ),
                    indicator: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor:
                        theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    labelStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: tabs.map((category) => Tab(text: category)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: tabs.map((category) {
            return _buildArticleList(context, category, theme, isDark);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildArticleList(
    BuildContext context,
    String category,
    ThemeData theme,
    bool isDark,
  ) {
    return RefreshIndicator(
      onRefresh: _refreshArticles,
      child: FutureBuilder<List<ArticleModel>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
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
          var filteredArticles = category == 'Semua'
              ? allArticles
              : allArticles.where((a) => a.categoryId == category).toList();

          if (_searchQuery.isNotEmpty) {
            filteredArticles = filteredArticles
                .where((a) =>
                    a.title.toLowerCase().contains(_searchQuery.toLowerCase()))
                .toList();
          }

          if (_sortBy == 'Terbaru') {
            filteredArticles.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          } else if (_sortBy == 'Terlama') {
            filteredArticles.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          } else if (_sortBy == 'Terpopuler') {
            filteredArticles.sort((a, b) => (b.shares + b.bookmarks).compareTo(a.shares + a.bookmarks));
          }

          if (filteredArticles.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada artikel untuk kategori ini.',
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: filteredArticles.length,
            itemBuilder: (context, i) {
              final article = filteredArticles[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 20),
                clipBehavior: Clip.antiAlias,
                elevation: isDark ? 2 : 4,
                shadowColor: isDark ? Colors.transparent : Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticleDetailPage(article: article),
                      ),
                    ).then((_) => _refreshArticles());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Hero(
                            tag: 'article_image_${article.id}',
                            child: Image.network(
                              article.thumbnail,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 180,
                                  width: double.infinity,
                                  color: theme.colorScheme.surfaceContainerHighest,
                                  child: Icon(
                                    Icons.image,
                                    size: 50,
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer
                                    .withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                article.categoryId,
                                style: TextStyle(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "${article.createdAt.day}/${article.createdAt.month}/${article.createdAt.year}",
                                      style: TextStyle(
                                        color: theme.colorScheme.onSurfaceVariant,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      alignment: Alignment.centerRight,
                                      icon: Icon(
                                        Icons.share_outlined,
                                        size: 20,
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                      onPressed: () async {
                                        await Share.share('${article.title}\n\nBaca selengkapnya di: ${article.sourceUrl}');
                                        await DatabaseHelper.instance
                                            .updateArticleInteractions(
                                              article.id,
                                              sharesDelta: 1,
                                            );
                                      },
                                    ),
                                    IconButton(
                                      alignment: Alignment.centerRight,
                                      icon: Icon(
                                        _bookmarkedArticleIds.contains(article.id)
                                            ? Icons.bookmark
                                            : Icons.bookmark_outline,
                                        size: 20,
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                      onPressed: () async {
                                        final prefs = await SharedPreferences.getInstance();
                                        final bookmarks = prefs.getStringList('bookmarked_articles') ?? [];
                                        final isBookmarked = _bookmarkedArticleIds.contains(article.id);

                                        int delta = 0;
                                        if (isBookmarked) {
                                          bookmarks.remove(article.id);
                                          delta = -1;
                                        } else {
                                          bookmarks.add(article.id);
                                          delta = 1;
                                        }

                                        await prefs.setStringList('bookmarked_articles', bookmarks);
                                        await DatabaseHelper.instance
                                            .updateArticleInteractions(
                                              article.id,
                                              bookmarksDelta: delta,
                                            );

                                        setState(() {
                                          if (isBookmarked) {
                                            _bookmarkedArticleIds.remove(article.id);
                                          } else {
                                            _bookmarkedArticleIds.add(article.id);
                                          }
                                        });

                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                isBookmarked
                                                    ? 'Artikel dihapus dari Bookmark'
                                                    : 'Artikel disimpan ke Bookmark',
                                              ),
                                              duration: const Duration(milliseconds: 1500),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
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
    );
  }
}
