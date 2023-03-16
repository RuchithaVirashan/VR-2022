import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../global/constants.dart';
import '../models/vr_user_model.dart';

class QRViewPage extends StatefulWidget {
  const QRViewPage({Key? key}) : super(key: key);

  @override
  State<QRViewPage> createState() => _QRViewPageState();
}

class _QRViewPageState extends State<QRViewPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  var isLoading = false;
  var draft = <dynamic>[];
  var draftUser = <dynamic>[];
  String loadingStatus = "";
  Map<String, VRUser> vruserList = {};

  void fetchData() async {
    Response response;
    setState(() {
      loadingStatus = "loading";
    });
    try {
      response = await Dio().get(
          "https://registervr-2c445-default-rtdb.firebaseio.com/1eoHHF9lyzyOqmH8-SCHMo2S3RXpm0Cc-G4o9Rc9l16U.json");
      print(response);
      if (response.statusCode == 200) {
        VRUserResponse vruserResponse = VRUserResponse.fromJson(response.data);

        setState(() {
          vruserList = vruserResponse.vruserList;
        });
        
        print("Ruchitha ${vruserList["VRFOC230001"]!.gametype}");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void didChangeDependencies() {
    fetchData();

    super.didChangeDependencies();
  }
  // final UserModel _userModel = UserModel();
  // final CargoModel _cargoModel = CargoModel();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  // addStore(String? code) async {
  //   if (kDebugMode) {
  //     print('code $code');
  //   }
  //   if (code?.length == 20) {
  //     draft = await _cargoModel.getDraft(code.toString(), context);
  //     draftUser = await _userModel.getShipper(draft[3]);
  //     if (draft.isNotEmpty && draftUser.isNotEmpty) {
  //       if (mounted) {
  //         StoreProvider.of<ApplicationState>(context).dispatch(
  //           AssignShipper(
  //             userId: draft[3],
  //             email: draftUser[0]['email'],
  //             name: draftUser[0]['name'],
  //             telephoneNumber: draftUser[0]['telephoneNumber'],
  //             street: draft[0][0]['street'],
  //             suburb: draft[0][0]['suburb'],
  //             state: draft[0][0]['state'],
  //             postal: draft[0][0]['postal'],
  //             warehouse: draft[0][0]['warehouse'],
  //           ),
  //         );
  //         StoreProvider.of<ApplicationState>(context).dispatch(
  //           AssignConsignee(
  //             conEmail: draft[1][0]['email'],
  //             conName: draft[1][0]['name'],
  //             conTelephoneNumber: draft[1][0]['telephone'],
  //             conStreet: draft[1][0]['street'],
  //             conCity: draft[1][0]['area'],
  //             conCountry: draft[1][0]['country'],
  //             conPostal: draft[1][0]['postal'],
  //             conPassNo: draft[1][0]['passNoOrNIC'],
  //             conPassCountry: draft[1][0]['passCountry'],
  //           ),
  //         );
  //         StoreProvider.of<ApplicationState>(context).dispatch(
  //           AssignItems(
  //             boxCount: draft[2][0]['boxCount'],
  //             pickup: draft[2][0]['pickup'],
  //             price: draft[2][0]['price'],
  //             selectedItems: draft[2][0]['selectedItems'],
  //             addedItems: draft[2][0]['addedItems'],
  //             boxWeightList: draft[2][0]['boxWeightList'],
  //           ),
  //         );
  //         StoreProvider.of<ApplicationState>(context).dispatch(
  //           AssignDraftId(
  //             draftDocId: code.toString(),
  //           ),
  //         );
  //       }
  //       if (mounted) {
  //         Navigator.pushNamed(context, '/draft');
  //       }
  //     } else {
  //       if (mounted) {
  //         showQRErrorDialog(context, 'Scanned QR not valid');
  //       }
  //     }
  //   } else {
  //     showQRErrorDialog(context, 'Scanned QR not valid');
  //   }
  // }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controller.stopCamera();
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double relativeWidth = size.width / Constants.referenceWidth;
    double relativeHeight = size.height / Constants.referenceHeight;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Stack(
              children: [
                Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Visibility(
                      visible: result == null ? true : false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Lottie.asset('assets/scan_effect_ing.json',
                                animate: true),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: result != null
                          ? Text(
                              '${describeEnum(result!.format)} scanned successfully',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Double tap to scan a code',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    // Visibility(
                    //   visible: result != null ? true : false,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(
                    //         top: relativeHeight * 32.0,
                    //         left: relativeWidth * 52.0,
                    //         right: relativeWidth * 52.0),
                    //     child: ActionButton(
                    //       title: 'CONTINUE',
                    //       titleX: 70.0,
                    //       iconName: Icons.arrow_forward_ios,
                    //       iconX: 50.0,
                    //       buttonC: Color.fromRGBO(86, 105, 255, 1),
                    //       circleC: Color.fromRGBO(61, 86, 240, 1),
                    //       titleC: Colors.white,
                    //       relativeHeight: relativeHeight,
                    //       relativeWidth: relativeWidth,
                    //       titleW: 90,
                    //       onPressed: () {
                    //         addStore(result!.code);
                    //         controller?.stopCamera();
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: relativeHeight * 30.0,
                    // ),
                  ],
                ),
              ],
            ),
          );
  }
}
