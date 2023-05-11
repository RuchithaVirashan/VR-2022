// import 'package:flutter/cupertino.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Player {
  /// Creates the employee class with required details.
  Player(this.uuid, this.name, this.marks);

  /// Id of an employee.
  late final String uuid;

  /// Name of an employee.
  late final String name;

  /// Salary of an employee.
  late String marks;

  DataGridRow getDataGridRow() {
    return DataGridRow(
      cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'id', value: uuid),
        DataGridCell<String>(columnName: 'name', value: name),
        DataGridCell<String>(columnName: 'marks', value: marks.toString())
      ],
    );
  }
}
