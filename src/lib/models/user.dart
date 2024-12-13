import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? imageUrl;
  final bool notificationsEnabled;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.imageUrl,
    this.notificationsEnabled = true,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    bool? notificationsEnabled,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      imageUrl: json['imageUrl'] as String?,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
    );
  }

  @override
  List<Object?> get props => [id, name, email, imageUrl, notificationsEnabled];
}
