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

// [페이지 비즈니스 로직 및 뷰모델 작성 파일]

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
      Permission.camera.status.then((status) {
        if (status.isGranted) {
          pageViewModel.allSampleList[cameraPermissionIndex].isChecked = true;
        } else {
          pageViewModel.allSampleList[cameraPermissionIndex].isChecked = false;
        }
        blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
      });
    }

    // contacts 권한 여부 확인
    int contactsPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.contacts);

    if (contactsPermissionIndex != -1) {
      Permission.contacts.status.then((status) {
        if (status.isGranted) {
          pageViewModel.allSampleList[contactsPermissionIndex].isChecked = true;
        } else {
          pageViewModel.allSampleList[contactsPermissionIndex].isChecked =
              false;
        }
        blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
      });
    }

    // mediaLibrary 권한 여부 확인
    int mediaLibraryPermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) =>
            samplePage.sampleItemEnum == SampleItemEnum.mediaLibrary);

    if (mediaLibraryPermissionIndex != -1) {
      Permission.mediaLibrary.status.then((status) {
        if (status.isGranted) {
          pageViewModel.allSampleList[mediaLibraryPermissionIndex].isChecked =
              true;
        } else {
          pageViewModel.allSampleList[mediaLibraryPermissionIndex].isChecked =
              false;
        }
        blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
      });
    }

    // microphone 권한 여부 확인
    int microphonePermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.microphone);

    if (microphonePermissionIndex != -1) {
      Permission.microphone.status.then((status) {
        if (status.isGranted) {
          pageViewModel.allSampleList[microphonePermissionIndex].isChecked =
              true;
        } else {
          pageViewModel.allSampleList[microphonePermissionIndex].isChecked =
              false;
        }
        blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
      });
    }

    // phoneState 권한 여부 확인
    int phoneStatePermissionIndex = pageViewModel.allSampleList.indexWhere(
        (samplePage) => samplePage.sampleItemEnum == SampleItemEnum.phone);

    if (phoneStatePermissionIndex != -1) {
      Permission.phone.status.then((status) {
        if (status.isGranted) {
          pageViewModel.allSampleList[phoneStatePermissionIndex].isChecked =
              true;
        } else {
          pageViewModel.allSampleList[phoneStatePermissionIndex].isChecked =
              false;
        }
        blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
      });
    }

    // todo : 추가 및 수정

    // 권한 여부 관련 정보 화면 갱신 (다른 화면으로 이동했다가 복귀할 때마다 권한이 변경되었을 가능성이 있으므로 여기서 처리)
    // if (gd_const.androidApiLevel! < 33) {
    //   // Storage Permission
    //   int storagePermissionIndex = pageViewModel.allSampleList.indexWhere(
    //       (samplePage) =>
    //           samplePage.sampleItemEnum == SampleItemEnum.storagePermission);
    //
    //   if (storagePermissionIndex != -1) {
    //     Permission.storage.status.then((status) {
    //       if (status.isGranted) {
    //         pageViewModel.allSampleList[storagePermissionIndex].isChecked =
    //             true;
    //       } else {
    //         pageViewModel.allSampleList[storagePermissionIndex].isChecked =
    //             false;
    //       }
    //       blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
    //     });
    //   }
    // } else {
    //   // Read Storage Permission : photos And videos
    //   int readStoragePermissionPhotosAndVideosIndex =
    //       pageViewModel.allSampleList.indexWhere((samplePage) =>
    //           samplePage.sampleItemEnum ==
    //           SampleItemEnum.readStoragePermissionPhotosAndVideos);
    //
    //   if (readStoragePermissionPhotosAndVideosIndex != -1) {
    //     Permission.photos.status.then((photosStatus) {
    //       if (photosStatus.isGranted) {
    //         Permission.videos.status.then((videosStatus) {
    //           if (videosStatus.isGranted) {
    //             pageViewModel
    //                 .allSampleList[
    //                     readStoragePermissionPhotosAndVideosIndex]
    //                 .isChecked = true;
    //           } else {
    //             pageViewModel
    //                 .allSampleList[
    //                     readStoragePermissionPhotosAndVideosIndex]
    //                 .isChecked = false;
    //           }
    //           blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
    //         });
    //       }
    //     });
    //   }
    //
    //   // Read Storage Permission : Audios
    //   int readStoragePermissionAudiosIndex = pageViewModel.allSampleList
    //       .indexWhere((samplePage) =>
    //           samplePage.sampleItemEnum ==
    //           SampleItemEnum.readStoragePermissionAudios);
    //   if (readStoragePermissionAudiosIndex != -1) {
    //     Permission.audio.status.then((status) {
    //       if (status.isGranted) {
    //         pageViewModel.allSampleList[readStoragePermissionAudiosIndex]
    //             .isChecked = true;
    //       } else {
    //         pageViewModel.allSampleList[readStoragePermissionAudiosIndex]
    //             .isChecked = false;
    //       }
    //       blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
    //     });
    //   }
    // }
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

            // 권한 요청
            PermissionStatus status = await Permission.camera.request();
            if (status.isGranted) {
              // 권한 승인
              _togglePermissionSwitch(index);
            } else if (status.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
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

            // 권한 요청
            PermissionStatus status = await Permission.contacts.request();
            if (status.isGranted) {
              // 권한 승인
              _togglePermissionSwitch(index);
            } else if (status.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
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

            // 권한 요청
            PermissionStatus status = await Permission.mediaLibrary.request();
            if (status.isGranted) {
              // 권한 승인
              _togglePermissionSwitch(index);
            } else if (status.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
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

            // 권한 요청
            PermissionStatus status = await Permission.microphone.request();
            if (status.isGranted) {
              // 권한 승인
              _togglePermissionSwitch(index);
            } else if (status.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
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

            // 권한 요청
            PermissionStatus status = await Permission.phone.request();
            if (status.isGranted) {
              // 권한 승인
              _togglePermissionSwitch(index);
            } else if (status.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            }
          }
        }
        break;

      // todo : 추가 및 수정
      // case SampleItemEnum.storagePermission:
      //   {
      //     if (sampleItem.isChecked) {
      //       // 스위치 Off 시키기
      //       var outputVo = await showDialog(
      //           barrierDismissible: true,
      //           context: _context,
      //           builder: (context) => all_dialog_yes_or_no.PageEntrance(
      //               all_dialog_yes_or_no.PageInputVo("release permission",
      //                   "do you want to release permission?", "yes", "no"),
      //               (pageBusiness) {}));
      //
      //       if (outputVo != null && outputVo.checkPositiveBtn) {
      //         // positive 버튼을 눌렀을 때
      //         // 권한 설정으로 이동
      //         openAppSettings();
      //       }
      //     } else {
      //       // 스위치 On 시키기
      //       // 권한 요청
      //       PermissionStatus status = await Permission.storage.request();
      //       if (status.isGranted) {
      //         // 권한 승인
      //         _togglePermissionSwitch(index);
      //       } else if (status.isPermanentlyDenied) {
      //         // 권한이 영구적으로 거부된 경우
      //         // 권한 설정으로 이동
      //         openAppSettings();
      //       }
      //     }
      //   }
      //   break;
      // case SampleItemEnum.readStoragePermissionPhotosAndVideos:
      //   {
      //     if (sampleItem.isChecked) {
      //       // 스위치 Off 시키기
      //       if (!_context.mounted) return;
      //       var outputVo = await showDialog(
      //           barrierDismissible: true,
      //           context: _context,
      //           builder: (context) => all_dialog_yes_or_no.PageEntrance(
      //               all_dialog_yes_or_no.PageInputVo("release permission",
      //                   "do you want to release permission?", "yes", "no"),
      //               (pageBusiness) {}));
      //
      //       if (outputVo != null && outputVo.checkPositiveBtn) {
      //         // positive 버튼을 눌렀을 때
      //         // 권한 설정으로 이동
      //         openAppSettings();
      //       }
      //     } else {
      //       // 스위치 On 시키기
      //       // 권한 요청
      //       Map<Permission, PermissionStatus> status =
      //           await [Permission.photos, Permission.videos].request();
      //       if (status[Permission.photos]!.isGranted &&
      //           status[Permission.videos]!.isGranted) {
      //         // 권한 승인
      //         _togglePermissionSwitch(index);
      //       } else if (status[Permission.photos]!.isPermanentlyDenied ||
      //           status[Permission.videos]!.isPermanentlyDenied) {
      //         // 권한이 영구적으로 거부된 경우
      //         // 권한 설정으로 이동
      //         openAppSettings();
      //       }
      //     }
      //   }
      //   break;
      // case SampleItemEnum
      //       .readStoragePermissionAudios: // Read Storage Permission : Audios
      //   {
      //     if (sampleItem.isChecked) {
      //       // 스위치 Off 시키기
      //       if (!_context.mounted) return;
      //       var outputVo = await showDialog(
      //           barrierDismissible: true,
      //           context: _context,
      //           builder: (context) => all_dialog_yes_or_no.PageEntrance(
      //               all_dialog_yes_or_no.PageInputVo("release permission",
      //                   "do you want to release permission?", "yes", "no"),
      //               (pageBusiness) {}));
      //
      //       if (outputVo != null && outputVo.checkPositiveBtn) {
      //         // positive 버튼을 눌렀을 때
      //         // 권한 설정으로 이동
      //         openAppSettings();
      //       }
      //     } else {
      //       // 스위치 On 시키기
      //       // 권한 요청
      //       PermissionStatus status = await Permission.audio.request();
      //       if (status.isGranted) {
      //         // 권한 승인
      //         _togglePermissionSwitch(index);
      //       } else if (status.isPermanentlyDenied) {
      //         // 권한이 영구적으로 거부된 경우
      //         // 권한 설정으로 이동
      //         openAppSettings();
      //       }
      //     }
      //   }
      //   break;
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

  PageViewModel() {
    // 초기 리스트 추가
    allSampleList.add(SampleItem(SampleItemEnum.camera, "camera 권한",
        "Android : Camera, iOS : Photos (Camera Roll and Camera)"));

    allSampleList.add(SampleItem(SampleItemEnum.contacts, "contacts 권한",
        "Android : Contacts, iOS : AddressBook"));

    allSampleList.add(SampleItem(
        SampleItemEnum.microphone, "microphone 권한", "ndroid, iOS : 녹음"));

    if (Platform.isIOS) {
      // ios 일 때
      var versionParts = Platform.operatingSystemVersion
          .split(' ')
          .where((part) => part.contains('.'))
          .first
          .split('.');
      var major = int.parse(versionParts[0]);
      var minor = int.parse(versionParts[1]);

      if (major > 9 || (major == 9 && minor >= 3)) {
        // 9.3 이상일 때
        allSampleList.add(SampleItem(SampleItemEnum.mediaLibrary,
            "mediaLibrary 권한", "iOS : 미디어 라이브러리 접근 9.3+ only"));
      }
    } else if (Platform.isAndroid) {
      // android 일때

      allSampleList.add(SampleItem(
          SampleItemEnum.phone, "phone 권한", "Android : 전화 걸기, 전화 기록 보기"));
    }

    // todo 추가 및 수정
    // if (gd_const.androidApiLevel! < 33) {
    //   allSampleList.add(SampleItem(SampleItemEnum.storagePermission,
    //       "Storage 권한", "Storage 권한"));
    // } else {
    //   allSampleList.add(SampleItem(
    //       SampleItemEnum.readStoragePermissionPhotosAndVideos,
    //       "Storage 읽기 권한 : photos And videos",
    //       "Storage 읽기 권한 : photos And videos"));
    //   allSampleList.add(SampleItem(
    //       SampleItemEnum.readStoragePermissionAudios,
    //       "Storage 읽기 권한 : Audios",
    //       "Storage 읽기 권한 : Audios"));
    // }
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

  // todo 추가 및 수정
  // storagePermission,
  // readStoragePermissionPhotosAndVideos,
  // readStoragePermissionAudios,
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
