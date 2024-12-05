class Listmodel {
  final int id;
  final String name;
  final String imageUrl;
  final String familyCreator;

  Listmodel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.familyCreator,
  });

  factory Listmodel.fromJson(Map<String, dynamic> json) {
    return Listmodel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        imageUrl: (json['images'] != null && json['images'].isNotEmpty)
            ? json['images'][0]
            : 'https://www.amiiboapi.com/api/amiibo/',
        familyCreator: (json['family'] != null)
            ? (json['family']['creator'] ?? "List Data Kosong")
            : "Kosong bang");
  }
}
