class UserData {
  int? success;
  Profile? profile;

  UserData({this.success, this.profile});

  UserData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? name;
  String? email;
  String? phone;
  Null? image;
  String? referralCode;
  Null? referrer;
  int? balance;

  Profile(
      {this.name,
        this.email,
        this.phone,
        this.image,
        this.referralCode,
        this.referrer,
        this.balance});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    referralCode = json['referral_code'];
    referrer = json['referrer'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['referral_code'] = this.referralCode;
    data['referrer'] = this.referrer;
    data['balance'] = this.balance;
    return data;
  }
}
