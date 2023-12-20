//Make this model to view the error message
class UpdateUserDataModel {
  String? status;
  String? message;
  UserData? user;

  UpdateUserDataModel(this.status, this.message);

  UpdateUserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }
}

class UserData {
  String? name;
  String? email;
  String? phone;
  String? id;
  String? gender;
  //String? nationalId;
  //String? profileImage;
  //String? token;

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['_id'];
    gender = json['gender'];
    //nationalId = json['nationalId'];
    //profileImage = json['profileImage'];
   // token = json['token'];
  }

}