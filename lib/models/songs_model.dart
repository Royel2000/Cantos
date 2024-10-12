class SongModel {
  String? id;
  String? title;
  String? descripcion;

  SongModel({
    this.id,
    this.title,
    this.descripcion,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        id: json["id"],
        title: json["title"] ?? 'Sin título',
        descripcion: json["descripcion"] ?? 'Sin descripción',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "descripcion": descripcion,
      };
}
