import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:lottie/lottie.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import '../../global/constants.dart';
// import '../../store/application_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:vr_app_2022/components/datagrid/player.dart';

class PlayerDataSource extends DataGridSource {
  PlayerDataSource({
    required this.playerData,
    required this.tabname,
  }) {
    dataGridRows = playerData
        .map<DataGridRow>((dataGridRow) => dataGridRow.getDataGridRow())
        .toList();
  }

  List<Player> playerData = [];
  String tabname = '';
  List<DataGridRow> dataGridRows = [];

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows.isEmpty ? [] : dataGridRows;

  // List<DataGridRow> get rows => _playerData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    print('marks $playerData');
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column) async {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == 'id') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'id', value: newCellValue);
      playerData[dataRowIndex].uuid = newCellValue.toString();
    } else if (column.columnName == 'name') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(columnName: 'name', value: newCellValue);
      playerData[dataRowIndex].name = newCellValue.toString();
    } else if (column.columnName == 'marks') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: 'marks', value: newCellValue.toString());
      playerData[dataRowIndex].marks = newCellValue.toString();
      print('mark change');
      try {
        await updateMark(playerData[dataRowIndex].uuid, tabname,
            int.tryParse(newCellValue.toString()) ?? 0);
      } catch (e) {
        print('Failed to update marks: ${e.toString()}');
      }
    }
  }

  @override
  Future<bool> canSubmitCell(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column) async {
    // Add your synchronous logic here...
    return true; // Return a Future<bool> value.
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    // final bool isNumericType =
    //     column.columnName == 'id' || column.columnName == 'salary';
    //
    // // Holds regular expression pattern based on the column type.
    // final RegExp regExp = _getRegExp(isNumericType, column.columnName);

    return Container(
      padding: const EdgeInsets.all(8.0),
      // alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      alignment: Alignment.center,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: TextAlign.center,
        // textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        autocorrect: false,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            // if (isNumericType) {
            //   newCellValue = value;
            // } else {
            newCellValue = value;
            // }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          /// Call [CellSubmit] callback to fire the canSubmitCell and
          /// onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  Future<void> updateMark(String uuId, String tabname, int newMark) async {
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child(tabname).child(uuId);
    log('mark uppp $uuId , $tabname, $newMark');
    Map<String, dynamic> updatedData = {
      'marks': newMark,
    };
    log('upppp $updatedData ${reference.key}');

    await reference.update(updatedData);
  }
}
