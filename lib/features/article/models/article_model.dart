class ArticleModel {
  final String id;

  // Basic Information
  final String title;
  final String slug;
  final String summary;
  final String content;

  // Media
  final String thumbnail;
  final List<String> images;

  // Relationship
  final String categoryId;
  final String authorId;

  // Metadata
  final List<String> tags;
  final int readingTime;

  // Statistics
  final int likes;
  final int bookmarks;
  final int shares;

  // Status
  final bool isFeatured;
  final bool isPublished;

  // Source
  final String source;
  final String sourceUrl;

  // Timestamp
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? publishedAt;

  const ArticleModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.summary,
    required this.content,
    required this.thumbnail,
    required this.images,
    required this.categoryId,
    required this.authorId,
    required this.tags,
    required this.readingTime,
    required this.likes,
    required this.bookmarks,
    required this.shares,
    required this.isFeatured,
    required this.isPublished,
    required this.source,
    required this.sourceUrl,
    required this.createdAt,
    required this.updatedAt,
    this.publishedAt,
  });

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'],
      title: map['title'],
      slug: map['slug'],
      summary: map['summary'],
      content: map['content'],
      thumbnail: map['thumbnail'],
      images: List<String>.from(map['images'] ?? []),
      categoryId: map['category_id'],
      authorId: map['author_id'],
      tags: List<String>.from(map['tags'] ?? []),
      readingTime: map['reading_time'],
      likes: map['likes'],
      bookmarks: map['bookmarks'],
      shares: map['shares'],
      isFeatured: map['is_featured'] == 1 || map['is_featured'] == true,
      isPublished: map['is_published'] == 1 || map['is_published'] == true,
      source: map['source'],
      sourceUrl: map['source_url'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      publishedAt: map['published_at'] != null
          ? DateTime.parse(map['published_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'summary': summary,
      'content': content,
      'thumbnail': thumbnail,
      'images': images,
      'category_id': categoryId,
      'author_id': authorId,
      'tags': tags,
      'reading_time': readingTime,
      'likes': likes,
      'bookmarks': bookmarks,
      'shares': shares,
      'is_featured': isFeatured ? 1 : 0,
      'is_published': isPublished ? 1 : 0,
      'source': source,
      'source_url': sourceUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'published_at': publishedAt?.toIso8601String(),
    };
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      ArticleModel.fromMap(json);

  Map<String, dynamic> toJson() => toMap();

  ArticleModel copyWith({
    String? id,
    String? title,
    String? slug,
    String? summary,
    String? content,
    String? thumbnail,
    List<String>? images,
    String? categoryId,
    String? authorId,
    List<String>? tags,
    int? readingTime,
    int? likes,
    int? bookmarks,
    int? shares,
    bool? isFeatured,
    bool? isPublished,
    String? source,
    String? sourceUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      summary: summary ?? this.summary,
      content: content ?? this.content,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      categoryId: categoryId ?? this.categoryId,
      authorId: authorId ?? this.authorId,
      tags: tags ?? this.tags,
      readingTime: readingTime ?? this.readingTime,
      likes: likes ?? this.likes,
      bookmarks: bookmarks ?? this.bookmarks,
      shares: shares ?? this.shares,
      isFeatured: isFeatured ?? this.isFeatured,
      isPublished: isPublished ?? this.isPublished,
      source: source ?? this.source,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }
}

// Dummy Data
final List<ArticleModel> dummyArticles = [
  ArticleModel(
    id: '1',
    title: 'Pentingnya APD di Sektor Konstruksi',
    slug: 'pentingnya-apd-di-sektor-konstruksi',
    summary: 'Alat Pelindung Diri (APD) sangat penting untuk mencegah terjadinya kecelakaan kerja.',
    content: 'Alat Pelindung Diri (APD) sangat penting untuk mencegah terjadinya kecelakaan kerja, terutama di sektor konstruksi. Penggunaan helm, sepatu safety, dan rompi reflektif harus menjadi standar wajib di setiap proyek.\n\nSelain itu, para pekerja juga harus diberikan pelatihan berkala mengenai cara pemakaian APD yang benar dan tepat sasaran. Kelalaian kecil dalam penggunaan APD bisa berdampak fatal pada keselamatan jiwa.',
    thumbnail: 'https://picsum.photos/seed/k3_1/400/200',
    images: [],
    categoryId: 'Konstruksi',
    authorId: 'admin1',
    tags: ['APD', 'Konstruksi', 'Safety'],
    readingTime: 3,
    likes: 120,
    bookmarks: 45,
    shares: 10,
    isFeatured: true,
    isPublished: true,
    source: 'Safety Magazine',
    sourceUrl: 'https://example.com',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    publishedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  ArticleModel(
    id: '2',
    title: 'Prosedur Evakuasi Kebakaran Gedung',
    slug: 'prosedur-evakuasi-kebakaran-gedung',
    summary: 'Saat terjadi kebakaran, hal yang paling utama adalah tetap tenang dan tidak panik.',
    content: 'Saat terjadi kebakaran, hal yang paling utama adalah tetap tenang dan tidak panik. Segera ikuti petunjuk arah evakuasi yang menempel di dinding dan berjalanlah dengan cepat (jangan berlari).\n\nDilarang keras menggunakan lift saat evakuasi. Gunakan selalu tangga darurat. Setelah keluar dari gedung, segera menuju titik kumpul (assembly point) dan jangan kembali ke dalam gedung sampai ada instruksi aman dari petugas.',
    thumbnail: 'https://picsum.photos/seed/k3_2/400/200',
    images: [],
    categoryId: 'Umum',
    authorId: 'admin2',
    tags: ['Kebakaran', 'Evakuasi'],
    readingTime: 5,
    likes: 85,
    bookmarks: 20,
    shares: 5,
    isFeatured: false,
    isPublished: true,
    source: 'Damkar Indonesia',
    sourceUrl: 'https://example.com',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    publishedAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
];

final List<String> articleCategories = [
  'Semua',
  'Umum',
  'Listrik',
  'Konstruksi',
  'Tambang',
  'Rumah Sakit',
  'Oil & Gas',
  'Manufaktur',
];
