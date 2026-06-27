import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';
import 'package:safenesia_1/features/training/models/training_model.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static const _databaseName = "safenesia.db";
  static const _databaseVersion = 7;

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createTrainingsTable(db);
    }
    if (oldVersion < 3) {
      // Recreate trainings without dates, add training_schedules
      await db.execute('DROP TABLE IF EXISTS trainings');
      await _createTrainingsTable(db);
      await _createTrainingSchedulesTable(db);
    }
    if (oldVersion < 4) {
      // Handle dummy data IDs change
      await db.execute('DROP TABLE IF EXISTS training_schedules');
      await db.execute('DROP TABLE IF EXISTS trainings');
      await _createTrainingsTable(db);
      await _createTrainingSchedulesTable(db);
    }
    if (oldVersion < 5) {
      await db.execute('DROP TABLE IF EXISTS training_schedules');
      await _createTrainingSchedulesTable(db);
    }
    if (oldVersion < 7) {
      await db.execute('DROP TABLE IF EXISTS training_schedules');
      await db.execute('DROP TABLE IF EXISTS trainings');
      await _createTrainingsTable(db);
      await _createTrainingSchedulesTable(db);
    }
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE articles (
  id $idType,
  title $textType,
  category $textType,
  date $textType,
  imageUrl $textType,
  content $textType
)
''');

    await _createTrainingsTable(db);
    await _createTrainingSchedulesTable(db);

    // Prepopulate with dummy data
    for (var article in dummyArticles) {
      await db.insert('articles', article.toMap());
    }
  }

  Future _createTrainingsTable(Database db) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE trainings (
  idPelatihan $idType,
  kodeBidang $textType,
  bidang $textType,
  namaPelatihan $textType,
  namaPelatihanKapital $textType,
  kodePelatihan $textType,
  durasi $textType,
  hargaPromo $intType,
  hargaNormal $intType,
  sertifikasi $textType,
  status $textType,
  deskripsi $textType,
  dasarHukum $textType,
  tujuan $textType,
  materi $textType,
  syaratAdministrasi $textType,
  fasilitas $textType,
  metode $textType,
  detailMetode $textType,
  syaratKetentuan $textType,
  instruktur $textType,
  keterangan $textType,
  gambarPelatihan $textType,
  namaLokasi TEXT,
  linkPetaLokasi TEXT
)
''');

    for (var training in getDummyTrainings()) {
      await db.insert('trainings', training.toMap());
    }
  }

  Future _createTrainingSchedulesTable(Database db) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE training_schedules (
  idJadwal $idType,
  idPelatihan $textType,
  tanggalStart $textType,
  tanggalEnd $textType,
  gambar $textType,
  namaLokasi TEXT,
  linkPetaLokasi TEXT,
  FOREIGN KEY (idPelatihan) REFERENCES trainings (idPelatihan) ON DELETE CASCADE
)
''');

    // Add dummy schedules for the dummy trainings
    final now = DateTime.now();
    await db.insert('training_schedules', {
      'idJadwal': 's1',
      'idPelatihan': '1', // Ahli K3 Umum Online
      'tanggalStart': DateTime(now.year, now.month, 12).toIso8601String(),
      'tanggalEnd': DateTime(now.year, now.month, 24).toIso8601String(),
      'gambar': '',
    });
    await db.insert('training_schedules', {
      'idJadwal': 's2',
      'idPelatihan': '5', // PMK Kelas D
      'tanggalStart': DateTime(now.year, now.month + 1, 18).toIso8601String(),
      'tanggalEnd': DateTime(now.year, now.month + 1, 21).toIso8601String(),
      'gambar': '',
    });
    await db.insert('training_schedules', {
      'idJadwal': 's3',
      'idPelatihan': '6', // K3 EE
      'tanggalStart': DateTime(now.year, now.month + 2, 5).toIso8601String(),
      'tanggalEnd': DateTime(now.year, now.month + 2, 17).toIso8601String(),
      'gambar': '',
    });
  }

  // ================= ARTICLE METHODS =================

  Future<Article> create(Article article) async {
    final db = await instance.database;
    await db.insert('articles', article.toMap());
    return article;
  }

  Future<Article?> readArticle(String id) async {
    final db = await instance.database;
    final maps = await db.query('articles', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Article.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Article>> readAllArticles() async {
    final db = await instance.database;
    const orderBy = 'date DESC';
    final result = await db.query('articles', orderBy: orderBy);
    return result.map((json) => Article.fromMap(json)).toList();
  }

  Future<int> update(Article article) async {
    final db = await instance.database;
    return db.update(
      'articles',
      article.toMap(),
      where: 'id = ?',
      whereArgs: [article.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await instance.database;
    return await db.delete('articles', where: 'id = ?', whereArgs: [id]);
  }

  // ================= TRAINING METHODS =================

  Future<Training> createTraining(Training training) async {
    final db = await instance.database;
    await db.insert('trainings', training.toMap());
    return training;
  }

  Future<Training?> readTraining(String id) async {
    final db = await instance.database;
    final maps = await db.query(
      'trainings',
      where: 'idPelatihan = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Training.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Training>> readAllTrainings() async {
    final db = await instance.database;
    const orderBy = 'ROWID DESC';
    final result = await db.query('trainings', orderBy: orderBy);
    return result.map((json) => Training.fromMap(json)).toList();
  }

  Future<int> updateTraining(Training training) async {
    final db = await instance.database;
    return db.update(
      'trainings',
      training.toMap(),
      where: 'idPelatihan = ?',
      whereArgs: [training.idPelatihan],
    );
  }

  Future<int> deleteTraining(String id) async {
    final db = await instance.database;
    // Also delete associated schedules
    await db.delete(
      'training_schedules',
      where: 'idPelatihan = ?',
      whereArgs: [id],
    );
    return await db.delete(
      'trainings',
      where: 'idPelatihan = ?',
      whereArgs: [id],
    );
  }

  // ================= TRAINING SCHEDULE METHODS =================

  Future<TrainingSchedule> createSchedule(TrainingSchedule schedule) async {
    final db = await instance.database;
    await db.insert('training_schedules', schedule.toMap());
    return schedule;
  }

  Future<int> updateSchedule(TrainingSchedule schedule) async {
    final db = await instance.database;
    return db.update(
      'training_schedules',
      schedule.toMap(),
      where: 'idJadwal = ?',
      whereArgs: [schedule.idJadwal],
    );
  }

  Future<int> deleteSchedule(String id) async {
    final db = await instance.database;
    return await db.delete(
      'training_schedules',
      where: 'idJadwal = ?',
      whereArgs: [id],
    );
  }

  Future<List<TrainingSchedule>> readAllSchedulesWithTraining() async {
    final db = await instance.database;

    // Perform SQL JOIN to get Schedule + Training details
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT s.*, t.* 
      FROM training_schedules s
      INNER JOIN trainings t ON s.idPelatihan = t.idPelatihan
      ORDER BY s.ROWID DESC
    ''');

    return result.map((row) {
      // Create Training object from the joined row
      final training = Training.fromMap(row);
      // Create TrainingSchedule object with the embedded Training
      return TrainingSchedule.fromMap(row, trainingData: training);
    }).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
