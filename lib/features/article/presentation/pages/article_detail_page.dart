import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:share_plus/share_plus.dart';

class ArticleDetailPage extends StatefulWidget {
  final ArticleModel article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  bool _isBookmarked = false;
  bool _isLiked = false;
  late int _likesCount;
  late int _sharesCount;
  late int _bookmarksCount;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.article.likes;
    _sharesCount = widget.article.shares;
    _bookmarksCount = widget.article.bookmarks;
    _checkInteractionStatus();
  }

  Future<void> _checkInteractionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarked_articles') ?? [];
    final likes = prefs.getStringList('liked_articles') ?? [];
    setState(() {
      _isBookmarked = bookmarks.contains(widget.article.id);
      _isLiked = likes.contains(widget.article.id);
    });
  }

  Future<void> _toggleBookmark() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = prefs.getStringList('bookmarked_articles') ?? [];

    int delta = 0;
    if (_isBookmarked) {
      bookmarks.remove(widget.article.id);
      delta = -1;
    } else {
      bookmarks.add(widget.article.id);
      delta = 1;
    }

    await prefs.setStringList('bookmarked_articles', bookmarks);
    await DatabaseHelper.instance.updateArticleInteractions(widget.article.id, bookmarksDelta: delta);

    setState(() {
      _isBookmarked = !_isBookmarked;
      _bookmarksCount += delta;
      if (_bookmarksCount < 0) _bookmarksCount = 0;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isBookmarked
                ? 'Artikel disimpan ke Bookmark'
                : 'Artikel dihapus dari Bookmark',
          ),
          duration: const Duration(milliseconds: 1500),
        ),
      );
    }
  }

  Future<void> _toggleLike() async {
    final prefs = await SharedPreferences.getInstance();
    final likes = prefs.getStringList('liked_articles') ?? [];

    int delta = 0;
    if (_isLiked) {
      likes.remove(widget.article.id);
      delta = -1;
    } else {
      likes.add(widget.article.id);
      delta = 1;
    }

    await prefs.setStringList('liked_articles', likes);
    await DatabaseHelper.instance.updateArticleInteractions(widget.article.id, likesDelta: delta);

    setState(() {
      _isLiked = !_isLiked;
      _likesCount += delta;
      if (_likesCount < 0) _likesCount = 0;
    });
  }

  Future<void> _shareArticle() async {
    // ignore: deprecated_member_use
    await Share.share('${widget.article.title}\n\nBaca selengkapnya di: ${widget.article.sourceUrl}');
    await DatabaseHelper.instance.updateArticleInteractions(widget.article.id, sharesDelta: 1);
    setState(() {
      _sharesCount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withValues(alpha: 0.3),
                foregroundColor: Colors.white,
              ),
            ),
            actions: const [],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'article_image_\${widget.article.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      widget.article.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.image,
                            size: 100,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                    // Gradient to make the back button and text readable
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.7),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 24.0,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.article.categoryId,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
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
                            "${widget.article.createdAt.day}/${widget.article.createdAt.month}/${widget.article.createdAt.year}",
                            style: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "${widget.article.readingTime} min",
                            style: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    widget.article.title,
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onSurface,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: theme.colorScheme.outlineVariant),
                  const SizedBox(height: 24),
                  if (widget.article.summary.isNotEmpty) ...[
                    Text(
                      widget.article.summary,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                        color: theme.colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  Text(
                    widget.article.content,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      height: 1.8,
                      color: theme.colorScheme.onSurface,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (widget.article.tags.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.article.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '#$tag',
                            style: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 60), // Bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: theme.brightness == Brightness.dark ? Colors.transparent : Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInteractionButton(
                icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                color: _isLiked ? Colors.red : theme.colorScheme.onSurfaceVariant,
                label: '$_likesCount',
                onTap: _toggleLike,
              ),
              _buildInteractionButton(
                icon: Icons.share_outlined,
                color: theme.colorScheme.onSurfaceVariant,
                label: '$_sharesCount',
                onTap: _shareArticle,
              ),
              _buildInteractionButton(
                icon: _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                color: _isBookmarked ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                label: '$_bookmarksCount',
                onTap: _toggleBookmark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
