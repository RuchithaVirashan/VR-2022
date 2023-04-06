import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
    final void Function()? pressedbutton;

  const SecondScreen({super.key, required this.pressedbutton});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 327,
      width: 268,
      child: Column(
        children: [
          const SizedBox(
            width: 152.0,
            height: 152.0,
            child: Image(
              image: AssetImage('assets/Group 33596n.png'),
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          SizedBox(
            width: 268.0,
            height: 93.0,
            child: Column(
              children: const [
                Text(
                  'Click Here',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Please click SCAN button',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(116, 118, 136, 1),
                  ),
                ),
                Text(
                  'for scan QR code',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(116, 118, 136, 1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 271.0,
            height: 51.0,
            child: ElevatedButton(
              onPressed: 
                pressedbutton,
              
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(86, 105, 255, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 93,
                  ),
                  Container(
                    height: 19,
                    width: 40,
                    child: const Text(
                      "SCAN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    // padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(61, 86, 240, 1),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
