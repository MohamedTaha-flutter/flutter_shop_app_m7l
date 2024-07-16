class LoginModel {
  final bool status;
   final String message;
  final UserDataModel data;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      data: UserDataModel.fromJson(json['data']),
    );
  }
}

class UserDataModel {
  final int? id;

  final String name;

  final String email;

  final String phone;

  final String image;

  final String token;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,

    required this.token,
  });

  factory UserDataModel.fromJson(json) {
    return UserDataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      token: json['token'],
    );
  }
}
