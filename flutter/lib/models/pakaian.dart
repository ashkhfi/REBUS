class Pakaian {
  int id;
  String nama;
  String deskripsi;
  String kategori;
  String kelamin;
  String usia;
  String status;
  int harga;
  String image;

  Pakaian({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.kategori,
    required this.kelamin,
    required this.usia,
    required this.status,
    required this.harga,
    required this.image,
  });

  factory Pakaian.fromJson(Map<String, dynamic> json) {
    return Pakaian(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      kategori: json['kategori'],
      kelamin: json['kelamin'],
      usia: json['usia'],
      status: json['status'],
      harga: json['harga'],
      image: json['image'],
    );
  }
}
