class LoginModel{
  late String status;
  String? message;
  LoginUserData? user;

  LoginModel.fromJson(Map<String, dynamic>? json) {
    status = json!['status'];
    message = json['message'];
    user = json['user'] != null ? LoginUserData.fromJson(json['user']) : null;
  }


}

class LoginUserData {

  String? name;
  String? email;
  String? phone;
  String? nationalId;
  String? gender;
  String? profileImage;
  String? token;

  LoginUserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    nationalId = json['nationalId'];
    gender = json['gender'];
    profileImage = json['profileImage'];
    token = json['token'];
  }
}
