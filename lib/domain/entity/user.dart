class User {
  String name;
  int id;

  User(this.name, this.id);

  User copyWith({String? name, int? id}) {
    return User(name ?? this.name, id ?? this.id);
  }
}
