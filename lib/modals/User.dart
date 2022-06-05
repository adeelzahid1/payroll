import 'package:payroll/modals/ShopName.dart';

class User {
  int? id;
  int? roleId;
  String? name;
  String? email;
  String? comment;
  String? endDate;
  bool isEndDate;
  String? language;

  Shop? shop;
  String? loginId;
  String? password;

  bool enableViewCostPrice;
  bool applyAdjustment;
  bool applyOpenAdjustment;
  bool showSecondaryCost;
  bool hideStockInHelp;
  bool allowReleaseDownload;
  bool allowPOSDiscount;
  bool allowPOSPriceEditing;

  User(
      {this.id = -1,
        this.name,
        this.email,
        this.comment,
        this.endDate,
        this.isEndDate = false,
        this.language,
        this.shop,
        this.loginId,
        this.password,
        this.roleId,
        this.enableViewCostPrice = false,
        this.applyAdjustment = false,
        this.applyOpenAdjustment = false,
        this.showSecondaryCost = false,
        this.hideStockInHelp = false,
        this.allowReleaseDownload = false,
        this.allowPOSDiscount = false,
        this.allowPOSPriceEditing = false});

  void printUser() {
    print("id: ${this.id}"
        "Name: ${this.name}   email: ${this.email}   comment: ${this.comment}   endDate: ${this.endDate}   loginId: ${this.loginId}   password: ${this.password}   enableViewCostPrice: ${this.enableViewCostPrice}   ");
  }
}
