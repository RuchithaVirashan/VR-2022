import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/vr_player_model.dart';
import 'player.dart';
import 'player_datasource.dart';

class DataGridPage extends StatefulWidget {
  final List<Player> player;

  const DataGridPage({super.key, required this.player});

  @override
  State<DataGridPage> createState() => _DataGridPageState();
}

class _DataGridPageState extends State<DataGridPage> {
  // List<Player> player = <Player>[];
  late playerDataSource playerrDataSource;

  @override
  void initState() {
    super.initState();
    // player = getPlayerData();
    playerrDataSource = playerDataSource(playerData: widget.player);
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
    return SfDataGrid(
      source: playerrDataSource,
      columnWidthMode: ColumnWidthMode.fill,
      columns: <GridColumn>[
        GridColumn(
            columnName: 'id',
            label: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  'ID',
                ))),
        GridColumn(
            columnName: 'name',
            label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text('Name'))),
        GridColumn(
            columnName: 'marks',
            label: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text('marks'))),
      ],
    );
  }
}



/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
// class EmployeeDataSource extends DataGridSource {
//   /// Creates the employee data source class with required details.
  
// }
