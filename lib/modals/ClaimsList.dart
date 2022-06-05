// Main Class
class ClaimsList {
  Map<String, Map<String, List<ClaimValues>>>? claimsList = new Map();

  ClaimsList({this.claimsList});

  ClaimsList.fromJson(dynamic json) {
    List<String> moduleKeys = json.keys.toList();
    moduleKeys.forEach((elementModule) {
      if((elementModule!="status")) {
        var jsonInventory = json[elementModule];
        if (jsonInventory != null) {
          Map<String, List<ClaimValues>>? moduleClaim = new Map();

          Map<String, dynamic> moduleMapForkeys = jsonInventory;
          List<String> inventoryKeys = moduleMapForkeys.keys.toList();

          inventoryKeys.forEach((element) {
            var jsonSectionClaim = jsonInventory[element] as List;
            if (jsonSectionClaim != null) {
              List<ClaimValues> SectionClaimList = [];
              jsonSectionClaim.forEach((element) {
                Map<String, dynamic> item = element;
                if (item != null) {
                  SectionClaimList.add(ClaimValues.fromJson(item));
                }
              });
              moduleClaim[element] = SectionClaimList;
            }
          });
          claimsList ? [elementModule] = moduleClaim;
        }
      }

      /// inventory End here
    });
  }
}


// Child Class
class ClaimValues {
  String? name;
  int? value;
  bool? isSelected;

  ClaimValues({this.name, this.value, this.isSelected});

  ClaimValues.fromJson(dynamic json) {
    name = json["name"];
    value = json["value"];
    isSelected = json["isSelected"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["value"] = value;
    map["isSelected"] = isSelected;
    return map;
  }
}


//=================================================
//================== Classes Data =================
//=================================================

// class PayRoll {
//   List<AllowanceType>? allowanceType;
//   List<Attendance>? attendance;
//   List<Department>? department;
//   List<Designation>? designation;
//   List<DistributionType>? distributionType;
//   List<EmployeeFundAllocation>? employeeFundAllocation;
//   List<EmployeeType>? employeeType;
//   List<Salary>? salary;
//   List<Shift>? shift;
//   List<ShiftDuration>? shiftDuration;
//   List<ShiftTime>? shiftTime;
//
//   PayRoll(
//       {this.allowanceType,
//       this.attendance,
//       this.department,
//       this.designation,
//       this.distributionType,
//       this.employeeFundAllocation,
//       this.employeeType,
//       this.salary,
//       this.shift,
//       this.shiftDuration,
//       this.shiftTime});
//
//   PayRoll.fromJson(dynamic json) {
//     if (json["AllowanceType"] != null) {
//       allowanceType = [];
//       json["AllowanceType"].forEach((v) {
//         allowanceType?.add(AllowanceType.fromJson(v));
//       });
//     }
//     if (json["Attendance"] != null) {
//       attendance = [];
//       json["Attendance"].forEach((v) {
//         attendance?.add(Attendance.fromJson(v));
//       });
//     }
//     if (json["Department"] != null) {
//       department = [];
//       json["Department"].forEach((v) {
//         department?.add(Department.fromJson(v));
//       });
//     }
//     if (json["Designation"] != null) {
//       designation = [];
//       json["Designation"].forEach((v) {
//         designation?.add(Designation.fromJson(v));
//       });
//     }
//     if (json["DistributionType"] != null) {
//       distributionType = [];
//       json["DistributionType"].forEach((v) {
//         distributionType?.add(DistributionType.fromJson(v));
//       });
//     }
//     if (json["EmployeeFundAllocation"] != null) {
//       employeeFundAllocation = [];
//       json["EmployeeFundAllocation"].forEach((v) {
//         employeeFundAllocation?.add(EmployeeFundAllocation.fromJson(v));
//       });
//     }
//     if (json["EmployeeType"] != null) {
//       employeeType = [];
//       json["EmployeeType"].forEach((v) {
//         employeeType?.add(EmployeeType.fromJson(v));
//       });
//     }
//     if (json["Salary"] != null) {
//       salary = [];
//       json["Salary"].forEach((v) {
//         salary?.add(Salary.fromJson(v));
//       });
//     }
//     if (json["Shift"] != null) {
//       shift = [];
//       json["Shift"].forEach((v) {
//         shift?.add(Shift.fromJson(v));
//       });
//     }
//     if (json["ShiftDuration"] != null) {
//       shiftDuration = [];
//       json["ShiftDuration"].forEach((v) {
//         shiftDuration?.add(ShiftDuration.fromJson(v));
//       });
//     }
//     if (json["ShiftTime"] != null) {
//       shiftTime = [];
//       json["ShiftTime"].forEach((v) {
//         shiftTime?.add(ShiftTime.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (allowanceType != null) {
//       map["AllowanceType"] = allowanceType?.map((v) => v.toJson()).toList();
//     }
//     if (attendance != null) {
//       map["Attendance"] = attendance?.map((v) => v.toJson()).toList();
//     }
//     if (department != null) {
//       map["Department"] = department?.map((v) => v.toJson()).toList();
//     }
//     if (designation != null) {
//       map["Designation"] = designation?.map((v) => v.toJson()).toList();
//     }
//     if (distributionType != null) {
//       map["DistributionType"] =
//           distributionType?.map((v) => v.toJson()).toList();
//     }
//     if (employeeFundAllocation != null) {
//       map["EmployeeFundAllocation"] =
//           employeeFundAllocation?.map((v) => v.toJson()).toList();
//     }
//     if (employeeType != null) {
//       map["EmployeeType"] = employeeType?.map((v) => v.toJson()).toList();
//     }
//     if (salary != null) {
//       map["Salary"] = salary?.map((v) => v.toJson()).toList();
//     }
//     if (shift != null) {
//       map["Shift"] = shift?.map((v) => v.toJson()).toList();
//     }
//     if (shiftDuration != null) {
//       map["ShiftDuration"] = shiftDuration?.map((v) => v.toJson()).toList();
//     }
//     if (shiftTime != null) {
//       map["ShiftTime"] = shiftTime?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// class ShiftTime {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   ShiftTime({this.name, this.value, this.isSelected});
//
//   ShiftTime.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }
//
// class ShiftDuration {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   ShiftDuration({this.name, this.value, this.isSelected});
//
//   ShiftDuration.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }
//
// class Shift {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   Shift({this.name, this.value, this.isSelected});
//
//   Shift.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }
//
// class Salary {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   Salary({this.name, this.value, this.isSelected});
//
//   Salary.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }
//
// class EmployeeType {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   EmployeeType({this.name, this.value, this.isSelected});
//
//   EmployeeType.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }
//
// class EmployeeFundAllocation {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   EmployeeFundAllocation({this.name, this.value, this.isSelected});
//
//   EmployeeFundAllocation.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }
//
// class DistributionType {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   DistributionType({this.name, this.value, this.isSelected});
//
//   DistributionType.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }
//
// class Designation {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   Designation({this.name, this.value, this.isSelected});
//
//   Designation.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }
//
// class Department {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   Department({this.name, this.value, this.isSelected});
//
//   Department.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }
//
// class Attendance {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   Attendance({this.name, this.value, this.isSelected});
//
//   Attendance.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }
//
// class AllowanceType {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   AllowanceType({this.name, this.value, this.isSelected});
//
//   AllowanceType.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
// }

//=================================================
//================== Rough Data ===================
//=================================================


//
// var jsonVendor = jsonInventory["Vendor"] as List;
// if(jsonVendor!=null){
// List<ClaimValues> VendorList = [];
// jsonVendor.forEach((element) {
// Map<String , dynamic> item = element;
// if(item!=null){
// VendorList.add(ClaimValues.fromJson(item));
// }
// });
// } // vender completed
//
// var jsonProduct = jsonInventory["Product"] as List;
// if(jsonProduct!=null){
// List<ClaimValues> ProductList = [];
// jsonProduct.forEach((element) {
// Map<String , dynamic> item = element;
// if(item!=null){
// ProductList.add(ClaimValues.fromJson(item));
// }
// });
// } // Product completed
//

//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["status"] = status;
//     if (inventory != null) {
//       map["inventory"] = inventory?.toJson();
//     }
//     if (payRoll != null) {
//       map["payRoll"] = payRoll?.toJson();
//     }
//     return map;
//   }
//

// class Inventory {
//   List<Vendor>? vendor;
//   List<Product>? product;
//   List<Aritcle>? aritcle;
//   List<Category>? category;
//   List<SubCategory>? subCategory;
//   List<Unit>? unit;
//   List<Storage>? storage;
//
//   Inventory({
//       this.vendor,
//       this.product,
//       this.aritcle,
//       this.category,
//       this.subCategory,
//       this.unit,
//       this.storage});
//
//   Inventory.fromJson(dynamic json) {
//     if (json["Vendor"] != null) {
//       vendor = [];
//       json["Vendor"].forEach((v) {
//         vendor?.add(Vendor.fromJson(v));
//       });
//     }
//     if (json["Product"] != null) {
//       product = [];
//       json["Product"].forEach((v) {
//         product?.add(Product.fromJson(v));
//       });
//     }
//     if (json["Aritcle"] != null) {
//       aritcle = [];
//       json["Aritcle"].forEach((v) {
//         aritcle?.add(Aritcle.fromJson(v));
//       });
//     }
//     if (json["Category"] != null) {
//       category = [];
//       json["Category"].forEach((v) {
//         category?.add(Category.fromJson(v));
//       });
//     }
//     if (json["SubCategory"] != null) {
//       subCategory = [];
//       json["SubCategory"].forEach((v) {
//         subCategory?.add(SubCategory.fromJson(v));
//       });
//     }
//     if (json["Unit"] != null) {
//       unit = [];
//       json["Unit"].forEach((v) {
//         unit?.add(Unit.fromJson(v));
//       });
//     }
//     if (json["Storage"] != null) {
//       storage = [];
//       json["Storage"].forEach((v) {
//         storage?.add(Storage.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     if (vendor != null) {
//       map["Vendor"] = vendor?.map((v) => v.toJson()).toList();
//     }
//     if (product != null) {
//       map["Product"] = product?.map((v) => v.toJson()).toList();
//     }
//     if (aritcle != null) {
//       map["Aritcle"] = aritcle?.map((v) => v.toJson()).toList();
//     }
//     if (category != null) {
//       map["Category"] = category?.map((v) => v.toJson()).toList();
//     }
//     if (subCategory != null) {
//       map["SubCategory"] = subCategory?.map((v) => v.toJson()).toList();
//     }
//     if (unit != null) {
//       map["Unit"] = unit?.map((v) => v.toJson()).toList();
//     }
//     if (storage != null) {
//       map["Storage"] = storage?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// name : "Save"
// /// value : 0
// /// isSelected : false
//
// class Storage {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   Storage({
//       this.name,
//       this.value,
//       this.isSelected});
//
//   Storage.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
//
// }
//
// /// name : "Save"
// /// value : 0
// /// isSelected : false
//
// class Unit {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   Unit({
//       this.name,
//       this.value,
//       this.isSelected});
//
//   Unit.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
//
// }
//
// /// name : "Save"
// /// value : 0
// /// isSelected : false
//
// class SubCategory {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   SubCategory({
//       this.name,
//       this.value,
//       this.isSelected});
//
//   SubCategory.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
//
// }
//
// /// name : "Save"
// /// value : 0
// /// isSelected : false
//
// class Category {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   Category({
//       this.name,
//       this.value,
//       this.isSelected});
//
//   Category.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
//
// }
//
// /// name : "Save"
// /// value : 0
// /// isSelected : false
//
// class Aritcle {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   Aritcle({
//       this.name,
//       this.value,
//       this.isSelected});
//
//   Aritcle.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
//
// }
//
// /// name : "Save"
// /// value : 0
// /// isSelected : false
//
// class Product {
//   String? name;
//   int? value;
//   bool? isSelected;
//
//   Product({
//       this.name,
//       this.value,
//       this.isSelected});
//
//   Product.fromJson(dynamic json) {
//     name = json["name"];
//     value = json["value"];
//     isSelected = json["isSelected"];
//   }
//
//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["name"] = name;
//     map["value"] = value;
//     map["isSelected"] = isSelected;
//     return map;
//   }
//
// }