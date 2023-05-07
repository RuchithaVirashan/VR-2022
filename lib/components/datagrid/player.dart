// import 'package:flutter/cupertino.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Player {
  /// Creates the employee class with required details.
  Player(this.uuid, this.name, this.marks);

  /// Id of an employee.
  final String uuid;

  /// Name of an employee.
  final String name;

  /// Salary of an employee.
  final int marks;

  DataGridRow getDataGridRow() {
    return DataGridRow(
      cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'id', value: uuid),
        DataGridCell<String>(columnName: 'name', value: name),
        DataGridCell<int>(columnName: 'marks', value: marks)
      ],
    );
  }
}

// class Shipment {
//   Shipment(
//     this.id,
//     this.sStreet,
//     this.sName,
//     this.sSuburb,
//     this.sTelephone,
//     this.sState,
//     this.sPostal,
//     this.sEmail,
//     this.cStreet,
//     this.cName,
//     this.cArea,
//     this.cTelephone,
//     this.cCountry,
//     this.cPostal,
//     this.cEmail,
//     this.cPassNoOrNIC,
//     this.cPassCountry,
//     this.salary,
//     this.isAvailable,
//   );

//   String id;
//   String sStreet;
//   String sName;
//   String sSuburb;
//   String sTelephone;
//   String sState;
//   String sPostal;
//   String sEmail;
//   String cStreet;
//   String cName;
//   String cArea;
//   String cTelephone;
//   String cCountry;
//   String cPostal;
//   String cEmail;
//   String cPassNoOrNIC;
//   String cPassCountry;
//   List salary;
//   bool isAvailable;

//   DataGridRow getDataGridRow() {
//     return DataGridRow(
//       cells: <DataGridCell>[
//         DataGridCell<String>(columnName: 'id', value: id),
//         DataGridCell<String>(columnName: 's_name', value: sName),
//         DataGridCell<String>(columnName: 's_email', value: sEmail),
//         DataGridCell<String>(columnName: 's_telephone', value: sTelephone),
//         DataGridCell<String>(columnName: 's_street', value: sStreet),
//         DataGridCell<String>(columnName: 's_suburb', value: sSuburb),
//         DataGridCell<String>(columnName: 's_state', value: sState),
//         DataGridCell<String>(columnName: 's_postal', value: sPostal),
//         DataGridCell<String>(columnName: 'c_name', value: cName),
//         DataGridCell<String>(columnName: 'c_email', value: cEmail),
//         DataGridCell<String>(columnName: 'c_telephone', value: cTelephone),
//         DataGridCell<String>(columnName: 'c_street', value: cStreet),
//         DataGridCell<String>(columnName: 'c_area', value: cArea),
//         DataGridCell<String>(columnName: 'c_country', value: cCountry),
//         DataGridCell<String>(columnName: 'c_postal', value: cPostal),
//         DataGridCell<String>(columnName: 'c_passNoOrNIC', value: cPassNoOrNIC),
//         DataGridCell<String>(columnName: 'c_passCountry', value: cPassCountry),
//         DataGridCell<List>(columnName: 'salary', value: salary),
//         const DataGridCell<Widget>(columnName: 'button', value: null),
//         DataGridCell<bool>(columnName: 'isAvailable', value: isAvailable)
//       ],
//     );
//   }
// }
