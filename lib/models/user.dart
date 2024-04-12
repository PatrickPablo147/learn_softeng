class Users {
  String token;
  String username;
  bool status;
  String email;
  String password;

  Users({
    required this.token,
    required this.username,
    required this.status,
    required this.email,
    required this.password
  });

  Users.fromJson(Map<String, Object?> json) :
        this(
        token: json['token']! as String,
        username: json['username']! as String,
        status: json['status']! as bool,
        email: json['email']! as String,
        password: json['password']! as String
      );

  Users copyWith({
    String? token,
    String? username,
    bool? status,
    String? email,
    String? password
  }) {
    return Users(
      token: token ?? this.token,
      username: username ?? this.username,
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password
    );
  }

  Map<String, Object> toJson() {
    return {
      'token' : token,
      'username' : username,
      'status' : status,
      'email' : email,
      'password' : password
    };
  }
}