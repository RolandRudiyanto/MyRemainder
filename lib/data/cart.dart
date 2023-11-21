class Cart {
  late final int? id_belanja;
  final String? nama_produk;
  final String? img_produk;
  final double? harga_produk;
  final int? quantity;
  late final bool complete;
  final int id;

  Cart({
    this.id_belanja,
    required this.nama_produk,
    required this.img_produk,
    required this.harga_produk,
    required this.quantity,
    this.complete = false,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_belanja': id_belanja,
      'nama_produk': nama_produk,
      'img_produk': img_produk,
      'harga_produk': harga_produk,
      'quantity' : quantity,
      'complete': complete ? 1 : 0,
      'id': id,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id_belanja: map['id_belanja'],
      nama_produk: map['nama_produk'],
      img_produk: map['img_produk'],
      harga_produk: map['harga_produk'],
      quantity: map['quantity'],
      complete: map['complete'] == 1,
      id: map['id'],
    );
  }
}