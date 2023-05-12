import 'package:flutter/material.dart';
import 'package:vr_app_2022/components/profile_button.dart';
import 'package:vr_app_2022/screen/datagrid_page.dart';

import '../screen/qr-page.dart';
import '../service/auth_service.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('VRFOC2023'),
            ProfileButton(
              imgName: 'assets/sign-out.png',
              onPressed: () {
                AuthService().signOut();
                Navigator.pushNamed(context, '/signin');
              },
            )
          ],
        ),
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
