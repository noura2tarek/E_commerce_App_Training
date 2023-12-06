// To receive response data after register and deal with it
// we can appear an error message in the UI screen so the user know what the error, the email he entered or what.
class RegisterModel {
  late String status;
  String? message;
  RegisterUserData? user;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? RegisterUserData.fromJson(json['data']) : null;
  }
}

class RegisterUserData {

  String? name;
  String? email;
  String? phone;
  String? nationalId;
  String? gender;
  String? profileImage;
  String? token;

  RegisterUserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    nationalId = json['nationalId'];
    gender = json['gender'];
    profileImage = json['profileImage'];
    token = json['token'];
  }
}
