// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:vr_app_2022/screen/qr-page.dart';

// class MainPage extends StatefulWidget {
//   final int indexPage;
//   const MainPage({
//     Key? key,
//     required this.indexPage,
//   }) : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _index = 0;
//   @override
//   void initState() {
//     super.initState();
//     _index = widget.indexPage;
//   }

//   Future<bool> _onWillPop() async {
//     final value = await showCupertinoDialog<bool>(
//       context: context,
//       builder: (context) => CupertinoAlertDialog(
//         title: Text('Are you sure?'),
//         content: Text('Do you want to exit an App'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: Text('No'),
//           ),
//           TextButton(
//             onPressed: () => SystemNavigator.pop(),
//             child: Text('Yes'),
//           ),
//         ],
//       ),
//     );
//     if (value != null) {
//       return Future.value(value);
//     } else {
//       return Future.value(false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget widget = Container();
//     switch (_index) {
//       case 0:
//         widget = QRViewPage();
//         break;

//       case 1:
//         widget = Text("QRView");
//         break;
//     }
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         body: widget,
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _index,
//           onTap: (int index) => setState(() => _index = index),
//           selectedItemColor: Color.fromRGBO(86, 105, 255, 1),
//           //unselectedItemColor: Color.fromRGBO(116, 118, 136, 1),
//           //type: BottomNavigationBarType.fixed,
//           items: const [
//              BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//             backgroundColor: Colors.red,
//           ),
//             BottomNavigationBarItem(
//               icon: ImageIcon(
//                 AssetImage("assets/Scan.png"),
//               ),
//               label: 'Scan',
//             ),
//           ],
//         ),

//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:vr_app_2022/screen/datagrid_page.dart';

import '../screen/qr-page.dart';

class MainPage extends StatefulWidget {
  final int indexPage;
  const MainPage({
    Key? key,
    required this.indexPage,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.indexPage;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = Container();
    switch (_selectedIndex) {
      case 0:
        widget = QRViewPage();
        break;

      case 1:
        widget = DataGridView();
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('VRFOC2023'),
      ),
      body: widget,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_4x4),
            label: 'Data',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
