import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';
import 'package:safenesia_1/features/admin/presentation/pages/admin_article_form_page.dart';

class AdminArticleListPage extends StatefulWidget {
  const AdminArticleListPage({super.key});

  @override
  State<AdminArticleListPage> createState() => _AdminArticleListPageState();
}

class _AdminArticleListPageState extends State<AdminArticleListPage> {
  List<Article> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshArticles();
  }

  Future refreshArticles() async {
    setState(() => isLoading = true);
    articles = await DatabaseHelper.instance.readAllArticles();
    setState(() => isLoading = false);
  }

  Future deleteArticle(String id) async {
    await DatabaseHelper.instance.delete(id);
    refreshArticles();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text('Article deleted'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Articles'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : articles.isEmpty
          ? const Center(child: Text('No Articles found'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.article, color: Colors.blue),
                    title: Text(article.title),
                    subtitle: Text(article.category),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminArticleFormPage(article: article),
                              ),
                            );
                            refreshArticles();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Article'),
                                content: const Text(
                                  'Are you sure you want to delete this article?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      deleteArticle(article.id);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminArticleFormPage(),
            ),
          );
          refreshArticles();
        },
      ),
    );
  }
}
