class Sepatu {
  final String Jumlah;
  final String Merk;
  final String Ukuran;
  final String Warna;
  final String Jenis;
  final String JenisPelanggan;

  Sepatu({
    required this.Jumlah,
    required this.Merk,
    required this.Ukuran,
    required this.Warna,
    required this.Jenis,
    required this.JenisPelanggan,
  });

  factory Sepatu.fromJson(Map<String, dynamic> json) {
    return Sepatu(
      Jumlah: json['Jumlah'],
      Merk: json['Merk'],
      Ukuran: json['Ukuran'],
      Warna: json['Warna'],
      Jenis: json['Jenis'],
      JenisPelanggan: json['JenisPelanggan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Jumlah': Jumlah,
      'Merk': Merk,
      'Ukuran': Ukuran,
      'Warna': Warna,
      'Jenis': Jenis,
      'Jenis Pelanggan': JenisPelanggan,
    };
  }
}
