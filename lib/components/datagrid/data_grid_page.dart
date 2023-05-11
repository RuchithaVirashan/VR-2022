import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/vr_player_model.dart';
import '../scanpage/scan_button_page.dart';
import 'player.dart';
import 'player_datasource.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class DataGridPage extends StatefulWidget {
  final List<Player> player;
  final String tabname;

  const DataGridPage({super.key, required this.player, required this.tabname});

  @override
  State<DataGridPage> createState() => _DataGridPageState();
}

class _DataGridPageState extends State<DataGridPage> {
  // List<Player> player = <Player>[];
  late PlayerDataSource playerrDataSource;
  late final DataGridController _dataGridController;

  @override
  void initState() {
    super.initState();
    // player = getPlayerData();
    setState(() {
      playerrDataSource =
          PlayerDataSource(playerData: widget.player, tabname: widget.tabname);
      _dataGridController = DataGridController();
    });
  }

  // List<Player> getPlayerData() {
  //   List<Player> players = [];

  //   widget.vrplayerList.forEach((key, value) {
  //     players.add(Player(value.uuid, value.name, value.marks));
  //   });

  //   print('playerrr $player');

  //   return players;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              headerColor: const Color.fromRGBO(116, 118, 136, 0.3),
              frozenPaneElevation: 0.0,
              frozenPaneLineColor: const Color.fromRGBO(116, 118, 136, 0.3),
              frozenPaneLineWidth: 1.5,
              sortIconColor: const Color.fromRGBO(86, 105, 255, 1),
              filterIcon: Builder(
                builder: (context) {
                  Widget? icon;
                  String columnName = '';
                  context.visitAncestorElements((element) {
                    if (element is GridHeaderCellElement) {
                      columnName = element.column.columnName;
                    }
                    return true;
                  });
                  var column = playerrDataSource.filterConditions.keys
                      .where((element) => element == columnName)
                      .isEmpty;
                  if (!column) {
                    icon = const Icon(
                      Icons.filter_alt_outlined,
                      size: 18,
                      color: Color.fromRGBO(61, 86, 240, 1),
                    );
                  }
                  return icon ??
                      const Icon(
                        Icons.filter_alt_off_outlined,
                        size: 18,
                        color: Color.fromRGBO(206, 37, 98, 1),
                      );
                },
              ),
            ),
            child: SfDataGrid(
              source: playerrDataSource,
              columnWidthMode: ColumnWidthMode.fill,
              defaultColumnWidth: 120,
              allowSorting: true,
              allowFiltering: true,
              allowEditing: true,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              // columnWidthMode: ColumnWidthMode.fill,
              editingGestureType: EditingGestureType.doubleTap,
              controller: _dataGridController,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              frozenColumnsCount: 1,
              allowColumnsResizing: true,
              // onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
              //   setState(() {
              //     columnWidths[details.column.columnName] = details.width;
              //   });
              //   return true;
              // },
              // headerRowHeight: 70,
              // shrinkWrapRows: true,
              // onQueryRowHeight: (details) {
              //   return details.getIntrinsicRowHeight(details.rowIndex);
              // },
              // isScrollbarAlwaysShown: true,
              // horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
              // verticalScrollPhysics: const NeverScrollableScrollPhysics(),
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'id',
                    allowEditing: false,
                    label: Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: Text(
                          'ID',
                        ))),
                GridColumn(
                    columnName: 'name',
                    allowEditing: false,
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Name'))),
                GridColumn(
                    columnName: 'marks',
                    allowEditing: true,
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Marks'))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
// class EmployeeDataSource extends DataGridSource {
//   /// Creates the employee data source class with required details.
  
// }
