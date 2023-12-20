// To receive response data after register and deal with it
// we can appear an error message in the UI screen so the user know what the error, the email he entered or what.
class UserModel {
  late String status;
  String? message;
  UserData? user;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }
}

class UserData {

  String? name;
  String? email;
  String? phone;
  String? nationalId;
  String? gender;
  String? profileImage;
  String? token;

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    nationalId = json['nationalId'];
    gender = json['gender'];
    profileImage = json['profileImage'];
    token = json['token'];
  }

}
