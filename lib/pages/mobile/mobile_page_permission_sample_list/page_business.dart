// (external)
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../dialogs/all/all_dialog_yes_or_no/page_entrance.dart'
    as all_dialog_yes_or_no;
import '../../../global_data/gd_const.dart' as gd_const;

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]
// todo location serviceStatus.isEnabled 체크

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 및 뷰모델 담당
// PageBusiness 인스턴스는 PageView 가 재생성 되어도 재활용이 되며 PageViewModel 인스턴스 역시 유지됨.
class PageBusiness {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // 페이지 뷰모델 (StateFul 위젯 State 데이터는 모두 여기에 저장됨)
  late PageViewModel pageViewModel;

  // BLoC 객체 모음
  late BLocObjects blocObjects;

  // 생성자 설정
  PageBusiness(this._context) {
    pageViewModel = PageViewModel();
  }

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (onPageCreateAsync 실행 전 PageInputVo 체크)
  // onPageCreateAsync 과 완전히 동일하나, 입력값 체크만을 위해 분리한 생명주기
  Future<void> onCheckPageInputVoAsync(GoRouterState goRouterState) async {
    // !!!pageInputVo 체크!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!
    pageViewModel.pageInputVo = page_entrance.PageInputVo();
  }

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!

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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
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
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
    }

    // todo : 추가 및 수정
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!
  }

  // (페이지 종료 (강제 종료는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!
  }

  // (Page Pop 요청)
  // context.pop() 호출 직후 호출
  // return 이 true 라면 onWidgetPause 부터 onPageDestroyAsync 까지 실행 되며 페이지 종료
  // return 이 false 라면 pop 되지 않고 그대로 대기
  Future<bool> onPageWillPopAsync() async {
    // !!!onWillPop 로직 작성!!

    return true;
  }

////
// [비즈니스 함수]
// !!!외부에서 사용할 비즈니스 로직은 아래에 공개 함수로 구현!!
// ex :
//   void changeSampleNumber(int newSampleNumber) {
//     // 뷰모델 state 변경
//     pageViewModel.sampleNumber = newSampleNumber;
//     // 위젯 변경 트리거 발동
//     bLocObjects.blocSample.add(!bLocObjects.blocSample.state);
//   }

  // (리스트 아이템 클릭 리스너)
  Future<void> onRouteListItemClickAsync(int index) async {
    SampleItem sampleItem = pageViewModel.allSampleList[index];

    switch (sampleItem.sampleItemEnum) {
      case SampleItemEnum.camera:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo(
                        "권한 해제",
                        "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                        "예",
                        "아니오"),
                    (pageBusiness) {}));

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

      // todo : 추가 및 수정
    }
  }

  Future<void> onSensorsAlwaysItemClickAsync() async {
    if (pageViewModel.sensorsAlways) {
      // 스위치 Off 시키기
      if (!_context.mounted) return;
      var outputVo = await showDialog(
          barrierDismissible: true,
          context: _context,
          builder: (context) => all_dialog_yes_or_no.PageEntrance(
              all_dialog_yes_or_no.PageInputVo(
                  "권한 해제",
                  "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                  "예",
                  "아니오"),
              (pageBusiness) {}));

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
          blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
        }
      }
    }
  }

  Future<void> onLocationAlwaysItemClickAsync() async {
    if (pageViewModel.androidLocationAlways) {
      // 스위치 Off 시키기
      if (!_context.mounted) return;
      var outputVo = await showDialog(
          barrierDismissible: true,
          context: _context,
          builder: (context) => all_dialog_yes_or_no.PageEntrance(
              all_dialog_yes_or_no.PageInputVo(
                  "권한 해제",
                  "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                  "예",
                  "아니오"),
              (pageBusiness) {}));

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
          blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
        }
      }
    }
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!

  // (권한 스위치 토글)
  void _togglePermissionSwitch(int index) {
    pageViewModel.allSampleList[index].isChecked =
        !pageViewModel.allSampleList[index].isChecked;
    blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
  }
}

// (페이지 뷰 모델 데이터 형태)
// 페이지의 모든 화면 관련 데이터는 여기에 정의되며, Business 인스턴스 안에 객체로 저장 됩니다.
class PageViewModel {
  // 페이지 생명주기 관련 states
  var pageLifeCycleStates = gc_template_classes.PageLifeCycleStates();

  // 페이지 파라미터 (아래 goRouterState 에서 가져와 대입하기)
  late page_entrance.PageInputVo pageInputVo;

  // !!!페이지 데이터 정의!!
  // ex :
  // int sampleNumber = 0;

  // (샘플 페이지 원본 리스트)
  List<SampleItem> allSampleList = [];

  // Android 환경 백그라운드에서 sensors 사용 승인 여부
  bool sensorsAlways = false;

  // Android 환경 백그라운드에서 location 사용 승인 여부
  bool androidLocationAlways = false;

  PageViewModel() {
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
      }

      if (gd_const.androidApiLevel! >= 30) {
        // android 30 이상
        allSampleList.add(SampleItem(
            SampleItemEnum.manageExternalStorage,
            "manageExternalStorage 권한",
            "Android 11(API 30) 이상 : 기기의 외부 저장소 접근 권한"));
      }
    }

    // todo 추가 및 수정
  }
}

class SampleItem {
  // 샘플 고유값
  SampleItemEnum sampleItemEnum;

  // 샘플 타이틀
  String sampleItemTitle;

  // 샘플 설명
  String sampleItemDescription;

  // 권한 체크 여부
  bool isChecked = false;

  SampleItem(
      this.sampleItemEnum, this.sampleItemTitle, this.sampleItemDescription);
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

  // todo ios 테스트
  // Android 13(API 33) 미만 : 외부 저장소에 접근, iOS : todo `문서` 또는 `다운로드`와 같은 폴더에 액세스
  storage,
  // Android 13(API 33) 이상 : 외부 저장소 이미지 읽기, iOS : todo When running Photos (iOS 14+ read & write access level)
  photos,
  // Android 13(API 33) 이상 : 외부 저장소 비디오 읽기
  videos,
  // Android 13(API 33) 이상 : 외부 저장소 오디오 읽기
  audio,
  // Android 11(API 30) 이상 : 기기의 외부 저장소 접근 권한
  manageExternalStorage,

  // todo 추가 및 수정
}

// (BLoC 클래스 모음)
// 아래엔 런타임 위젯 변경의 트리거가 되는 BLoC 클래스들을 작성해 둡니다.
// !!!각 BLoC 클래스는 아래 예시를 '그대로' 복사 붙여넣기를 하여 클래스 이름만 변경합니다.!!
// ex :
// class BlocSample extends Bloc<bool, bool> {
//   BlocSample() : super(true) {
//     on<bool>((event, emit) {
//       emit(event);
//     });
//   }
// }

class BlocSampleList extends Bloc<bool, bool> {
  BlocSampleList() : super(true) {
    on<bool>((event, emit) {
      emit(event);
    });
  }
}

// (BLoC 프로바이더 클래스)
// 본 페이지에서 사용할 BLoC 객체를 모아두어 PageEntrance 에서 페이지 전역 설정에 사용 됩니다.
class BLocProviders {
// !!!위에 정의된 BLoC 클래스들에 대한 Provider 객체들을 아래 리스트에 모두 넣어줄 것!!
  List<BlocProvider<dynamic>> blocProviders = [
    // ex :
    // BlocProvider<BlocSample>(create: (context) => BlocSample()),
    BlocProvider<BlocSampleList>(create: (context) => BlocSampleList()),
  ];
}

class BLocObjects {
  // 페이지 컨텍스트 객체
  final BuildContext _context;

  // !!!BLoC 조작 객체 변수 선언!!
  // ex :
  // late BlocSample blocSample;
  late BlocSampleList blocSampleList;

  // 생성자 설정
  BLocObjects(this._context) {
    // !!!BLoC 조작 객체 생성!!
    // ex :
    // blocSample = BlocProvider.of<BlocSample>(_context);
    blocSampleList = BlocProvider.of<BlocSampleList>(_context);
  }
}
