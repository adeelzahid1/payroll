//
// import 'dart:ffi';
//
// import 'package:bms/routes/MenuClickFuncation.dart';
// import 'package:bms/screens/dashboard/models/LeftMenu.dart';
// import 'package:bms/widgets/popupmenus/popupMenuArror/popup_menu.dart';
// import 'package:bms/widgets/sideMenu/model/navigation_model.dart';
// import 'package:flutter/material.dart';
// import 'package:network/models/theme/ThemeProvider.dart';
// import 'package:provider/provider.dart';
//
// import 'collapsing_list_tile_widget.dart';
//
// class CollapsingNavigationDrawer extends StatefulWidget {
//
//   List<MenuOption> menuItemsWidget;
//   CollapsingNavigationDrawer(this.menuItemsWidget);
//
//
//   @override
//   CollapsingNavigationDrawerState createState() {
//     return new CollapsingNavigationDrawerState();
//   }
// }
//
// class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
//     with SingleTickerProviderStateMixin {
//   double maxWidth = 270;
//   double minWidth = 66;
//   bool isCollapsed = false;
//   late AnimationController _animationController;
//   late Animation<double> widthAnimation;
//   int currentSelectedIndex = -1;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//         vsync: this, duration: Duration(milliseconds: 300));
//     widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
//         .animate(_animationController);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     PopupMenu.context = context;
//     List<MenuOption> menuItems = widget.menuItemsWidget;
//
//
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, widget) => getWidget(context, widget, themeProvider,  menuItems),
//     );
//   }
//
//   Widget getWidget(context, widget, ThemeProvider themeProvider,List<MenuOption> menuItems) {
//
//     return Material(
//       elevation: 80.0,
//       child: SingleChildScrollView(
//
//         scrollDirection: Axis.vertical,
//         child: Container(
//           width: widthAnimation.value,
//           color: themeProvider.themeMode().primaryColor,
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 6,),
//
//               isCollapsed ?
//               Image.asset("images/applogo.png", width: 50, height: 50,) : Image.asset("images/applogo_text.png", width: 200, height: 50,) ,
//               SizedBox(height: 8,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(40.0),
//                           bottomLeft: Radius.circular(40.0)),
//                       color: themeProvider.themeMode().backgroundColor,
//                     ),
//                     child: Container(
//
//                       height: 20,
//                       width: 20,
//                       decoration: BoxDecoration(
//                           color: themeProvider.themeMode().accentColor,
//                           borderRadius: BorderRadius.all(Radius.circular(20))
//                       ),
//                       child: Center(
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               currentSelectedIndex= -1;
//                               isCollapsed = !isCollapsed;
//                               isCollapsed
//                                   ? _animationController.forward()
//                                   : _animationController.reverse();
//                             });
//                           },
//                           child: AnimatedIcon(
//                             icon: AnimatedIcons.arrow_menu,
//                             progress: _animationController,
//                             color: themeProvider.themeMode().iconColorOnPrimary,
//                             size: 15.0,
//                           ),
//                         ),
//                       ),
//
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4,),
//               Theme(
//                 data: ThemeData( accentColor: themeProvider.themeMode().accentColor, unselectedWidgetColor: themeProvider.themeMode().iconColorOnPrimary, textTheme: TextTheme(subtitle1: TextStyle(color: themeProvider.themeMode().textColorOnPrimary)) /*specify your custom theme here*/),
//                 child:
//
//                 widthAnimation.value <= 67 ?
//
//                     Container(
//
//                       child: ListView.builder(
//
//                         scrollDirection: Axis.vertical,
//                         shrinkWrap: true,
//                         itemCount: menuItems.length,
//                         itemBuilder: (context, index){
//
//                           return  InkWell(
//                             key: menuItems[index].btnKey,
//                             onTap: (){
//                               setState(() {
//                                 currentSelectedIndex = index;
//                               });
//                               customBackground(menuItems[index], themeProvider.themeMode().textColorOnPrimary, themeProvider.themeMode().primaryColor, themeProvider.themeMode().dividerColor, themeProvider.themeMode().accentColor);
//                               // numberExistsDialog(context);
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(horizontal: 6, vertical: 18),
//                                 child: Icon( menuItems[index].icon, size: 24, color: currentSelectedIndex == index? themeProvider.themeMode().iconSelectedColorOnPrimary: themeProvider.themeMode().iconColorOnPrimary,)),
//                           );
//                         },
//                       ),
//                     ):
//
//
//
//
//                 Column(
//
//                   children: [
//                     ...  menuItems.map((e) {
//                       return Container(
//                         child: ExpansionTile(
//
//                           // key: e.btnKey,
//
//                             title:  widthAnimation.value >= 250 ? Text(e.label, ):SizedBox(width: 12,),
//                             leading:  Icon( e.icon, size: 24)  ,
//                             trailing: widthAnimation.value >= 250 ? null :SizedBox(width: 12,),
//                             children: e.options==null ? [] :
//
//                         e.options!.map((menu) {
//                           if(menu.options == null) {
//
//                             return Align(
//                               alignment: Alignment.centerLeft,
//                               child: Container(
//                                 // padding: const EdgeInsets.only(left: 50),
//                                 margin: EdgeInsets.only(left: 70, right: 8, top: 6, bottom: 6),
//                                 child: Text(menu.label, style: TextStyle(color: themeProvider.themeMode().textColorOnPrimary),),
//
//                               ),
//                             );
//                             return ListTile(
//
//
//                                   title:  GestureDetector(child: Padding(
//                                   padding: const EdgeInsets.only(left: 50),
//                                   child: Text ( menu.label),
//                                 ) ,
//                                     onTap: () {
//                                       //Navigator.pop(context);
//                                      // MenuClickFuncation(context, menu.label);
//
//                                     }));
//                           }
//                           else{
//                             return ExpansionTile(title: Padding(
//                               padding: const EdgeInsets.only(left: 50),
//                               child: Text(menu.label),
//                             ), children: menu.options==null ? [] :
//                             [
//                               ... menu.options!.map((subMenu) {
//                                 if(subMenu.options == null) {
//                                   return ListTile(
//                                       title:  GestureDetector(child: Padding(
//                                         padding: const EdgeInsets.only(left: 18),
//                                         child: Text ( subMenu.label),
//                                       ) ,
//                                           onTap: () {
//                                            // Navigator.pop(context);
//                                            // MenuClickFuncation(context, subMenu.label);
//
//                                           }));
//                                 }
//                                 else{
//                                   return ExpansionTile(title: Padding(
//                                     padding: const EdgeInsets.only(left: 18),
//                                     child: Text( subMenu.label),
//                                   ), children: subMenu.options==null ? [] :
//                                   [
//                                     ... subMenu.options!.map((subSubMenu) {
//                                       return ListTile(
//                                           title:  GestureDetector(child: Padding(
//                                             padding: const EdgeInsets.only(left: 28),
//                                             child: Text ( subSubMenu.label),
//                                           ) ,
//                                               onTap: () {
//                                              //   Navigator.pop(context);
//                                               //  MenuClickFuncation(context, subSubMenu.label);
//
//                                               }));
//
//                                     }).toList()
//                                   ]
//                                   );
//                                 }
//                               }).toList()
//                             ]
//                             );
//                           }
//                         }).toList()
//                         ),
//                       );
//                     }).toList()
//                   ],
//                 )
//
//                 ,
//               ),
//
//
//               // ListView.separated(
//               //   scrollDirection: Axis.vertical,
//               //   shrinkWrap: true,
//               //     physics: NeverScrollableScrollPhysics(),
//               //   separatorBuilder: (context, counter) {
//               //     return Divider(height: 12.0);
//               //   },
//               //   itemBuilder: (context, counter) {
//               //     return CollapsingListTile(
//               //         onTap: () {
//               //           setState(() {
//               //             currentSelectedIndex = counter;
//               //           });
//               //         },
//               //         isSelected: currentSelectedIndex == counter,
//               //         title: navigationItems[counter].title,
//               //         icon: navigationItems[counter].icon,
//               //         animationController: _animationController,
//               //     );
//               //   },
//               //   itemCount: navigationItems.length,
//               // ),
//
//               SizedBox(
//                 height: 50.0,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//   // themeProvider.themeMode().textColor,
//   // themeProvider.themeMode().backgroundColor,
//   // themeProvider.themeMode().dividerColor,
//   // themeProvider.themeMode().boxSelectColorBackground);
//
//   void customBackground(MenuOption menuOption , Color textColor, Color backgourdColor, Color divder, Color highlightColor) {
//
//     TextStyle style = TextStyle(color: textColor, fontSize: 12);
//
//     PopupMenu menu = PopupMenu(
//       backgroundColor: backgourdColor,
//       lineColor: divder,
//       highlightColor: highlightColor,
//       maxColumn: 1,
//         items: [
//           MenuItem(title: 'Purchase Orders' , textStyle: style , textAlign: TextAlign.left),
//           MenuItem(title: 'Invoices', textStyle: style, textAlign: TextAlign.left),
//           MenuItem(title: 'Orders', textStyle: style, textAlign: TextAlign.left),
//           MenuItem(title: 'Quotations', textStyle: style, textAlign: TextAlign.left),
//
//         ],
//         onClickMenu: onClickMenu,
//         stateChanged: stateChanged,
//         onDismiss: onDismiss);
//     menu.show(widgetKey: menuOption.btnKey);
//   }
//
//   void stateChanged(bool isShow) {
//     print('menu is ${isShow ? 'showing' : 'closed'}');
//   }
//
//   void onClickMenu(MenuItemProvider item) {
//     print('Click menu -> ${item.menuTitle}');
//   }
//
//   void onDismiss() {
//     print('Menu is dismiss');
//   }
//
//
//   numberExistsDialog(BuildContext context) {
//     var numberDialog = Align(
//       alignment: Alignment(0, 1),
//       child: Material(
//         shape:
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//         child: Padding(
//           padding: const EdgeInsets.all(32.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 'Number Already Exists',
//                 style: TextStyle(color: Colors.red),
//                 textAlign: TextAlign.center,
//               ),
//               Text(
//                 'Use another number',
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return numberDialog;
//       },
//     );
//   }
// }
