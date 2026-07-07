import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:safenesia_1/features/article/models/article_model.dart';
import 'package:safenesia_1/features/training/models/training_model.dart';
import 'package:safenesia_1/features/training/models/training_schedule_model.dart';
import 'package:safenesia_1/features/certification/models/certification_model.dart';
import 'package:safenesia_1/features/career/models/career_model.dart';
import 'package:safenesia_1/features/notification/models/notification_model.dart';
import 'package:safenesia_1/features/regulation/models/regulation_model.dart';
import 'package:safenesia_1/features/inspection/models/inspection_model.dart';
import 'package:safenesia_1/features/auth/models/user_model.dart';
import 'package:safenesia_1/features/profile/models/transaction_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static const _databaseName = "safenesia.db";
  static const _databaseVersion = 18;

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
    if (oldVersion < 8) {
      await _createCertificationsTable(db);
      await _createCareersTable(db);
      await _createNotificationsTable(db);
      await _createRegulationsTable(db);
    }
    if (oldVersion < 9) {
      await _createUsersTable(db);
    }
    if (oldVersion < 10) {
      await db.execute('DROP TABLE IF EXISTS regulations');
      await _createRegulationsTable(db);
    }
    if (oldVersion < 11) {
      await _createInspectionsTable(db);
    }
    if (oldVersion < 12) {
      await db.execute('DROP TABLE IF EXISTS careers');
      await _createCareersTable(db);
    }
    if (oldVersion < 13) {
      await db.execute('DROP TABLE IF EXISTS training_schedules');
      await _createTrainingSchedulesTable(db);
    }
    if (oldVersion < 14) {
      await db.execute('DROP TABLE IF EXISTS certifications');
      await _createCertificationsTable(db);
    }
    if (oldVersion < 15) {
      await _createTransactionsTable(db);
    }
    if (oldVersion < 16) {
      await db.execute('DROP TABLE IF EXISTS certifications');
      await _createCertificationsTable(db);
    }
    if (oldVersion < 17) {
      await db.execute('DROP TABLE IF EXISTS certifications');
      await _createCertificationsTable(db);
    }
    if (oldVersion < 18) {
      await db.execute('DROP TABLE IF EXISTS certifications');
      await _createCertificationsTable(db);
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
    await _createCertificationsTable(db);
    await _createCareersTable(db);
    await _createNotificationsTable(db);
    await _createRegulationsTable(db);
    await _createInspectionsTable(db);
    await _createUsersTable(db);
    await _createTransactionsTable(db);
  }

  Future _createUsersTable(Database db) async {
    await db.execute('''
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  password TEXT NOT NULL,
  phoneNumber TEXT NOT NULL,
  role TEXT NOT NULL
)
''');

    // Insert default admin
    await db.insert('users', {
      'id': 'admin-1',
      'name': 'Administrator',
      'email': 'admin@gmail.com',
      'password': 'password123',
      'phoneNumber': '08123456789',
      'role': 'admin',
    });
  }

  Future _createCertificationsTable(Database db) async {
    await db.execute('''
CREATE TABLE certifications (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  category TEXT NOT NULL,
  level TEXT NOT NULL,
  basePrice INTEGER NOT NULL,
  bannerUrl TEXT
)
''');
    for (var cert in dummyCertifications) {
      await db.insert('certifications', cert.toMap());
    }
  }

  Future _createCareersTable(Database db) async {
    await db.execute('''
CREATE TABLE careers (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  company TEXT NOT NULL,
  field TEXT NOT NULL,
  location TEXT NOT NULL,
  jobType TEXT NOT NULL,
  experienceLevel TEXT NOT NULL,
  salaryMin INTEGER NOT NULL,
  salaryMax INTEGER NOT NULL,
  description TEXT NOT NULL,
  requirements TEXT NOT NULL,
  benefits TEXT NOT NULL,
  postedDate TEXT NOT NULL,
  companyLogoUrl TEXT NOT NULL,
  isSaved INTEGER NOT NULL,
  isApplied INTEGER NOT NULL
)
''');
    for (var career in dummyCareers) {
      await db.insert('careers', career.toMap());
    }
  }

  Future _createNotificationsTable(Database db) async {
    await db.execute('''
CREATE TABLE notifications (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  subtitle TEXT NOT NULL,
  type TEXT NOT NULL
)
''');
    for (var notif in dummyNotifications) {
      await db.insert('notifications', notif.toMap());
    }
  }

  Future _createRegulationsTable(Database db) async {
    await db.execute('''
CREATE TABLE regulations (
  id TEXT PRIMARY KEY,
  category TEXT NOT NULL,
  title TEXT NOT NULL,
  nomor TEXT NOT NULL,
  tahun TEXT NOT NULL,
  deskripsi TEXT NOT NULL,
  fileUrl TEXT NOT NULL,
  isSaved INTEGER NOT NULL
)
''');
    for (var reg in dummyRegulations) {
      await db.insert('regulations', reg.toMap());
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
    await db.insert('training_schedules', {
      'idJadwal': 's4',
      'idPelatihan': '2', // Auditor SMK3
      'tanggalStart': DateTime(now.year, now.month + 1, 10).toIso8601String(),
      'tanggalEnd': DateTime(now.year, now.month + 1, 15).toIso8601String(),
      'gambar': '',
    });
    await db.insert('training_schedules', {
      'idJadwal': 's5',
      'idPelatihan': '3', // Petugas P3K
      'tanggalStart': DateTime(now.year, now.month + 2, 20).toIso8601String(),
      'tanggalEnd': DateTime(now.year, now.month + 2, 22).toIso8601String(),
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

  // ================= CERTIFICATION METHODS =================
  Future<CertModel> createCertification(CertModel cert) async {
    final db = await instance.database;
    await db.insert('certifications', cert.toMap());
    return cert;
  }

  Future<List<CertModel>> readAllCertifications() async {
    final db = await instance.database;
    final result = await db.query('certifications');
    return result.map((json) => CertModel.fromMap(json)).toList();
  }

  Future<int> updateCertification(CertModel cert) async {
    final db = await instance.database;
    return db.update(
      'certifications',
      cert.toMap(),
      where: 'id = ?',
      whereArgs: [cert.id],
    );
  }

  Future<int> deleteCertification(String id) async {
    final db = await instance.database;
    return await db.delete('certifications', where: 'id = ?', whereArgs: [id]);
  }

  // ================= CAREER METHODS =================
  Future<CareerModel> createCareer(CareerModel career) async {
    final db = await instance.database;
    await db.insert('careers', career.toMap());
    return career;
  }

  Future<List<CareerModel>> readAllCareers() async {
    final db = await instance.database;
    final result = await db.query('careers');
    return result.map((json) => CareerModel.fromMap(json)).toList();
  }

  Future<int> updateCareer(CareerModel career) async {
    final db = await instance.database;
    return db.update(
      'careers',
      career.toMap(),
      where: 'id = ?',
      whereArgs: [career.id],
    );
  }

  Future<int> deleteCareer(String id) async {
    final db = await instance.database;
    return await db.delete('careers', where: 'id = ?', whereArgs: [id]);
  }

  // ================= NOTIFICATION METHODS =================
  Future<NotificationModel> createNotification(
    NotificationModel notification,
  ) async {
    final db = await instance.database;
    await db.insert('notifications', notification.toMap());
    return notification;
  }

  Future<List<NotificationModel>> readAllNotifications() async {
    final db = await instance.database;
    final result = await db.query('notifications');
    return result.map((json) => NotificationModel.fromMap(json)).toList();
  }

  Future<int> updateNotification(NotificationModel notification) async {
    final db = await instance.database;
    return db.update(
      'notifications',
      notification.toMap(),
      where: 'id = ?',
      whereArgs: [notification.id],
    );
  }

  Future<int> deleteNotification(String id) async {
    final db = await instance.database;
    return await db.delete('notifications', where: 'id = ?', whereArgs: [id]);
  }

  // ================= REGULATION METHODS =================
  Future<RegulationModel> createRegulation(RegulationModel regulation) async {
    final db = await instance.database;
    await db.insert('regulations', regulation.toMap());
    return regulation;
  }

  Future<List<RegulationModel>> readAllRegulations() async {
    final db = await instance.database;
    final result = await db.query('regulations');
    return result.map((json) => RegulationModel.fromMap(json)).toList();
  }

  Future<int> updateRegulation(RegulationModel regulation) async {
    final db = await instance.database;
    return db.update(
      'regulations',
      regulation.toMap(),
      where: 'id = ?',
      whereArgs: [regulation.id],
    );
  }

  Future<int> deleteRegulation(String id) async {
    final db = await instance.database;
    return await db.delete('regulations', where: 'id = ?', whereArgs: [id]);
  }

  // ================= USER METHODS =================
  Future<UserModel> createUser(UserModel user) async {
    final db = await instance.database;
    await db.insert('users', user.toMap());
    return user;
  }

  Future<List<UserModel>> readAllUsers() async {
    final db = await instance.database;
    final result = await db.query('users');
    return result.map((json) => UserModel.fromMap(json)).toList();
  }

  Future<int> updateUser(UserModel user) async {
    final db = await instance.database;
    return db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(String id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // ================= INSPECTION METHODS =================
  Future _createInspectionsTable(Database db) async {
    await db.execute('''
CREATE TABLE inspections (
  id TEXT PRIMARY KEY,
  companyName TEXT NOT NULL,
  equipmentType TEXT NOT NULL,
  location TEXT NOT NULL,
  scheduledDate TEXT NOT NULL,
  notes TEXT NOT NULL,
  status TEXT NOT NULL
)
''');
    for (var ins in dummyInspections) {
      await db.insert('inspections', ins.toMap());
    }
  }

  Future<InspectionModel> createInspection(InspectionModel inspection) async {
    final db = await instance.database;
    await db.insert('inspections', inspection.toMap());
    return inspection;
  }

  Future<List<InspectionModel>> readAllInspections() async {
    final db = await instance.database;
    final result = await db.query('inspections', orderBy: 'ROWID DESC');
    return result.map((json) => InspectionModel.fromMap(json)).toList();
  }

  Future<int> updateInspection(InspectionModel inspection) async {
    final db = await instance.database;
    return db.update(
      'inspections',
      inspection.toMap(),
      where: 'id = ?',
      whereArgs: [inspection.id],
    );
  }

  Future<int> deleteInspection(String id) async {
    final db = await instance.database;
    return await db.delete('inspections', where: 'id = ?', whereArgs: [id]);
  }

  // ================= TRANSACTION METHODS =================
  Future _createTransactionsTable(Database db) async {
    await db.execute('''
CREATE TABLE transactions (
  id TEXT PRIMARY KEY,
  layanan TEXT NOT NULL,
  judul TEXT NOT NULL,
  status TEXT NOT NULL,
  tanggal TEXT NOT NULL,
  totalBayar INTEGER
)
''');
    // Add dummy transactions to match the original static data
    await db.insert('transactions', {
      'id': 'trx_1',
      'layanan': 'Pelatihan',
      'judul': 'Ahli K3 Umum',
      'status': 'Selesai',
      'tanggal': '12 Jan 2026',
    });
    await db.insert('transactions', {
      'id': 'trx_2',
      'layanan': 'Sertifikasi',
      'judul': 'ISO 9001:2015',
      'status': 'Proses',
      'tanggal': '05 Feb 2026',
    });
    await db.insert('transactions', {
      'id': 'trx_3',
      'layanan': 'Riksa Uji',
      'judul': 'Riksa Uji Crane',
      'status': 'Selesai',
      'tanggal': '20 Mar 2026',
    });
  }

  Future<TransactionModel> createTransaction(
    TransactionModel transaction,
  ) async {
    final db = await instance.database;
    await db.insert('transactions', transaction.toMap());
    return transaction;
  }

  Future<List<TransactionModel>> readAllTransactions() async {
    final db = await instance.database;
    final result = await db.query('transactions', orderBy: 'ROWID DESC');
    return result.map((json) => TransactionModel.fromMap(json)).toList();
  }

  Future<int> updateTransaction(TransactionModel transaction) async {
    final db = await instance.database;
    return db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction(String id) async {
    final db = await instance.database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
