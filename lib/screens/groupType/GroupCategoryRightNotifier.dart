import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:payroll/modals/ClaimsList.dart';
import 'package:payroll/modals/GroupCategories.dart';
import 'package:payroll/modals/GroupCategoryRights.dart';
import 'package:payroll/repo/RolesClaimsRepo.dart';

class GroupCategoryRightsNotifier extends ChangeNotifier {

  RolesClaimsRepo get repository => GetIt.I<RolesClaimsRepo>();



  GroupCategoryRightsNotifier(List<GroupCategoryRights>?  data) {
    getClaims();
    if(data==null){
    fetchData();
    }
    else{
      _groupCategoryRightModel.addAll(data);
      _filterData.addAll(data);
    }
  }


  List<GroupCategoryRights> get filterData => _filterData;

  set filterData(List<GroupCategoryRights> groupCategoryRight) {
    _filterData = groupCategoryRight;
    notifyListeners();
  }

  int get sortColumnIndex => _sortColumnIndex!;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }


  void expendCollapesFisrtLevel() {
    for (int i = 0; i < _filterData.length; i++) {
      if (_isFirstExpend) {
        if (_filterData[i].expansionTile.currentState != null)
          _filterData[i].expansionTile.currentState!.collapse();
      } else {
        if (_filterData[i].expansionTile.currentState != null)
          _filterData[i].expansionTile.currentState!.expand();
      }
    }
    _isFirstExpend = !_isFirstExpend;
    notifyListeners();
  }

  void expendCollapesSecondLevel() {

    for (int i = 0; i < _filterData.length; i++) {
      List<GroupCategoryRights> childs = _filterData[i].children;
      if (childs != null) {
        for (int j = 0; j < _filterData[i].children.length; j++) {
          if (_isSecondExpend) {
            if (childs[j].expansionTile.currentState != null)
              childs[j].expansionTile.currentState!.collapse();
          } else {
            if (childs[j].expansionTile.currentState != null)
              childs[j].expansionTile.currentState!.expand();
          }
        }
      }
    }
    _isSecondExpend = !_isSecondExpend;
    notifyListeners();
  }

  void updateViewAll(bool val) {
    _updateAllValues("View", val);
  }

  void updatePrintAll(bool val) {
    _updateAllValues("Print", val);
  }


   void updateSaveAll(bool val) {
    _updateAllValues("Save", val);
  }


   void updateUpdateAll(bool val) {
    _updateAllValues("Update", val);
  }
   void updateDeleteAll(bool val) {
     _updateAllValues("Delete", val);
  }

  void updateExprotToExcelCSVAll(bool val) {
       _updateAllValues("Export To Excel/CSV", val);
  }


  void updateAllOthers(bool value){
    filterData.forEach((element) {
      element.children.forEach((outer) {
        outer.children.forEach((innter) {
          if(innter.title!="View" &&
              innter.title!="Print" &&
              innter.title!="Save" &&
              innter.title!="Update" &&
              innter.title!="Delete" &&
              innter.title!="Export To Excel/CSV" ) {
            innter.isSelected = value;
          }
        });
      });
    });
    notifyListeners();
  }


  void _updateAllValues(String title, bool value){
    filterData.forEach((element) {
      print(title);
      element.children.forEach((outer) {
        print(outer.value);
        outer.children.forEach((innter) {
          if(innter.title==title){
            innter.isSelected = value;
          }
        });
      });
    });
    notifyListeners();
  }



  onSearchTextChanged(String text) async {
    _filterData.clear();
    if (text.isEmpty) {
      _filterData.addAll(_groupCategoryRightModel);
    } else {
      _groupCategoryRightModel.forEach((GroupDetail) {
        if (GroupDetail.title!.toLowerCase().contains(text.toLowerCase())) {
          _filterData.add(GroupDetail);
        }
      });
    }
    notifyListeners();
  }

  //////////////// internal ///////////
  var _filterData = <GroupCategoryRights>[];
  var _groupCategoryRightModel = <GroupCategoryRights>[];
  bool _isFirstExpend = false;
  bool _isSecondExpend = false;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  int _rowsPerPage =  PaginatedDataTable.defaultRowsPerPage;



  Future<void> fetchData() async {
    _groupCategoryRightModel = <GroupCategoryRights>[
      GroupCategoryRights(
        title: 'Configuration',
        childrenVal: <GroupCategoryRights>[
          GroupCategoryRights(
            title: 'Account Head',
            childrenVal: <GroupCategoryRights>[
              GroupCategoryRights(title: 'View'),
              GroupCategoryRights(title: 'Save'),
              GroupCategoryRights(title: 'Update'),
              GroupCategoryRights(title: 'Delete'),
              GroupCategoryRights(title: 'Print'),
              GroupCategoryRights(title: 'Export To Excel/CSV'),
              GroupCategoryRights(title: 'Temp'),
            ],
          ),
          GroupCategoryRights(
            title: 'Allow Shops to Search Products',
            childrenVal: <GroupCategoryRights>[
              GroupCategoryRights(title: 'View'),
              GroupCategoryRights(title: 'Save'),
              GroupCategoryRights(title: 'Update'),
              GroupCategoryRights(title: 'Delete'),
              GroupCategoryRights(title: 'Print'),
              GroupCategoryRights(title: 'Export To Excel/CSV'),
              GroupCategoryRights(title: 'Temp 2'),
            ],
          ),
          GroupCategoryRights(
            title: 'Areas',
            childrenVal: <GroupCategoryRights>[
              GroupCategoryRights(title: 'View'),
              GroupCategoryRights(title: 'Save'),
              GroupCategoryRights(title: 'Update'),
              GroupCategoryRights(title: 'Delete'),
              GroupCategoryRights(title: 'Print'),
              GroupCategoryRights(title: 'Export To Excel/CSV'),
            ],
          ),
        ],
      ),

      ////////////// second
      GroupCategoryRights(
        title: 'Chapter B',
        childrenVal: <GroupCategoryRights>[
          GroupCategoryRights(
            title: 'Section B0',
            childrenVal: <GroupCategoryRights>[
              GroupCategoryRights(title: 'View'),
              GroupCategoryRights(title: 'Save'),
              GroupCategoryRights(title: 'Update'),
              GroupCategoryRights(title: 'Delete'),
              GroupCategoryRights(title: 'Print'),
              GroupCategoryRights(title: 'Export To Excel/CSV'),
            ],
          ),
          GroupCategoryRights(
            title: 'Section B1',
            childrenVal: <GroupCategoryRights>[
              GroupCategoryRights(title: 'View'),
              GroupCategoryRights(title: 'Save'),
              GroupCategoryRights(title: 'Update'),
              GroupCategoryRights(title: 'Delete'),
              GroupCategoryRights(title: 'Print'),
              GroupCategoryRights(title: 'Export To Excel/CSV'),
            ],
          ),
          GroupCategoryRights(
            title: 'Section B2',
            childrenVal: <GroupCategoryRights>[
              GroupCategoryRights(title: 'View'),
              GroupCategoryRights(title: 'Save'),
              GroupCategoryRights(title: 'Update'),
              GroupCategoryRights(title: 'Delete'),
              GroupCategoryRights(title: 'Print'),
              GroupCategoryRights(title: 'Export To Excel/CSV'),
            ],
          ),
        ],
      ),

      // Third Row
      GroupCategoryRights(
        title: 'Chapter C',
        childrenVal: <GroupCategoryRights>[
          GroupCategoryRights(
            title: 'Section C0',
            childrenVal: <GroupCategoryRights>[
              GroupCategoryRights(title: 'View'),
              GroupCategoryRights(title: 'Save'),
              GroupCategoryRights(title: 'Update'),
              GroupCategoryRights(title: 'Delete'),
              GroupCategoryRights(title: 'Print'),
              GroupCategoryRights(title: 'Export To Excel/CSV'),
            ],
          ),
          GroupCategoryRights(
            title: 'Section C1',
            childrenVal: <GroupCategoryRights>[
              GroupCategoryRights(title: 'View'),
              GroupCategoryRights(title: 'Save'),
              GroupCategoryRights(title: 'Update'),
              GroupCategoryRights(title: 'Delete'),
              GroupCategoryRights(title: 'Print'),
              GroupCategoryRights(title: 'Export To Excel/CSV'),
            ],
          ),
          GroupCategoryRights(
            title: 'Section C2',
            childrenVal: <GroupCategoryRights>[
              GroupCategoryRights(title: 'View'),
              GroupCategoryRights(title: 'Save'),
              GroupCategoryRights(title: 'Update'),
              GroupCategoryRights(title: 'Delete'),
              GroupCategoryRights(title: 'Print'),
              GroupCategoryRights(title: 'Export To Excel/CSV'),
            ],
          ),
        ],
      ),
    ];
    _filterData.clear();
    _filterData.addAll(_groupCategoryRightModel);
    notifyListeners();
  }


  // ===================== Get Claims
  ClaimsList? objClaim= null;   // Module claims here
  List<GroupCategories> moduleList = []; // All Module Names save here
  Map <String, List<ClaimValues>>? ddd;
  List<GroupCategoryRights> MegaList = [];
  Future<void> getClaims() async{
    await repository.getAllClaims().then((value){
      if(value != null){
        print(value.data);
        objClaim= value.data;

        // Module Names List
        List<String> modulesName = objClaim!.claimsList!.keys.toList();
          for(int i=0; i<modulesName.length; i++){
          List<GroupCategoryRights> myDataList = [];
          String heading ="";
          moduleList.add(GroupCategories(name: modulesName[i], id:i+1,));
          heading = modulesName[i];
          Map <String, List<ClaimValues>>? moduleCalims  = objClaim?.claimsList?[modulesName[i]];
          List<String> headNames = moduleCalims!.keys.toList();
            print(headNames);
            moduleCalims.forEach((key, value) {
              String subheading="";
              subheading = key.toString();
              List<GroupCategoryRights> insideList = [];
              value.forEach((element) {
                print("${element.name} : ${element.isSelected} : ${element.value} ");
                insideList.add(GroupCategoryRights(title: element.name, value: element.value));
              });

              myDataList.add(
                    GroupCategoryRights(
                      title: subheading,
                      childrenVal: insideList,
                    ),
              );
            });
          MegaList.add(
              GroupCategoryRights(
                title: heading,
                childrenVal: myDataList,
              ),);
          _filterData = MegaList;
          }
         notifyListeners();
      }
      else{
        print(value.error);
        print(value.errorMessage);
      }
    });

  }

}

// for(int i=0; i<modulesName.length; i++){
//   Map<String , List<ClaimValues>>? list = {};
//   list = objClaim.claimsList?["${modulesName[i]}"];
//
//   if(list!=null){
//     print("${modulesName[i]} Keys Length is : ${list.keys.length}");
//     print("List: ${list.length}");
//     print(list);
//
//     Map<String , List<ClaimValues>>? inventoryClaims = {};
//     //
//     //   print(list.entries.map((e) => e.value.length));
//
//   }
//
//   // list!.keys.forEach((key) {
//   //   print(key);
//   // });
//   // claimsVal = objClaim.claimsList?["${modulesName[i]}"];
//   //   print("ClaimsValue : $claimsVal");
//   }
// //(claimsVal);
// Map<String, List<Object>>? inventoryClaims = new Map<String, List<Object>>();
// //Map<String , List<ClaimValues>>? claimsVal =  objClaim.claimsList?["inventory"];
// inventoryClaims =  objClaim.claimsList?["inventory"];
//   //print("Inventory Claims : $inventoryClaims");
//   List<String> inventoryKeys = inventoryClaims!.keys.toList();
//   print(inventoryKeys);
//   for(int i=0; i<inventoryKeys.length; i++){
//
//     List<Object>? list = inventoryClaims["${inventoryKeys[i]}"];
//
//     print(inventoryClaims["${inventoryKeys[i]}"]!.forEach((element) {print(element);}));
//   }

// List<String>? listHead = claimsVal?.keys.toList();
// print("List Head : $listHead");

//
// List<ClaimValues>? listClaimsValues = claimsVal?["Vendor"];
// print("List Claims Values : $listClaimsValues");

//
// moduleList.forEach((element) {
//   print("Categories :  ${element.name} , ${element.id}.");
// });