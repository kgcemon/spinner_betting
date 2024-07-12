class PurchaseSpinnerModel {
  Purchase? purchase;
  String? message;
  int? success;

  PurchaseSpinnerModel({this.purchase, this.message, this.success});

  PurchaseSpinnerModel.fromJson(Map<String, dynamic> json) {
    purchase = json['purchase'] != null
        ? new Purchase.fromJson(json['purchase'])
        : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchase != null) {
      data['purchase'] = this.purchase!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Purchase {
  int? userId;
  String? packageId;
  String? code;
  String? date;
  String? updatedAt;
  String? createdAt;
  int? id;

  Purchase(
      {this.userId,
        this.packageId,
        this.code,
        this.date,
        this.updatedAt,
        this.createdAt,
        this.id});

  Purchase.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    packageId = json['package_id'];
    code = json['code'];
    date = json['date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['package_id'] = this.packageId;
    data['code'] = this.code;
    data['date'] = this.date;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
