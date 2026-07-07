import 'package:flutter/material.dart';
import 'package:safenesia_1/core/database/database_helper.dart';
import 'package:safenesia_1/features/career/models/career_model.dart';

class AdminCareerFormPage extends StatefulWidget {
  final CareerModel? career;
  const AdminCareerFormPage({super.key, this.career});

  @override
  State<AdminCareerFormPage> createState() => _AdminCareerFormPageState();
}

class _AdminCareerFormPageState extends State<AdminCareerFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleCtrl;
  late TextEditingController _slugCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _reqCtrl;
  late TextEditingController _respCtrl;
  late TextEditingController _benCtrl;
  late TextEditingController _compNameCtrl;
  late TextEditingController _compLogoCtrl;
  late TextEditingController _empTypeCtrl;
  late TextEditingController _workTypeCtrl;
  late TextEditingController _levelCtrl;
  late TextEditingController _provCtrl;
  late TextEditingController _cityCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _salMinCtrl;
  late TextEditingController _salMaxCtrl;
  late TextEditingController _salPeriodCtrl;
  late TextEditingController _eduCtrl;
  late TextEditingController _minExpCtrl;
  late TextEditingController _skillsCtrl;
  late TextEditingController _certsCtrl;
  late TextEditingController _applyUrlCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;

  bool _salaryVisible = true;
  bool _isFeatured = false;
  bool _isUrgent = false;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    final c = widget.career;
    
    _titleCtrl = TextEditingController(text: c?.title ?? '');
    _slugCtrl = TextEditingController(text: c?.slug ?? '');
    _descCtrl = TextEditingController(text: c?.description ?? '');
    _reqCtrl = TextEditingController(text: c?.requirements ?? '');
    _respCtrl = TextEditingController(text: c?.responsibilities ?? '');
    _benCtrl = TextEditingController(text: c?.benefits ?? '');
    _compNameCtrl = TextEditingController(text: c?.companyName ?? '');
    _compLogoCtrl = TextEditingController(text: c?.companyLogo ?? '');
    _empTypeCtrl = TextEditingController(text: c?.employmentType ?? '');
    _workTypeCtrl = TextEditingController(text: c?.workplaceType ?? '');
    _levelCtrl = TextEditingController(text: c?.level ?? '');
    _provCtrl = TextEditingController(text: c?.province ?? '');
    _cityCtrl = TextEditingController(text: c?.city ?? '');
    _addressCtrl = TextEditingController(text: c?.address ?? '');
    _salMinCtrl = TextEditingController(text: c?.salaryMin?.toString() ?? '');
    _salMaxCtrl = TextEditingController(text: c?.salaryMax?.toString() ?? '');
    _salPeriodCtrl = TextEditingController(text: c?.salaryPeriod ?? 'Bulan');
    _eduCtrl = TextEditingController(text: c?.education ?? '');
    _minExpCtrl = TextEditingController(text: c?.minimumExperience.toString() ?? '0');
    _skillsCtrl = TextEditingController(text: c?.skills.join(', ') ?? '');
    _certsCtrl = TextEditingController(text: c?.certificates.join(', ') ?? '');
    _applyUrlCtrl = TextEditingController(text: c?.applyUrl ?? '');
    _emailCtrl = TextEditingController(text: c?.email ?? '');
    _phoneCtrl = TextEditingController(text: c?.phone ?? '');

    if (c != null) {
      _salaryVisible = c.salaryVisible;
      _isFeatured = c.isFeatured;
      _isUrgent = c.isUrgent;
      _isActive = c.isActive;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _slugCtrl.dispose();
    _descCtrl.dispose();
    _reqCtrl.dispose();
    _respCtrl.dispose();
    _benCtrl.dispose();
    _compNameCtrl.dispose();
    _compLogoCtrl.dispose();
    _empTypeCtrl.dispose();
    _workTypeCtrl.dispose();
    _levelCtrl.dispose();
    _provCtrl.dispose();
    _cityCtrl.dispose();
    _addressCtrl.dispose();
    _salMinCtrl.dispose();
    _salMaxCtrl.dispose();
    _salPeriodCtrl.dispose();
    _eduCtrl.dispose();
    _minExpCtrl.dispose();
    _skillsCtrl.dispose();
    _certsCtrl.dispose();
    _applyUrlCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final id = widget.career?.id ?? DateTime.now().millisecondsSinceEpoch.toString();
    
    final List<String> skillsList = _skillsCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
        
    final List<String> certsList = _certsCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final career = CareerModel(
      id: id,
      title: _titleCtrl.text,
      slug: _slugCtrl.text.isEmpty ? _titleCtrl.text.toLowerCase().replaceAll(' ', '-') : _slugCtrl.text,
      description: _descCtrl.text,
      requirements: _reqCtrl.text,
      responsibilities: _respCtrl.text,
      benefits: _benCtrl.text,
      companyId: widget.career?.companyId ?? 'comp_$id',
      companyName: _compNameCtrl.text,
      companyLogo: _compLogoCtrl.text,
      employmentType: _empTypeCtrl.text,
      workplaceType: _workTypeCtrl.text,
      level: _levelCtrl.text,
      province: _provCtrl.text,
      city: _cityCtrl.text,
      address: _addressCtrl.text,
      salaryVisible: _salaryVisible,
      salaryMin: double.tryParse(_salMinCtrl.text),
      salaryMax: double.tryParse(_salMaxCtrl.text),
      salaryPeriod: _salPeriodCtrl.text,
      education: _eduCtrl.text,
      minimumExperience: int.tryParse(_minExpCtrl.text) ?? 0,
      skills: skillsList,
      certificates: certsList,
      applyUrl: _applyUrlCtrl.text,
      email: _emailCtrl.text,
      phone: _phoneCtrl.text,
      applicants: widget.career?.applicants ?? 0,
      bookmarks: widget.career?.bookmarks ?? 0,
      shares: widget.career?.shares ?? 0,
      isFeatured: _isFeatured,
      isUrgent: _isUrgent,
      isActive: _isActive,
      postedAt: widget.career?.postedAt ?? DateTime.now(),
      expiredAt: widget.career?.expiredAt ?? DateTime.now().add(const Duration(days: 30)),
      createdAt: widget.career?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (widget.career == null) {
      await DatabaseHelper.instance.createCareer(career);
    } else {
      await DatabaseHelper.instance.updateCareer(career);
    }

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.career == null ? 'Tambah Karir' : 'Edit Karir'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Informasi Dasar'),
              _buildTextField(_titleCtrl, 'Judul Lowongan', true),
              _buildTextField(_slugCtrl, 'Slug (Opsional)', false),
              _buildTextField(_descCtrl, 'Deskripsi', true, maxLines: 4),
              _buildTextField(_reqCtrl, 'Persyaratan', true, maxLines: 3),
              _buildTextField(_respCtrl, 'Tanggung Jawab', true, maxLines: 3),
              _buildTextField(_benCtrl, 'Keuntungan / Benefit', true, maxLines: 3),
              
              const SizedBox(height: 16),
              _buildSectionTitle('Informasi Perusahaan'),
              _buildTextField(_compNameCtrl, 'Nama Perusahaan', true),
              _buildTextField(_compLogoCtrl, 'URL Logo Perusahaan', false),
              
              const SizedBox(height: 16),
              _buildSectionTitle('Tipe & Lokasi Pekerjaan'),
              _buildTextField(_empTypeCtrl, 'Tipe Pekerjaan (Full-time, Contract, dll)', true),
              _buildTextField(_workTypeCtrl, 'Lokasi Kerja (On-site, Remote, Hybrid)', true),
              _buildTextField(_levelCtrl, 'Tingkat Pekerjaan (Entry, Middle, Senior)', true),
              _buildTextField(_provCtrl, 'Provinsi', true),
              _buildTextField(_cityCtrl, 'Kota/Kabupaten', true),
              _buildTextField(_addressCtrl, 'Alamat Lengkap', true, maxLines: 2),

              const SizedBox(height: 16),
              _buildSectionTitle('Gaji (Rp)'),
              SwitchListTile(
                title: const Text('Tampilkan Gaji ke Pengguna'),
                value: _salaryVisible,
                onChanged: (v) => setState(() => _salaryVisible = v),
              ),
              Row(
                children: [
                  Expanded(child: _buildTextField(_salMinCtrl, 'Gaji Minimal', false, isNumber: true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(_salMaxCtrl, 'Gaji Maksimal', false, isNumber: true)),
                ],
              ),
              _buildTextField(_salPeriodCtrl, 'Periode Gaji (cth: Bulan, Tahun)', true),

              const SizedBox(height: 16),
              _buildSectionTitle('Kualifikasi & Keahlian'),
              _buildTextField(_eduCtrl, 'Minimal Pendidikan', true),
              _buildTextField(_minExpCtrl, 'Minimal Pengalaman (Tahun)', true, isNumber: true),
              _buildTextField(_skillsCtrl, 'Keahlian (pisahkan dengan koma)', false, maxLines: 2),
              _buildTextField(_certsCtrl, 'Sertifikat (pisahkan dengan koma)', false, maxLines: 2),

              const SizedBox(height: 16),
              _buildSectionTitle('Kontak & Pendaftaran'),
              _buildTextField(_applyUrlCtrl, 'URL Pendaftaran (Web External)', false),
              _buildTextField(_emailCtrl, 'Email HR/Perusahaan', false),
              _buildTextField(_phoneCtrl, 'No Telepon', false),

              const SizedBox(height: 16),
              _buildSectionTitle('Status & Lainnya'),
              SwitchListTile(
                title: const Text('Aktif (Ditampilkan di aplikasi)'),
                value: _isActive,
                onChanged: (v) => setState(() => _isActive = v),
              ),
              SwitchListTile(
                title: const Text('Disorot (Featured)'),
                value: _isFeatured,
                onChanged: (v) => setState(() => _isFeatured = v),
              ),
              SwitchListTile(
                title: const Text('Mendesak (Urgent)'),
                value: _isUrgent,
                onChanged: (v) => setState(() => _isUrgent = v),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    bool required, {
    int maxLines = 1,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
        validator: required
            ? (v) => v == null || v.isEmpty ? 'Wajib diisi' : null
            : null,
      ),
    );
  }
}
