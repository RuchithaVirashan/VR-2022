// import 'package:collection/collection.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:lottie/lottie.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import '../../global/constants.dart';
// import '../../store/application_state.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vr_app_2022/components/datagrid/player.dart';

class playerDataSource extends DataGridSource {
  playerDataSource({required List<Player> playerData}) {
    _playerData = playerData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.uuid),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<int>(columnName: 'marks', value: e.marks),
            ]))
        .toList();
  }

  List<DataGridRow> _playerData = [];

  @override
  List<DataGridRow> get rows => _playerData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
//   ShipmentDataSource(this._shipment, this.state, this.context) {
//     dataGridRows = _shipment
//         .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
//         .toList();
//   }

//   // List<Shipment> _shipment = [];
//   // CargoState state;
//   BuildContext context;

//   List<DataGridRow> dataGridRows = [];
//   // final CargoService _cargoService = CargoService();

//   Map<String, String> shipperDetails(
//     // CargoState state,
//     String sName,
//     String sEmail,
//     String sPostal,
//     String sState,
//     String sStreet,
//     String sSuburb,
//     String sTelephone,
//   ) {
//     Map<String, String> shipperDetails = {};
//     shipperDetails['email'] = sEmail;
//     shipperDetails['name'] = sName;
//     shipperDetails['street'] = sStreet;
//     shipperDetails['suburb'] = sSuburb;
//     shipperDetails['state'] = sState;
//     shipperDetails['postal'] = sPostal;
//     shipperDetails['telephone'] = sTelephone;
//     // shipperDetails['warehouse'] = state.location;

//     // print('shipperDetails $shipperDetails');
//     return shipperDetails;
//   }

//   Map<String, String> consigneeDetails(
//     String cName,
//     String cEmail,
//     String cPostal,
//     String cCountry,
//     String cStreet,
//     String cArea,
//     String cTelephone,
//     String cPassNoOrNIC,
//     String cPassCountry,
//   ) {
//     Map<String, String> consigneeDetails = {};
//     consigneeDetails['name'] = cName;
//     consigneeDetails['email'] = cEmail;
//     consigneeDetails['telephone'] = cTelephone;
//     consigneeDetails['street'] = cStreet;
//     consigneeDetails['area'] = cArea;
//     consigneeDetails['country'] = cCountry;
//     consigneeDetails['postal'] = cPostal;
//     consigneeDetails['passNoOrNIC'] = cPassNoOrNIC;
//     consigneeDetails['passCountry'] = cPassCountry;

//     // print('consigneeDetails $consigneeDetails');
//     return consigneeDetails;
//   }

//   // Map<String, dynamic> includeDetails() {
//   //   Map<String, dynamic> includeDetails = {};
//   //   includeDetails['addedItems'] = addedItems;
//   //   includeDetails['boxCount'] = _controllerBoxCount.text;
//   //   includeDetails['boxWeightList'] = boxWeightList;
//   //   includeDetails['price'] = '';
//   //   includeDetails['pickup'] =
//   //   isSelectDoorToDoor ? 'Door To Door' : 'Warehouse Pickup';
//   //   includeDetails['selectedItems'] = selectedItems;
//   //   includeDetails['formattedDate'] = formattedDate;
//   //
//   //   // print('includeDetails $includeDetails');
//   //   return includeDetails;
//   // }

//   /// Helps to hold the new value of all editable widget.
//   /// Based on the new value we will commit the new value into the corresponding
//   /// [DataGridCell] on [onSubmitCell] method.
//   dynamic newCellValue;

//   /// Help to control the editable text in [TextField] widget.
//   TextEditingController editingController = TextEditingController();

//   @override
//   List<DataGridRow> get rows => dataGridRows.isEmpty ? [] : dataGridRows;

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     Size size = MediaQuery.of(context).size;
//     double relativeWidth = size.width / Constants.referenceWidth;
//     double relativeHeight = size.height / Constants.referenceHeight;
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((dataGridCell) {
//       return Container(
//         alignment: (dataGridCell.columnName == 'id' ||
//                 dataGridCell.columnName == 'salary')
//             ? Alignment.center
//             : Alignment.centerLeft,
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: dataGridCell.columnName == 'salary'
//             ? Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       for (var selItems in dataGridCell.value)
//                         Flexible(
//                           child: Text(
//                             selItems,
//                             style: const TextStyle(
//                               fontSize: 12,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                     ]),
//               )
//             : dataGridCell.columnName == 'button'
//                 ? LayoutBuilder(builder:
//                     (BuildContext context, BoxConstraints constraints) {
//                     return ElevatedButton(
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) => CupertinoAlertDialog(
//                               title: Column(
//                                 children: [
//                                   Text('Are you sure?'),
//                                   Text('${row.getCells()[0].value.toString()}'),
//                                 ],
//                               ),
//                               content: Column(
//                                 children: [
//                                   Container(
//                                     child: Lottie.asset(
//                                         'assets/question_exit.json',
//                                         animate: true,
//                                         height: relativeHeight * 100,
//                                         width: relativeWidth * 100),
//                                   ),
//                                   Text(
//                                       'Do you want to edit values ${row.getCells()[0].value.toString()}.'),
//                                 ],
//                               ),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () =>
//                                       Navigator.of(context).pop(false),
//                                   child: Text('No'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () => Navigator.pushNamed(
//                                       context, '/modifyBox'),
//                                   child: Text('Yes'),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                         child: const Text('Details'));
//                   })
//                 : dataGridCell.columnName == 'isAvailable'
//                     ? Container(
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Checkbox(
//                           value: row.getCells()[19].value,
//                           onChanged: (value) {
//                             final index = dataGridRows.indexOf(row);
//                             _shipment[index].isAvailable = value!;
//                             print('click is available $value');
//                             row.getCells()[19] = DataGridCell(
//                                 value: value, columnName: 'isAvailable');
//                             notifyDataSourceListeners(
//                                 rowColumnIndex: RowColumnIndex(index, 19));
//                           },
//                         ))
//                     : Text(
//                         dataGridCell.value.toString(),
//                         style: const TextStyle(
//                           fontSize: 12,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//       );
//     }).toList());
//   }

//   // @override
//   // bool shouldRecalculateColumnWidths() {
//   //   return true;
//   // }

//   @override
//   Future<void> onCellSubmit(DataGridRow dataGridRow,
//       RowColumnIndex rowColumnIndex, GridColumn column) async {
//     final dynamic oldValue = dataGridRow
//             .getCells()
//             .firstWhereOrNull((DataGridCell dataGridCell) =>
//                 dataGridCell.columnName == column.columnName)
//             ?.value ??
//         '';

//     final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

//     if (newCellValue == null || oldValue == newCellValue) {
//       return;
//     }

//     if (column.columnName == 'id') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'id', value: newCellValue);
//       _shipment[dataRowIndex].id = newCellValue.toString();
//     } else if (column.columnName == 's_name') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 's_name', value: newCellValue);
//       _shipment[dataRowIndex].sName = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'shipperDetails',
//       //     shipperDetails(
//       //       state,
//       //       _shipment[dataRowIndex].sName,
//       //       _shipment[dataRowIndex].sEmail,
//       //       _shipment[dataRowIndex].sPostal,
//       //       _shipment[dataRowIndex].sState,
//       //       _shipment[dataRowIndex].sStreet,
//       //       _shipment[dataRowIndex].sSuburb,
//       //       _shipment[dataRowIndex].sTelephone,
//       //     ));
//     } else if (column.columnName == 's_email') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 's_email', value: newCellValue);
//       _shipment[dataRowIndex].sEmail = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'shipperDetails',
//       //     shipperDetails(
//       //       state,
//       //       _shipment[dataRowIndex].sName,
//       //       _shipment[dataRowIndex].sEmail,
//       //       _shipment[dataRowIndex].sPostal,
//       //       _shipment[dataRowIndex].sState,
//       //       _shipment[dataRowIndex].sStreet,
//       //       _shipment[dataRowIndex].sSuburb,
//       //       _shipment[dataRowIndex].sTelephone,
//       //     ));
//     } else if (column.columnName == 's_postal') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 's_postal', value: newCellValue);
//       _shipment[dataRowIndex].sPostal = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'shipperDetails',
//       //     shipperDetails(
//       //       state,
//       //       _shipment[dataRowIndex].sName,
//       //       _shipment[dataRowIndex].sEmail,
//       //       _shipment[dataRowIndex].sPostal,
//       //       _shipment[dataRowIndex].sState,
//       //       _shipment[dataRowIndex].sStreet,
//       //       _shipment[dataRowIndex].sSuburb,
//       //       _shipment[dataRowIndex].sTelephone,
//       //     ));
//     } else if (column.columnName == 's_state') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 's_state', value: newCellValue);
//       _shipment[dataRowIndex].sState = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'shipperDetails',
//       //     shipperDetails(
//       //       state,
//       //       _shipment[dataRowIndex].sName,
//       //       _shipment[dataRowIndex].sEmail,
//       //       _shipment[dataRowIndex].sPostal,
//       //       _shipment[dataRowIndex].sState,
//       //       _shipment[dataRowIndex].sStreet,
//       //       _shipment[dataRowIndex].sSuburb,
//       //       _shipment[dataRowIndex].sTelephone,
//       //     ));
//     } else if (column.columnName == 's_street') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 's_street', value: newCellValue);
//       _shipment[dataRowIndex].sStreet = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'shipperDetails',
//       //     shipperDetails(
//       //       state,
//       //       _shipment[dataRowIndex].sName,
//       //       _shipment[dataRowIndex].sEmail,
//       //       _shipment[dataRowIndex].sPostal,
//       //       _shipment[dataRowIndex].sState,
//       //       _shipment[dataRowIndex].sStreet,
//       //       _shipment[dataRowIndex].sSuburb,
//       //       _shipment[dataRowIndex].sTelephone,
//       //     ));
//     } else if (column.columnName == 's_suburb') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 's_suburb', value: newCellValue);
//       _shipment[dataRowIndex].sSuburb = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'shipperDetails',
//       //     shipperDetails(
//       //       state,
//       //       _shipment[dataRowIndex].sName,
//       //       _shipment[dataRowIndex].sEmail,
//       //       _shipment[dataRowIndex].sPostal,
//       //       _shipment[dataRowIndex].sState,
//       //       _shipment[dataRowIndex].sStreet,
//       //       _shipment[dataRowIndex].sSuburb,
//       //       _shipment[dataRowIndex].sTelephone,
//       //     ));
//     } else if (column.columnName == 's_telephone') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 's_telephone', value: newCellValue);
//       _shipment[dataRowIndex].sTelephone = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'shipperDetails',
//       //     shipperDetails(
//       //       state,
//       //       _shipment[dataRowIndex].sName,
//       //       _shipment[dataRowIndex].sEmail,
//       //       _shipment[dataRowIndex].sPostal,
//       //       _shipment[dataRowIndex].sState,
//       //       _shipment[dataRowIndex].sStreet,
//       //       _shipment[dataRowIndex].sSuburb,
//       //       _shipment[dataRowIndex].sTelephone,
//       //     ));
//     } else if (column.columnName == 'c_name') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'c_name', value: newCellValue);
//       _shipment[dataRowIndex].cName = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'consigneeDetails',
//       //     consigneeDetails(
//       //       _shipment[dataRowIndex].cName,
//       //       _shipment[dataRowIndex].cEmail,
//       //       _shipment[dataRowIndex].cPostal,
//       //       _shipment[dataRowIndex].cCountry,
//       //       _shipment[dataRowIndex].cStreet,
//       //       _shipment[dataRowIndex].cArea,
//       //       _shipment[dataRowIndex].cTelephone,
//       //       _shipment[dataRowIndex].cPassNoOrNIC,
//       //       _shipment[dataRowIndex].cPassCountry,
//       //     ));
//     } else if (column.columnName == 'c_email') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'c_email', value: newCellValue);
//       _shipment[dataRowIndex].cEmail = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'consigneeDetails',
//       //     consigneeDetails(
//       //       _shipment[dataRowIndex].cName,
//       //       _shipment[dataRowIndex].cEmail,
//       //       _shipment[dataRowIndex].cPostal,
//       //       _shipment[dataRowIndex].cCountry,
//       //       _shipment[dataRowIndex].cStreet,
//       //       _shipment[dataRowIndex].cArea,
//       //       _shipment[dataRowIndex].cTelephone,
//       //       _shipment[dataRowIndex].cPassNoOrNIC,
//       //       _shipment[dataRowIndex].cPassCountry,
//       //     ));
//     } else if (column.columnName == 'c_postal') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'c_postal', value: newCellValue);
//       _shipment[dataRowIndex].cPostal = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'consigneeDetails',
//       //     consigneeDetails(
//       //       _shipment[dataRowIndex].cName,
//       //       _shipment[dataRowIndex].cEmail,
//       //       _shipment[dataRowIndex].cPostal,
//       //       _shipment[dataRowIndex].cCountry,
//       //       _shipment[dataRowIndex].cStreet,
//       //       _shipment[dataRowIndex].cArea,
//       //       _shipment[dataRowIndex].cTelephone,
//       //       _shipment[dataRowIndex].cPassNoOrNIC,
//       //       _shipment[dataRowIndex].cPassCountry,
//       //     ));
//     } else if (column.columnName == 'c_country') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'c_country', value: newCellValue);
//       _shipment[dataRowIndex].cCountry = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'consigneeDetails',
//       //     consigneeDetails(
//       //       _shipment[dataRowIndex].cName,
//       //       _shipment[dataRowIndex].cEmail,
//       //       _shipment[dataRowIndex].cPostal,
//       //       _shipment[dataRowIndex].cCountry,
//       //       _shipment[dataRowIndex].cStreet,
//       //       _shipment[dataRowIndex].cArea,
//       //       _shipment[dataRowIndex].cTelephone,
//       //       _shipment[dataRowIndex].cPassNoOrNIC,
//       //       _shipment[dataRowIndex].cPassCountry,
//       //     ));
//     } else if (column.columnName == 'c_street') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'c_street', value: newCellValue);
//       _shipment[dataRowIndex].cStreet = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'consigneeDetails',
//       //     consigneeDetails(
//       //       _shipment[dataRowIndex].cName,
//       //       _shipment[dataRowIndex].cEmail,
//       //       _shipment[dataRowIndex].cPostal,
//       //       _shipment[dataRowIndex].cCountry,
//       //       _shipment[dataRowIndex].cStreet,
//       //       _shipment[dataRowIndex].cArea,
//       //       _shipment[dataRowIndex].cTelephone,
//       //       _shipment[dataRowIndex].cPassNoOrNIC,
//       //       _shipment[dataRowIndex].cPassCountry,
//       //     ));
//     } else if (column.columnName == 'c_area') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'c_area', value: newCellValue);
//       _shipment[dataRowIndex].cArea = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'consigneeDetails',
//       //     consigneeDetails(
//       //       _shipment[dataRowIndex].cName,
//       //       _shipment[dataRowIndex].cEmail,
//       //       _shipment[dataRowIndex].cPostal,
//       //       _shipment[dataRowIndex].cCountry,
//       //       _shipment[dataRowIndex].cStreet,
//       //       _shipment[dataRowIndex].cArea,
//       //       _shipment[dataRowIndex].cTelephone,
//       //       _shipment[dataRowIndex].cPassNoOrNIC,
//       //       _shipment[dataRowIndex].cPassCountry,
//       //     ));
//     } else if (column.columnName == 'c_telephone') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'c_telephone', value: newCellValue);
//       _shipment[dataRowIndex].cTelephone = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'consigneeDetails',
//       //     consigneeDetails(
//       //       _shipment[dataRowIndex].cName,
//       //       _shipment[dataRowIndex].cEmail,
//       //       _shipment[dataRowIndex].cPostal,
//       //       _shipment[dataRowIndex].cCountry,
//       //       _shipment[dataRowIndex].cStreet,
//       //       _shipment[dataRowIndex].cArea,
//       //       _shipment[dataRowIndex].cTelephone,
//       //       _shipment[dataRowIndex].cPassNoOrNIC,
//       //       _shipment[dataRowIndex].cPassCountry,
//       //     ));
//     } else if (column.columnName == 'c_passNoOrNIC') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(
//               columnName: 'c_passNoOrNIC', value: newCellValue);
//       _shipment[dataRowIndex].cPassNoOrNIC = newCellValue.toString();
//       print('index aaa ${_shipment[dataRowIndex].id}');
//       // consigneeDetails(state, _employees[dataRowIndex].designation);
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'consigneeDetails',
//       //     consigneeDetails(
//       //       _shipment[dataRowIndex].cName,
//       //       _shipment[dataRowIndex].cEmail,
//       //       _shipment[dataRowIndex].cPostal,
//       //       _shipment[dataRowIndex].cCountry,
//       //       _shipment[dataRowIndex].cStreet,
//       //       _shipment[dataRowIndex].cArea,
//       //       _shipment[dataRowIndex].cTelephone,
//       //       _shipment[dataRowIndex].cPassNoOrNIC,
//       //       _shipment[dataRowIndex].cPassCountry,
//       //     ));
//     } else if (column.columnName == 'c_passCountry') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(
//               columnName: 'c_passCountry', value: newCellValue);
//       _shipment[dataRowIndex].cPassCountry = newCellValue.toString();
//       // await _cargoService.updateDataGrid(
//       //     state.location,
//       //     state.finalDate,
//       //     _shipment[dataRowIndex].id,
//       //     'consigneeDetails',
//       //     consigneeDetails(
//       //       _shipment[dataRowIndex].cName,
//       //       _shipment[dataRowIndex].cEmail,
//       //       _shipment[dataRowIndex].cPostal,
//       //       _shipment[dataRowIndex].cCountry,
//       //       _shipment[dataRowIndex].cStreet,
//       //       _shipment[dataRowIndex].cArea,
//       //       _shipment[dataRowIndex].cTelephone,
//       //       _shipment[dataRowIndex].cPassNoOrNIC,
//       //       _shipment[dataRowIndex].cPassCountry,
//       //     ));
//       // }else if (column.columnName == 'button') {
//       //   dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//       //       const DataGridCell<String>(
//       //           columnName: 'button', value: null);
//     } else {
//       null;
//       // List newCellValueArray = [];
//       // newCellValueArray.addAll(_shipment[dataRowIndex].salary);
//       // print('index ${rowColumnIndex.columnIndex}');
//       // // newCellValueArray.removeAt(1);
//       // // newCellValueArray.insert(1, newCellValue);
//       // for (var i = 0; i < _shipment[dataRowIndex].salary.length; i++) {
//       //   dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//       //       DataGridCell<String>(columnName: 'salary', value: newCellValue);
//       //   // newCellValueArray.add(newCellValue);
//       //   // if (newCellValue != null && oldValue != newCellValue) {
//       //   //   newCellValueArray.removeAt(i);
//       //   //   newCellValueArray.add(newCellValue);
//       //   // } else {
//       //   // newCellValueArray.add(oldValue);
//       //   // }
//       //   _shipment[dataRowIndex].salary = newCellValueArray;
//       //   print('index bbb ${_shipment[dataRowIndex].salary}');
//       //   // await _cargoService.updateDataGrid(
//       //   //     state.location,
//       //   //     state.finalDate,
//       //   //     _shipment[dataRowIndex].id,
//       //   //     'area',
//       //   //     consigneeDetails(state, _shipment[dataRowIndex].cPassNoOrNIC,
//       //   //         _shipment[dataRowIndex].salary));
//       // }
//     }
//   }

//   // @override
//   // bool canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
//   //     GridColumn column) {
//   //   // Return false, to retain in edit mode.
//   //   return true; // or super.canSubmitCell(dataGridRow, rowColumnIndex, column);
//   // }

//   @override
//   Widget? buildEditWidget(DataGridRow dataGridRow,
//       RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
//     // Text going to display on editable widget
//     final String displayText = dataGridRow
//             .getCells()
//             .firstWhereOrNull((DataGridCell dataGridCell) =>
//                 dataGridCell.columnName == column.columnName)
//             ?.value
//             ?.toString() ??
//         '';

//     // The new cell value must be reset.
//     // To avoid committing the [DataGridCell] value that was previously edited
//     // into the current non-modified [DataGridCell].
//     newCellValue = null;

//     // final bool isNumericType =
//     //     column.columnName == 'id' || column.columnName == 'salary';
//     //
//     // // Holds regular expression pattern based on the column type.
//     // final RegExp regExp = _getRegExp(isNumericType, column.columnName);

//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       // alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
//       alignment: Alignment.centerLeft,
//       child: TextField(
//         autofocus: true,
//         controller: editingController..text = displayText,
//         textAlign: TextAlign.left,
//         // textAlign: isNumericType ? TextAlign.right : TextAlign.left,
//         autocorrect: false,
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
//         ),
//         // inputFormatters: <TextInputFormatter>[
//         //   FilteringTextInputFormatter.allow(regExp)
//         // ],
//         // keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
//         onChanged: (String value) {
//           if (value.isNotEmpty) {
//             // if (isNumericType) {
//             //   newCellValue = value;
//             // } else {
//             newCellValue = value;
//             // }
//           } else {
//             newCellValue = null;
//           }
//         },
//         onSubmitted: (String value) {
//           /// Call [CellSubmit] callback to fire the canSubmitCell and
//           /// onCellSubmit to commit the new value in single place.
//           submitCell();
//         },
//       ),
//     );
//   }

//   RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
//     return isNumericKeyBoard ? RegExp('[0-9]') : RegExp('[a-zA-Z ]');
//   }
// }
