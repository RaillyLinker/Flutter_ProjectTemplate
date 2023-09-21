// (external)
import 'package:permission_handler/permission_handler.dart';

// [전역 함수 작성 파일]
// 프로그램 전역에서 사용할 함수들은 여기에 모아둡니다.

// -----------------------------------------------------------------------------
// (입력값 Permission 리스트가 전부 승인되었는지 결과를 반환)
Future<bool> allPermissionGrantedAsync(List<Permission> permissions) async {
  bool isAllGranted = true;
  for (Permission permission in permissions) {
    PermissionStatus status = await permission.status;
    if (status.isDenied) {
      isAllGranted = false;
      break;
    }
  }

  return isAllGranted;
}

// (권한 요청 결과 코드 분류)
// requiredPermissions.request() 로 얻어온 결과를 코드로 변경
// 1 : 권한이 하나라도 isPermanentlyDenied
// 2 : isPermanentlyDenied 는 하나도 없지만, 권한이 하나라도 isDenied
// 3 : 모든 권한이 Granted
int getPermissionsResultCode(
    Map<Permission, PermissionStatus> permissionRequests) {
  int resultCode = 3;

  bool isPermanentlyDenied = false;
  bool isDenied = false;

  permissionRequests.forEach((permission, permissionStatus) {
    if (permissionStatus.isPermanentlyDenied) {
      isPermanentlyDenied = true;
    } else if (permissionStatus.isDenied) {
      isDenied = true;
    }
  });

  if (isPermanentlyDenied) {
    resultCode = 1;
  } else if (isDenied) {
    resultCode = 2;
  }

  return resultCode;
}
