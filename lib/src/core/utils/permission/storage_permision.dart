import 'package:permission_handler/permission_handler.dart';

Future<bool> permissionStorageRequest() async {
  PermissionStatus result;
  result = await Permission.storage.request();
  if (result.isGranted) {
    return true;
  } else {
    return false;
  }
}
