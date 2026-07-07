class TrainingLocation {
  final int id;
  final String namaLokasi;
  final String alamat;
  final String kelurahan;
  final String kecamatan;
  final String kotaKabupaten;
  final String provinsi;
  final String kodePos;
  final String lokasi;
  final String petaLokasi;
  final String qrCodeLokasi;

  TrainingLocation({
    required this.id,
    required this.namaLokasi,
    required this.alamat,
    required this.kelurahan,
    required this.kecamatan,
    required this.kotaKabupaten,
    required this.provinsi,
    required this.kodePos,
    required this.lokasi,
    required this.petaLokasi,
    required this.qrCodeLokasi,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namaLokasi': namaLokasi,
      'alamat': alamat,
      'kelurahan': kelurahan,
      'kecamatan': kecamatan,
      'kotaKabupaten': kotaKabupaten,
      'provinsi': provinsi,
      'kodePos': kodePos,
      'lokasi': lokasi,
      'petaLokasi': petaLokasi,
      'qrCodeLokasi': qrCodeLokasi,
    };
  }

  factory TrainingLocation.fromMap(Map<String, dynamic> map) {
    return TrainingLocation(
      id: map['id']?.toInt() ?? 0,
      namaLokasi: map['namaLokasi'] ?? '',
      alamat: map['alamat'] ?? '',
      kelurahan: map['kelurahan'] ?? '',
      kecamatan: map['kecamatan'] ?? '',
      kotaKabupaten: map['kotaKabupaten'] ?? '',
      provinsi: map['provinsi'] ?? '',
      kodePos: map['kodePos'] ?? '',
      lokasi: map['lokasi'] ?? '',
      petaLokasi: map['petaLokasi'] ?? '',
      qrCodeLokasi: map['qrCodeLokasi'] ?? '',
    );
  }

  static List<TrainingLocation> dummyLocations = [
    TrainingLocation(
      id: 1,
      namaLokasi: 'Midiatama Academy',
      alamat:
          'Wisma Presisi Lantai 1 No.4B, Jl. Taman Aries, RT.005/RW.002 Meruya Utara, Kembangan, Jakarta Barat, DKI Jakarta 11620',
      kelurahan: 'Meruya',
      kecamatan: 'Kembangan',
      kotaKabupaten: 'Jakarta Barat',
      provinsi: 'DKI Jakarta',
      kodePos: '11620',
      lokasi: 'Meruya, Jakarta Barat',
      petaLokasi: 'https://maps.app.goo.gl/Ffa6ArGPNGf1ZoFN6',
      qrCodeLokasi:
          'https://image-charts.com/chart?chs=200x200&cht=qr&chl=https://maps.app.goo.gl/Ffa6ArGPNGf1ZoFN6',
    ),
    TrainingLocation(
      id: 2,
      namaLokasi: 'LPK K3',
      alamat:
          'Jl. Gempol Raya, RT.001/RW.002, Kunciran, Pinang, Kota Tangerang, Banten 15144',
      kelurahan: 'Kunciran',
      kecamatan: 'Pinang',
      kotaKabupaten: 'Kota Tangerang',
      provinsi: 'Banten',
      kodePos: '15144',
      lokasi: 'Kunciran, Kota Tangerang',
      petaLokasi: 'https://maps.app.goo.gl/xD8ybdbA3bXaFG8Q6',
      qrCodeLokasi:
          'https://image-charts.com/chart?chs=200x200&cht=qr&chl=https://maps.app.goo.gl/xD8ybdbA3bXaFG8Q6',
    ),
    TrainingLocation(
      id: 3,
      namaLokasi: 'GSI Training Center',
      alamat:
          'Gg. Cemara, RT.002/RW.007, Bubulak, Bogor Barat, Kota Bogor, Jawa Barat 16115',
      kelurahan: 'Bubulak',
      kecamatan: 'Bogor Barat',
      kotaKabupaten: 'Kota Bogor',
      provinsi: 'Jawa Barat',
      kodePos: '16115',
      lokasi: 'Bubulak, Kota Bogor',
      petaLokasi: 'https://maps.app.goo.gl/rkYYN4MNG5yvUNtc9',
      qrCodeLokasi:
          'https://image-charts.com/chart?chs=200x200&cht=qr&chl=https://maps.app.goo.gl/rkYYN4MNG5yvUNtc9',
    ),
    TrainingLocation(
      id: 4,
      namaLokasi: 'The Acacia Hotel Jakarta',
      alamat:
          'Jl. Kramat Raya No.81, RT.001/RW.007, Kramat, Senen, Jakarta Pusat, DKI Jakarta 10450',
      kelurahan: 'Kramat',
      kecamatan: 'Senen',
      kotaKabupaten: 'Jakarta Pusat',
      provinsi: 'DKI Jakarta',
      kodePos: '10450',
      lokasi: 'Kramat, Jakarta Pusat',
      petaLokasi: 'https://maps.app.goo.gl/iAv2mApms4afFfVk7',
      qrCodeLokasi:
          'https://image-charts.com/chart?chs=200x200&cht=qr&chl=https://maps.app.goo.gl/iAv2mApms4afFfVk7',
    ),
    TrainingLocation(
      id: 5,
      namaLokasi: 'Universitas Indonesia',
      alamat:
          'Jl. Lingkar, Pondok Cina, Kec. Beji, Kota Depok, Jawa Barat 16424',
      kelurahan: 'Pondok Cina',
      kecamatan: 'Beji',
      kotaKabupaten: 'Kota Depok',
      provinsi: 'Jawa Barat',
      kodePos: '16424',
      lokasi: 'Pondok Cina, Kota Depok',
      petaLokasi: 'https://maps.app.goo.gl/C37NDKJvfUpimLvHA',
      qrCodeLokasi:
          'https://image-charts.com/chart?chs=200x200&cht=qr&chl=https://maps.app.goo.gl/C37NDKJvfUpimLvHA',
    ),
    TrainingLocation(
      id: 6,
      namaLokasi: '88 Hotel Bekasi',
      alamat:
          'Jl. Cut Mutia No.139, RT.001/RW.002, Sepanjang Jaya, Rawalumbu, Kota Bekasi, Jawa Barat 17114',
      kelurahan: 'Sepanjang Jaya',
      kecamatan: 'Rawalumbu',
      kotaKabupaten: 'Kota Bekasi',
      provinsi: 'Jawa Barat',
      kodePos: '17114',
      lokasi: 'Sepanjang Jaya, Kota Bekasi',
      petaLokasi: 'https://maps.app.goo.gl/iGEkWhSXBBiXXLHb9',
      qrCodeLokasi:
          'https://image-charts.com/chart?chs=200x200&cht=qr&chl=https://maps.app.goo.gl/iGEkWhSXBBiXXLHb9',
    ),
    TrainingLocation(
      id: 7,
      namaLokasi: 'Amaris Hotel Cilegon',
      alamat:
          'Jl. SA. Tirtayasa No.17, Jombang Wetan, Jombang, Kota Cilegon, Banten 42411',
      kelurahan: 'Jombang Wetan',
      kecamatan: 'Jombang',
      kotaKabupaten: 'Kota Cilegon',
      provinsi: 'Banten',
      kodePos: '42411',
      lokasi: 'Jombang Wetan, Kota Cilegon',
      petaLokasi: 'https://maps.app.goo.gl/pJ5KEae4Fcqv6mm57',
      qrCodeLokasi:
          'https://image-charts.com/chart?chs=200x200&cht=qr&chl=https://maps.app.goo.gl/pJ5KEae4Fcqv6mm57',
    ),
    TrainingLocation(
      id: 8,
      namaLokasi: 'Grand Serela Setiabudhi Bandung',
      alamat:
          'Jl. Hegarmanah No.15 No. 9, Hegarmanah, Cidadap, Kota Bandung, Jawa Barat 12630',
      kelurahan: 'Hegarmanah',
      kecamatan: 'Cidadap',
      kotaKabupaten: 'Kota Bandung',
      provinsi: 'Jawa Barat',
      kodePos: '12630',
      lokasi: 'Hegarmanah, Kota Bandung',
      petaLokasi: 'https://maps.app.goo.gl/pNgEtGs2BtfqpLnYA',
      qrCodeLokasi:
          'https://image-charts.com/chart?chs=200x200&cht=qr&chl=https://maps.app.goo.gl/pNgEtGs2BtfqpLnYA',
    ),
    TrainingLocation(
      id: 9,
      namaLokasi: 'UC Hotel UGM',
      alamat:
          'Hotel & Convention, Bulaksumur Jl. Pancasila No.2, Sendowo, Sinduadi, Depok, Sleman, D.I. Yogyakarta 55281',
      kelurahan: 'Sinduadi',
      kecamatan: 'Depok',
      kotaKabupaten: 'Sleman',
      provinsi: 'D.I. Yogyakarta',
      kodePos: '55281',
      lokasi: 'Sinduadi, Sleman',
      petaLokasi: 'https://maps.app.goo.gl/rj3EvzZTr6msn58Q6',
      qrCodeLokasi:
          'https://image-charts.com/chart?chs=200x200&cht=qr&chl=https://maps.app.goo.gl/rj3EvzZTr6msn58Q6',
    ),
  ];
}
