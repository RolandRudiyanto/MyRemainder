class Data{
  late final int? id;
  final String? tgl;
  final String? judul;
  final String? desc;



  Data({
    this.id,this.tgl,this.judul,this.desc,
  });

  Data.fromMap(Map<String, dynamic> res)
      : id = res['id'], tgl = res['tgl'], judul = res['judul'], desc = res['desc'];

  Map<String, Object?> toMap(){
    return {
      'id' : id,
      'tgl':tgl,
      'judul':judul,
      "desc":desc,
    };
  }
}