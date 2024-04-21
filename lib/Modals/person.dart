class Person {
  String name;
  String email;
  String age;

  Person({
    required this.name,
    required this.email,
    required this.age,
  });

  Person.empty()
      : name = '',
        email = '',
        age = '';

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      age: json['age'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['age'] = this.age;
    return data;
  }
}

Person currPerson = Person.empty();
