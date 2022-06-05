import 'package:flutter/material.dart';
import 'package:payroll/modals/widgets/DataTableModel.dart';
import 'package:payroll/values/AppColors.dart';

class DataTableWidget extends StatefulWidget {
  DataTableModel data;
  DataTableWidget( this.data);
  DTS? dts ;
  int rowPerPage =  10 ; // PaginatedDataTable.defaultRowsPerPage;

  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {

  @override
  void initState() {

    widget.dts = new DTS(widget.data.rows);
    print(widget.data.rows.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: PaginatedDataTable(
        header: Text("Users"),
        columns: widget.data.columns.map((e) {
          return DataColumn(
            numeric: e.isNumeric,
            label: Text(
              e.name,
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: AppColors.headingColor),
            ),
          );
        }).toList(),
        source: widget.dts!,
        rowsPerPage: widget.rowPerPage,
        onRowsPerPageChanged: (r){
          setState(() {
            widget.rowPerPage = r!;
          });
        },
      ),

      // child: DataTable(
      //   columns: widget.data.columns.map((e) {
      //     return DataColumn(
      //       numeric: e.isNumeric,
      //       label: Text(
      //         e.name,
      //         style:
      //             TextStyle(fontWeight: FontWeight.w600, color: headingColor),
      //       ),
      //     );
      //   }).toList(),
      //   rows: widget.data.rows.map((e) {
      //     print(e);
      //     return DataRow(
      //         cells: e.map((rowCell) {
      //       return DataCell(Text("${rowCell.toString()}"));
      //     }).toList());
      //   }).toList(),
      // ),


    );
  }


}

class DTS extends DataTableSource{
  List<List<Object>> data;
  DTS(this.data);

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells:

      data[index].map((rowCell) {
            return DataCell(Text("${rowCell.toString()}"));
          }).toList()
      // [
      //   DataCell(Text("asdf $index")),
      //   DataCell(Text("asdf $index")),
      //   DataCell(Text("asdf $index")),
      //   DataCell(Text("asdf $index")),
      // ]

    );
  }



  @override
  bool get isRowCountApproximate => false;

  @override

  int get rowCount =>   data.length;

  @override

  int get selectedRowCount => 0;

}
