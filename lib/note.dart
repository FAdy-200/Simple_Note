class Note{
  dynamic id;
  String name;
  String description;
  Note({
    this.id,
    required this.name,
    required this.description});
  Note.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        description = res['description'];

  Map<String, Object?> toMap() {
    return {'id':id, 'name': name, 'description': description};
  }
}