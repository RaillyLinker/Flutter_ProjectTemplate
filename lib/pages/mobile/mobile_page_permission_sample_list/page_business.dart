// (external)
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_classes/todo_gc_delete.dart'
    as gc_template_classes;
import 'package:flutter_project_template/dialogs/all/all_dialog_yes_or_no/dialog_widget.dart'
    as all_dialog_yes_or_no;
import 'package:flutter_project_template/dialogs/all/all_dialog_yes_or_no/dialog_widget_business.dart'
    as all_dialog_yes_or_no_business;
import 'package:flutter_project_template/global_data/gd_const.dart' as gd_const;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// todo : 템플릿 적용
// todo location serviceStatus.isEnabled 체크

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageBusiness {
  PageBusiness(this._context) {
    pageViewModel = PageViewModel(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // BLoC 객체 모음
  late BLocObjects blocObjects;

  // 페이지 생명주기 관련 states
  final gc_template_classes.PageLifeCycleStates pageLifeCycleStates =
      gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // 페이지 뷰모델 객체
  late PageViewModel pageViewModel;

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (onPageCreateAsync 실행 전 PageInputVo 체크)
  // onPageCreateAsync 과 완전히 동일하나, 입력값 체크만을 위해 분리한 생명주기
  Future<void> onCheckPageInputVoAsync(GoRouterState goRouterState) async {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    pageInputVo = page_entrance.PageInputVo();
  }

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!!
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!!

    // Camera 권한 여부 확인
    int cameraPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.camera);

    if (cameraPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.camera.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[cameraPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // contacts 권한 여부 확인
    int contactsPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.contacts);

    if (contactsPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.contacts.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[contactsPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // mediaLibrary 권한 여부 확인
    int mediaLibraryPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.mediaLibrary);

    if (mediaLibraryPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.mediaLibrary.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[mediaLibraryPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // microphone 권한 여부 확인
    int microphonePermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.microphone);

    if (microphonePermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.microphone.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[microphonePermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // phone 권한 여부 확인
    int phonePermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.phone);

    if (phonePermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.phone.status;
      SampleItem sampleItem = pageViewModel.allSampleList[phonePermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // reminders 권한 여부 확인
    int remindersPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.reminders);

    if (remindersPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.reminders.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[remindersPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // sensors 권한 여부 확인
    int sensorsPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.sensors);

    if (sensorsPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.sensors.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[sensorsPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;

        if (Platform.isAndroid) {
          // android 일때
          PermissionStatus sensorsAlwaysPs =
              await Permission.sensorsAlways.status;

          if (sensorsAlwaysPs.isGranted) {
            pageViewModel.sensorsAlways = true;
          } else {
            pageViewModel.sensorsAlways = false;
          }
        }
      } else {
        sampleItem.isChecked = false;

        if (Platform.isAndroid) {
          // android 일때
          pageViewModel.sensorsAlways = false;
        }
      }
      blocObjects.blocSampleList.refresh();
    }

    // sms 권한 여부 확인
    int smsPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.sms);

    if (smsPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.sms.status;
      SampleItem sampleItem = pageViewModel.allSampleList[smsPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // speech 권한 여부 확인
    int speechPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.speech);

    if (speechPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.speech.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[speechPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // locationWhenInUse 권한 여부 확인
    int locationWhenInUsePermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.locationWhenInUse);

    if (locationWhenInUsePermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.locationWhenInUse.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[locationWhenInUsePermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;

        if (Platform.isAndroid) {
          // android 일때
          PermissionStatus locationAlwaysPs =
              await Permission.locationAlways.status;

          if (locationAlwaysPs.isGranted) {
            pageViewModel.androidLocationAlways = true;
          } else {
            pageViewModel.androidLocationAlways = false;
          }
        }
      } else {
        sampleItem.isChecked = false;

        if (Platform.isAndroid) {
          // android 일때
          pageViewModel.androidLocationAlways = false;
        }
      }
      blocObjects.blocSampleList.refresh();
    }

    // locationAlways 권한 여부 확인
    int locationAlwaysPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.locationAlways);

    if (locationAlwaysPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.locationAlways.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[locationAlwaysPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // storage 권한 여부 확인
    int storagePermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.storage);

    if (storagePermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.storage.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[storagePermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // photos 권한 여부 확인
    int photosPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.photos);

    if (photosPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.photos.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[photosPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // videos 권한 여부 확인
    int videosPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.videos);

    if (videosPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.videos.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[videosPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // audio 권한 여부 확인
    int audioPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.audio);

    if (audioPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.audio.status;
      SampleItem sampleItem = pageViewModel.allSampleList[audioPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // manageExternalStorage 권한 여부 확인
    int manageExternalStoragePermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.manageExternalStorage);

    if (manageExternalStoragePermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.manageExternalStorage.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[manageExternalStoragePermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // photosAddOnly 권한 여부 확인
    int photosAddOnlyPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.photosAddOnly);

    if (photosAddOnlyPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.photosAddOnly.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[photosAddOnlyPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // accessMediaLocation 권한 여부 확인
    int accessMediaLocationPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.accessMediaLocation);

    if (accessMediaLocationPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.accessMediaLocation.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[accessMediaLocationPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // ignoreBatteryOptimizations 권한 여부 확인
    int ignoreBatteryOptimizationsPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum ==
            SampleItemEnum.ignoreBatteryOptimizations);

    if (ignoreBatteryOptimizationsPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.ignoreBatteryOptimizations.status;
      SampleItem sampleItem = pageViewModel
          .allSampleList[ignoreBatteryOptimizationsPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // activityRecognition 권한 여부 확인
    int activityRecognitionPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.activityRecognition);

    if (activityRecognitionPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.activityRecognition.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[activityRecognitionPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // systemAlertWindow 권한 여부 확인
    int systemAlertWindowPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.systemAlertWindow);

    if (systemAlertWindowPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.systemAlertWindow.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[systemAlertWindowPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // requestInstallPackages 권한 여부 확인
    int requestInstallPackagesPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.requestInstallPackages);

    if (requestInstallPackagesPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.requestInstallPackages.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[requestInstallPackagesPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // accessNotificationPolicy 권한 여부 확인
    int accessNotificationPolicyPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum ==
            SampleItemEnum.accessNotificationPolicy);

    if (accessNotificationPolicyPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.accessNotificationPolicy.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[accessNotificationPolicyPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // nearbyWifiDevices 권한 여부 확인
    int nearbyWifiDevicesPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.nearbyWifiDevices);

    if (nearbyWifiDevicesPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.nearbyWifiDevices.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[nearbyWifiDevicesPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // scheduleExactAlarm 권한 여부 확인
    int scheduleExactAlarmPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.scheduleExactAlarm);

    if (scheduleExactAlarmPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.scheduleExactAlarm.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[scheduleExactAlarmPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // notification 권한 여부 확인
    int notificationPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.notification);

    if (notificationPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.notification.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[notificationPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // calendarFullAccess 권한 여부 확인
    int calendarFullAccessPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.calendarFullAccess);

    if (calendarFullAccessPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.calendarFullAccess.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[calendarFullAccessPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // appTrackingTransparency 권한 여부 확인
    int appTrackingTransparencyPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum ==
            SampleItemEnum.appTrackingTransparency);

    if (appTrackingTransparencyPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.appTrackingTransparency.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[appTrackingTransparencyPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // criticalAlerts 권한 여부 확인
    int criticalAlertsPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.criticalAlerts);

    if (criticalAlertsPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.criticalAlerts.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[criticalAlertsPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // bluetooth 권한 여부 확인
    int bluetoothPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.bluetooth);

    if (bluetoothPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.bluetooth.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[bluetoothPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // bluetoothScan 권한 여부 확인
    int bluetoothScanPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.bluetoothScan);

    if (bluetoothScanPermissionIndex != -1) {
      PermissionStatus permissionStatus = await Permission.bluetoothScan.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[bluetoothScanPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // bluetoothAdvertise 권한 여부 확인
    int bluetoothAdvertisePermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.bluetoothAdvertise);

    if (bluetoothAdvertisePermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.bluetoothAdvertise.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[bluetoothAdvertisePermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // bluetoothConnect 권한 여부 확인
    int bluetoothConnectPermissionIndex = pageViewModel.allSampleList
        .indexWhere((samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.bluetoothConnect);

    if (bluetoothConnectPermissionIndex != -1) {
      PermissionStatus permissionStatus =
          await Permission.bluetoothConnect.status;
      SampleItem sampleItem =
          pageViewModel.allSampleList[bluetoothConnectPermissionIndex];

      if (permissionStatus.isGranted) {
        sampleItem.isChecked = true;
      } else {
        sampleItem.isChecked = false;
      }
      blocObjects.blocSampleList.refresh();
    }

    // todo : 추가 및 수정
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!!
  }

  // (페이지 종료 (강제 종료, web 에서 브라우저 뒤로가기 버튼을 눌렀을 때는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!!
  }

  // (Page Pop 요청)
  // context.pop() 호출 직후 호출
  // return 이 true 라면 onWidgetPause 부터 onPageDestroyAsync 까지 실행 되며 페이지 종료
  // return 이 false 라면 pop 되지 않고 그대로 대기
  Future<bool> onPageWillPopAsync() async {
    // !!!onWillPop 로직 작성!!!

    return true;
  }

////
// [비즈니스 함수]
// !!!외부에서 사용할 비즈니스 로직은 아래에 공개 함수로 구현!!!
// ex :
//   void changeSampleNumber(int newSampleNumber) {
//     // BLoC 위젯 관련 상태 변수 변경
//     pageViewModel.sampleNumber = newSampleNumber;
//     // BLoC 위젯 변경 트리거 발동
//     blocObjects.blocSample.refresh();
//   }

  // (리스트 아이템 클릭 리스너)
  Future<void> onRouteListItemClickAsync(int index) async {
    SampleItem sampleItem = pageViewModel.allSampleList[index];

    switch (sampleItem.sampleItemEnum) {
      case SampleItemEnum.camera:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus = await Permission.camera.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.camera.request();

              PermissionStatus status = await Permission.camera.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.contacts:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.contacts.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.contacts.request();

              PermissionStatus status = await Permission.contacts.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.mediaLibrary:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.mediaLibrary.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.mediaLibrary.request();

              PermissionStatus status = await Permission.mediaLibrary.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.microphone:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.microphone.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.microphone.request();

              PermissionStatus status = await Permission.microphone.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.phone:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus = await Permission.phone.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              // phone 권한은 전화 로그와 전화 걸기 권한을 모두 요청합니다.
              await Permission.phone.request();

              PermissionStatus status = await Permission.phone.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.reminders:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.reminders.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.reminders.request();

              PermissionStatus status = await Permission.reminders.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.sensors:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus = await Permission.sensors.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.sensors.request();

              PermissionStatus status = await Permission.sensors.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.sms:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus = await Permission.sms.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.sms.request();

              PermissionStatus status = await Permission.sms.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.speech:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus = await Permission.speech.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.speech.request();

              PermissionStatus status = await Permission.speech.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.locationWhenInUse:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.locationWhenInUse.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.locationWhenInUse.request();

              PermissionStatus status =
                  await Permission.locationWhenInUse.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.locationAlways:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.locationAlways.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.locationAlways.request();

              PermissionStatus status = await Permission.locationAlways.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.storage:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus = await Permission.storage.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.storage.request();

              PermissionStatus status = await Permission.storage.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.photos:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus = await Permission.photos.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.photos.request();

              PermissionStatus status = await Permission.photos.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.videos:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus = await Permission.videos.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.videos.request();

              PermissionStatus status = await Permission.videos.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.audio:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus = await Permission.audio.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.audio.request();

              PermissionStatus status = await Permission.audio.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.manageExternalStorage:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.manageExternalStorage.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.manageExternalStorage.request();

              PermissionStatus status =
                  await Permission.manageExternalStorage.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.photosAddOnly:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.photosAddOnly.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.photosAddOnly.request();

              PermissionStatus status = await Permission.photosAddOnly.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.accessMediaLocation:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.accessMediaLocation.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.accessMediaLocation.request();

              PermissionStatus status =
                  await Permission.accessMediaLocation.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.ignoreBatteryOptimizations:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.ignoreBatteryOptimizations.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.ignoreBatteryOptimizations.request();

              PermissionStatus status =
                  await Permission.ignoreBatteryOptimizations.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.activityRecognition:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.activityRecognition.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.activityRecognition.request();

              PermissionStatus status =
                  await Permission.activityRecognition.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.systemAlertWindow:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.systemAlertWindow.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.systemAlertWindow.request();

              PermissionStatus status =
                  await Permission.systemAlertWindow.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.requestInstallPackages:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.requestInstallPackages.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.requestInstallPackages.request();

              PermissionStatus status =
                  await Permission.requestInstallPackages.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.accessNotificationPolicy:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.accessNotificationPolicy.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.accessNotificationPolicy.request();

              PermissionStatus status =
                  await Permission.accessNotificationPolicy.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.nearbyWifiDevices:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.nearbyWifiDevices.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.nearbyWifiDevices.request();

              PermissionStatus status =
                  await Permission.nearbyWifiDevices.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.scheduleExactAlarm:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.scheduleExactAlarm.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.scheduleExactAlarm.request();

              PermissionStatus status =
                  await Permission.scheduleExactAlarm.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.notification:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.notification.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.notification.request();

              PermissionStatus status = await Permission.notification.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.calendarFullAccess:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.calendarFullAccess.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.calendarFullAccess.request();

              PermissionStatus status =
                  await Permission.calendarFullAccess.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.appTrackingTransparency:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.appTrackingTransparency.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.appTrackingTransparency.request();

              PermissionStatus status =
                  await Permission.appTrackingTransparency.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.criticalAlerts:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.criticalAlerts.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.criticalAlerts.request();

              PermissionStatus status = await Permission.criticalAlerts.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.bluetooth:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.bluetooth.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.bluetooth.request();

              PermissionStatus status = await Permission.bluetooth.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.bluetoothScan:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.bluetoothScan.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.bluetoothScan.request();

              PermissionStatus status = await Permission.bluetoothScan.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.bluetoothAdvertise:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.bluetoothAdvertise.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.bluetoothAdvertise.request();

              PermissionStatus status =
                  await Permission.bluetoothAdvertise.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;

      case SampleItemEnum.bluetoothConnect:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            final all_dialog_yes_or_no_business.DialogWidgetBusiness
                allDialogYesOrNoBusiness =
                all_dialog_yes_or_no_business.DialogWidgetBusiness();
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.DialogWidget(
                      business: allDialogYesOrNoBusiness,
                      inputVo: const all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오"),
                      onDialogCreated: () {},
                    ));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            PermissionStatus permissionStatus =
                await Permission.bluetoothConnect.status;

            if (permissionStatus.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            } else {
              // 권한 요청
              await Permission.bluetoothConnect.request();

              PermissionStatus status =
                  await Permission.bluetoothConnect.status;
              if (status.isGranted) {
                // 권한 승인
                _togglePermissionSwitch(index);
              }
            }
          }
        }
        break;
    }
  }

  Future<void> onSensorsAlwaysItemClickAsync() async {
    if (pageViewModel.sensorsAlways) {
      // 스위치 Off 시키기
      final all_dialog_yes_or_no_business.DialogWidgetBusiness
          allDialogYesOrNoBusiness =
          all_dialog_yes_or_no_business.DialogWidgetBusiness();
      if (!_context.mounted) return;
      var outputVo = await showDialog(
          barrierDismissible: true,
          context: _context,
          builder: (context) => all_dialog_yes_or_no.DialogWidget(
                business: allDialogYesOrNoBusiness,
                inputVo: const all_dialog_yes_or_no.InputVo(
                    dialogTitle: "권한 해제",
                    dialogContent:
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                    positiveBtnTitle: "예",
                    negativeBtnTitle: "아니오"),
                onDialogCreated: () {},
              ));

      if (outputVo != null && outputVo.checkPositiveBtn) {
        // positive 버튼을 눌렀을 때
        // 권한 설정으로 이동
        openAppSettings();
      }
    } else {
      // 스위치 On 시키기
      PermissionStatus permissionStatus = await Permission.sensorsAlways.status;

      if (permissionStatus.isPermanentlyDenied) {
        // 권한이 영구적으로 거부된 경우
        // 권한 설정으로 이동
        openAppSettings();
      } else {
        // 권한 요청
        await Permission.sensorsAlways.request();

        PermissionStatus status = await Permission.sensorsAlways.status;
        if (status.isGranted) {
          // 권한 승인
          pageViewModel.sensorsAlways = !pageViewModel.sensorsAlways;
          blocObjects.blocSampleList.refresh();
        }
      }
    }
  }

  Future<void> onLocationAlwaysItemClickAsync() async {
    if (pageViewModel.androidLocationAlways) {
      // 스위치 Off 시키기
      final all_dialog_yes_or_no_business.DialogWidgetBusiness
          allDialogYesOrNoBusiness =
          all_dialog_yes_or_no_business.DialogWidgetBusiness();
      if (!_context.mounted) return;
      var outputVo = await showDialog(
          barrierDismissible: true,
          context: _context,
          builder: (context) => all_dialog_yes_or_no.DialogWidget(
                business: allDialogYesOrNoBusiness,
                inputVo: const all_dialog_yes_or_no.InputVo(
                    dialogTitle: "권한 해제",
                    dialogContent:
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                    positiveBtnTitle: "예",
                    negativeBtnTitle: "아니오"),
                onDialogCreated: () {},
              ));

      if (outputVo != null && outputVo.checkPositiveBtn) {
        // positive 버튼을 눌렀을 때
        // 권한 설정으로 이동
        openAppSettings();
      }
    } else {
      // 스위치 On 시키기
      PermissionStatus permissionStatus =
          await Permission.locationAlways.status;

      if (permissionStatus.isPermanentlyDenied) {
        // 권한이 영구적으로 거부된 경우
        // 권한 설정으로 이동
        openAppSettings();
      } else {
        // 권한 요청
        await Permission.locationAlways.request();

        PermissionStatus status = await Permission.locationAlways.status;
        if (status.isGranted) {
          // 권한 승인
          pageViewModel.androidLocationAlways =
              !pageViewModel.androidLocationAlways;
          blocObjects.blocSampleList.refresh();
        }
      }
    }
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!!

  // (권한 스위치 토글)
  void _togglePermissionSwitch(int index) {
    pageViewModel.allSampleList[index].isChecked =
        !pageViewModel.allSampleList[index].isChecked;
    blocObjects.blocSampleList.refresh();
  }
}

// (페이지 뷰 모델 클래스)
// 페이지 전역의 데이터는 여기에 정의되며, Business 인스턴스 안의 pageViewModel 변수로 저장 됩니다.
class PageViewModel {
  PageViewModel(this._context) {
    // 초기 리스트 추가
    allSampleList.add(SampleItem(SampleItemEnum.camera, "camera 권한",
        "Android : Camera, iOS : Photos (Camera Roll and Camera)"));

    allSampleList.add(SampleItem(SampleItemEnum.contacts, "contacts 권한",
        "Android : Contacts, iOS : AddressBook"));

    allSampleList.add(SampleItem(
        SampleItemEnum.microphone, "microphone 권한", "Android, iOS : 녹음"));

    allSampleList.add(SampleItem(SampleItemEnum.sensors, "sensors 권한",
        "Android : Body Sensors, iOS : CoreMotion"));

    allSampleList.add(SampleItem(SampleItemEnum.locationWhenInUse,
        "locationWhenInUse 권한", "Android, iOS : 포그라운드 GPS 정보 접근"));

    allSampleList.add(SampleItem(SampleItemEnum.notification, "notification 권한",
        "Android, todo iOS : 노티피케이션 표시 권한"));

    allSampleList.add(SampleItem(SampleItemEnum.calendarFullAccess,
        "calendarFullAccess 권한", "Android, todo iOS : 캘린더 입력, 읽기 권한"));

    if (Platform.isIOS) {
      // ios 일 때
      allSampleList.add(SampleItem(
          SampleItemEnum.reminders, "reminders 권한", "iOS : Reminder 접근"));

      allSampleList.add(SampleItem(SampleItemEnum.speech, "speech 권한",
          "Android : microphone 과 동일하므로 생략, iOS : TTS 기능"));

      allSampleList.add(SampleItem(SampleItemEnum.locationAlways,
          "locationAlways 권한", "iOS : 포그라운드 + 백그라운드 GPS 정보 접근"));

      allSampleList.add(SampleItem(SampleItemEnum.storage, "storage 권한",
          "Android 13(API 33) 이하 : 외부 저장소에 접근, iOS : `문서` 또는 `다운로드`와 같은 폴더에 액세스"));

      allSampleList.add(SampleItem(SampleItemEnum.appTrackingTransparency,
          "appTrackingTransparency 권한", "todo iOS :"));

      allSampleList.add(SampleItem(
          SampleItemEnum.criticalAlerts,
          "criticalAlerts 권한",
          "todo iOS : 중요한 알림을 보내기 위한 권한, 벨소리를 무시하는 알림 전송을 허용합니다."));

      var versionParts = Platform.operatingSystemVersion
          .split(' ')
          .where((part) => part.contains('.'))
          .first
          .split('.');
      var major = int.parse(versionParts[0]);
      var minor = int.parse(versionParts[1]);

      if (major >= 14) {
        // 14 이상일 때
        allSampleList.add(SampleItem(SampleItemEnum.photos, "photos 권한",
            "Android 13(API 33) 이상 : 외부 저장소 이미지 읽기, iOS : todo When running Photos (iOS 14+ read & write access level)"));
        allSampleList.add(SampleItem(SampleItemEnum.photosAddOnly,
            "photosAddOnly 권한", "iOS 14+ : todo photo 라이브러리 쓰기"));
      }

      if (major >= 13) {
        // 13 이상일 때
        allSampleList.add(SampleItem(SampleItemEnum.bluetooth, "bluetooth 권한",
            "Android : 항상 승인됨, todo iOS 13 보다 큼 : 블루투스 코어 매니저 권한, iOS 13 : 블루투스 코어 매니저 권한이지만 항상 false(처리 필요) iOS 13 보다 작음 : 항상 승인"));
      }

      if (major > 9 || (major == 9 && minor >= 3)) {
        // 9.3 이상일 때
        allSampleList.add(SampleItem(SampleItemEnum.mediaLibrary,
            "mediaLibrary 권한", "iOS : 미디어 라이브러리 접근 9.3+ only"));
      }
    } else if (Platform.isAndroid) {
      // android 일때

      allSampleList.add(SampleItem(
          SampleItemEnum.phone, "phone 권한", "Android : 전화 걸기, 전화 기록 보기"));

      allSampleList.add(SampleItem(
          SampleItemEnum.sms, "sms 권한", "Android : sms 메세지 보내기, 읽기"));

      allSampleList.add(SampleItem(SampleItemEnum.ignoreBatteryOptimizations,
          "ignoreBatteryOptimizations 권한", "Android : 배터리 최적화 무시 권한"));

      allSampleList.add(SampleItem(SampleItemEnum.systemAlertWindow,
          "systemAlertWindow 권한", "Android : 모든 앱보다 중요하게 표시되는 시스템 경고 띄우기 권한"));

      if (gd_const.androidApiLevel! < 33) {
        // android 33 미만
        allSampleList.add(SampleItem(SampleItemEnum.storage, "storage 권한",
            "Android 13(API 33) 미만 : 외부 저장소에 접근, iOS : todo `문서` 또는 `다운로드`와 같은 폴더에 액세스"));
      }

      if (gd_const.androidApiLevel! >= 33) {
        // android 33 이상
        allSampleList.add(SampleItem(SampleItemEnum.photos, "photos 권한",
            "Android 13(API 33) 이상 : 외부 저장소 이미지 읽기, iOS : todo When running Photos (iOS 14+ read & write access level)"));

        allSampleList.add(SampleItem(SampleItemEnum.videos, "videos 권한",
            "Android 13(API 33) 이상 : 외부 저장소 비디오 읽기"));

        allSampleList.add(SampleItem(SampleItemEnum.audio, "audio 권한",
            "Android 13(API 33) 이상 : 외부 저장소 오디오 읽기"));

        allSampleList.add(SampleItem(
            SampleItemEnum.nearbyWifiDevices,
            "nearbyWifiDevices 권한",
            "Android 13(API 33) 이상 : wi-fi 로 근처 디바이스 접속 권한"));
      }

      if (gd_const.androidApiLevel! >= 31) {
        // android 31 이상
        allSampleList.add(SampleItem(SampleItemEnum.scheduleExactAlarm,
            "scheduleExactAlarm 권한", "Android 12(API 31) 이상 : 정확한 알람 권한"));

        allSampleList.add(SampleItem(SampleItemEnum.bluetoothScan,
            "bluetoothScan 권한", "Android 12(API 31) 이상 : 블루투스 장치 스캔"));

        allSampleList.add(SampleItem(
            SampleItemEnum.bluetoothAdvertise,
            "bluetoothAdvertise 권한",
            "Android 12(API 31) 이상 : 블루투스 기기 광고에 대한 권한. 이 장치를 다른 Bluetooth 에서 검색할 수 있도록 허용"));

        allSampleList.add(SampleItem(
            SampleItemEnum.bluetoothConnect,
            "bluetoothConnect 권한",
            "Android 12(API 31) 이상 : 블루투스 기기 연결을 위한 권한. 이미 페어링된 Bluetooth 장치에 연결할 수 있도록 허용"));
      }

      if (gd_const.androidApiLevel! >= 30) {
        // android 30 이상
        allSampleList.add(SampleItem(
            SampleItemEnum.manageExternalStorage,
            "manageExternalStorage 권한",
            "Android 11(API 30) 이상 : 기기의 외부 저장소 접근 권한"));
      }

      if (gd_const.androidApiLevel! >= 29) {
        // android 29 이상
        allSampleList.add(SampleItem(
            SampleItemEnum.accessMediaLocation,
            "accessMediaLocation 권한",
            "Android 10(API 29) 이상 : 사용자의 공유 컬렉션에 저장된 모든 지리적 위치에 액세스"));

        allSampleList.add(SampleItem(
            SampleItemEnum.activityRecognition,
            "activityRecognition 권한",
            "Android 10(API 29) 이상 : 사용자의 활동 상태(걷기, 자전거, 자동차 등)를 알려주는 권한"));
      }

      if (gd_const.androidApiLevel! >= 23) {
        // android 23 이상
        allSampleList.add(SampleItem(
            SampleItemEnum.requestInstallPackages,
            "requestInstallPackages 권한",
            "Android (API 23) 이상 : 앱 내에서 다른 앱 설치 요청"));
        allSampleList.add(SampleItem(
            SampleItemEnum.accessNotificationPolicy,
            "accessNotificationPolicy 권한",
            "Android (API 23) 이상 : 디바이스 소리, 진동, 무음 모드 변경 권한"));
      }
    }

    // todo 추가 및 수정
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 생명주기 관련 states
  final gc_template_classes.PageLifeCycleStates pageLifeCycleStates =
      gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!!
  // ex :
  // int sampleNumber = 0;

  // PageOutFrameViewModel
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  // (샘플 페이지 원본 리스트)
  List<SampleItem> allSampleList = [];

  // Android 환경 백그라운드에서 sensors 사용 승인 여부
  bool sensorsAlways = false;

  // Android 환경 백그라운드에서 location 사용 승인 여부
  bool androidLocationAlways = false;
}

class SampleItem {
  SampleItem(
    this.sampleItemEnum,
    this.sampleItemTitle,
    this.sampleItemDescription,
  );

  // 샘플 고유값
  SampleItemEnum sampleItemEnum;

  // 샘플 타이틀
  String sampleItemTitle;

  // 샘플 설명
  String sampleItemDescription;

  // 권한 체크 여부
  bool isChecked = false;
}

enum SampleItemEnum {
  // Android : Camera, iOS : Photos (Camera Roll and Camera)
  camera,
  // Android : Contacts, iOS : AddressBook
  contacts,
  // iOS : 미디어 라이브러리 접근 9.3+ only
  mediaLibrary,
  // Android, iOS : 녹음
  microphone,
  // Android : 전화 걸기, 전화 기록 보기
  phone,
  // iOS : Reminder 접근
  reminders,
  // Android : Body Sensors, iOS : CoreMotion
  sensors,
  // Android : sms 메세지 보내기, 읽기
  sms,
  // Android : microphone 과 동일하므로 생략, iOS : TTS 기능
  speech,
  // Android, iOS : 포그라운드 GPS 정보 접근
  locationWhenInUse,
  // iOS : 포그라운드 + 백그라운드 GPS 정보 접근
  locationAlways,
  // Android 13(API 33) 미만 : 외부 저장소에 접근, iOS : todo `문서` 또는 `다운로드`와 같은 폴더에 액세스
  storage,
  // Android 13(API 33) 이상 : 외부 저장소 이미지 읽기, iOS 14+ : todo photo 라이브러리 읽기 쓰기
  photos,
  // Android 13(API 33) 이상 : 외부 저장소 비디오 읽기
  videos,
  // Android 13(API 33) 이상 : 외부 저장소 오디오 읽기
  audio,
  // Android 11(API 30) 이상 : 기기의 외부 저장소 접근 권한
  manageExternalStorage,
  // iOS 14+ : todo photo 라이브러리 쓰기
  photosAddOnly,
  // Android 10(API 29) 이상 : 사용자의 공유 컬렉션에 저장된 모든 지리적 위치에 액세스
  accessMediaLocation,
  // Android : 배터리 최적화 무시 권한
  ignoreBatteryOptimizations,
  // Android 10(API 29) 이상 : 사용자의 활동 상태(걷기, 자전거, 자동차 등)를 알려주는 권한
  activityRecognition,
  // Android : 모든 앱보다 중요하게 표시되는 시스템 경고 띄우기 권한
  systemAlertWindow,
  // Android (API 23) 이상 : 앱 내에서 다른 앱 설치 요청
  requestInstallPackages,
  // Android (API 23) 이상 : 방해 금지 모드
  accessNotificationPolicy,
  // Android 13(API 33) 이상 : wi-fi 로 근처 디바이스 접속 권한
  nearbyWifiDevices,
  // Android 12(API 31) 이상 : 정확한 알람 권한
  scheduleExactAlarm,
  // Android, todo iOS : 노티피케이션 표시 권한
  notification,
  // Android, todo iOS : 캘린더 입력, 읽기 권한
  calendarFullAccess,
  // todo iOS :
  appTrackingTransparency,
  // todo iOS : 중요한 알림을 보내기 위한 권한, 벨소리를 무시하는 알림 전송을 허용합니다.
  criticalAlerts,
  // Permission for accessing the device's bluetooth adapter state.
  // Depending on the platform and version, the requirements are slightly
  // different:
  // **Android:**
  // - Always allowed.
  // **iOS:**
  // - iOS 13 and above: The authorization state of Core Bluetooth manager.
  // - iOS below 13: always allowed.
  // Limitations:
  // - iOS 13.0 only: [bluetooth.status] is always [PermissionStatus.denied],
  // regardless of the actual status. For the actual permission state, use
  // [bluetooth.request]. Note that this will show a permission dialog if the
  // permission was not yet requested.
  // - All iOS versions: [bluetooth.serviceStatus] will **always** return
  // [ServiceStatus.disabled] when the Bluetooth permission was denied by the
  // user. It is impossible to obtain the actual Bluetooth service status
  // without having the Bluetooth permission granted. The method will prompt
  // the user for Bluetooth permission if the permission was not yet requested.
  // Android : 항상 승인됨, todo iOS 13 보다 큼 : 블루투스 코어 매니저 권한, iOS 13 : 블루투스 코어 매니저 권한이지만 항상 false(처리 필요) iOS 13 보다 작음 : 항상 승인
  bluetooth,
  // Android 12(API 31) 이상 : 블루투스 장치 스캔
  bluetoothScan,
  // Android 12(API 31) 이상 : 블루투스 기기 광고에 대한 권한. 이 장치를 다른 Bluetooth 에서 검색할 수 있도록 허용
  bluetoothAdvertise,
  // Android 12(API 31) 이상 : 블루투스 기기 연결을 위한 권한. 이미 페어링된 Bluetooth 장치에 연결할 수 있도록 허용
  bluetoothConnect,

  // todo 추가 및 수정
}

// (BLoC 클래스)
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
//
//   // BLoC 위젯 갱신 함수
//   void refresh() {
//     add(!state);
//   }
// }

class BlocSampleList extends Bloc<bool, bool> {
  BlocSampleList() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }

  // BLoC 위젯 갱신 함수
  void refresh() {
    add(!state);
  }
}

// (BLoC 프로바이더 클래스)
// 본 페이지에서 사용할 BLoC 객체를 모아두어 PageEntrance 에서 페이지 전역 설정에 사용 됩니다.
class BLocProviders {
// !!!이 페이지에서 사용할 "모든" BLoC 클래스들에 대한 Provider 객체들을 아래 리스트에 넣어줄 것!!!
  List<BlocProvider<dynamic>> blocProviders = [
    // ex :
    // BlocProvider<BlocSample>(create: (context) => BlocSample())
    BlocProvider<BlocSampleList>(create: (context) => BlocSampleList()),
  ];
}

class BLocObjects {
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocSampleList = BlocProvider.of<BlocSampleList>(_context);
  }

  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!!
  // ex :
  // late BlocSample blocSample;
  late BlocSampleList blocSampleList;
}
