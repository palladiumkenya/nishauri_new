// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
//
// class BLEService {
//   final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;
//
//   Future<BluetoothDevice?> connectToDevice(String deviceName) async {
//     _flutterBlue.startScan(timeout: Duration(seconds: 4));
//
//     BluetoothDevice? targetDevice;
//     await for (ScanResult scanResult in _flutterBlue.scanResults) {
//       if (scanResult.device.name == deviceName) {
//         targetDevice = scanResult.device;
//         break;
//       }
//     }
//
//     _flutterBlue.stopScan();
//     if (targetDevice != null) {
//       await targetDevice.connect();
//     }
//     return targetDevice;
//   }
//
//   Future<BloodPressure?> readBloodPressureData(BluetoothDevice device) async {
//     List<BluetoothService> services = await device.discoverServices();
//     for (BluetoothService service in services) {
//       for (BluetoothCharacteristic characteristic in service.characteristics) {
//         if (characteristic.properties.read) {
//           List<int> value = await characteristic.read();
//           // Parse value to BloodPressure
//           if (value.length >= 3) {
//             int systolic = value[0];
//             int diastolic = value[1];
//             int heartRate = value[2];
//
//             return BloodPressure(
//               systolic: systolic,
//               diastolic: diastolic,
//               heartRate: heartRate,
//               measurementTime: DateTime.now(),
//             );
//           }
//         }
//       }
//     }
//     return null;
//   }
// }
