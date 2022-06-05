

class DataTableModel {

  List<DataTableColumnModel> columns;
  List<List<Object>> rows;

  DataTableModel(this.columns, this.rows);
}


class DataTableColumnModel {
  String name;
  bool isNumeric;

  DataTableColumnModel({this.name= "", this.isNumeric = false } );
}

