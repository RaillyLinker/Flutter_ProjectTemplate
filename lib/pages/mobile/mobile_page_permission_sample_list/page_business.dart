// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

// (page)
import 'page_entrance.dart' as page_entrance;

import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_data/gd_const.dart' as gd_const;
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
  PageBusiness(this._context, GoRouterState goRouterState) {
    pageViewModel = PageViewModel(goRouterState);
  }

  ////
  // [페이지 생명주기]
  // - 페이지 최초 실행 : onPageCreateAsync -> onPageResumeAsync
  // - 다른 페이지 호출 / 복귀, 화면 끄기 / 켜기, 모바일에서 다른 앱으로 이동 및 복귀시 :
  // onPagePauseAsync -> onPageResumeAsync -> onPagePauseAsync -> onPageResumeAsync 반복
  // - 페이지 종료 : onPageWillPopAsync -(return true 일 때)-> onPagePauseAsync -> onPageDestroyAsync 실행

  // (페이지 최초 실행)
  Future<void> onPageCreateAsync() async {
    // !!!페이지 최초 실행 로직 작성!!
  }

  // (페이지 최초 실행 or 다른 페이지에서 복귀)
  Future<void> onPageResumeAsync() async {
    // !!!위젯 최초 실행 및, 다른 페이지에서 복귀 로직 작성!!

    // 권한 여부 관련 정보 화면 갱신 (다른 화면으로 이동했다가 복귀할 때마다 권한이 변경되었을 가능성이 있으므로 여기서 처리)
    if (gd_const.androidApiLevel! < 33) {
      // Storage Permission
      int storagePermissionIndex = pageViewModel.filteredSampleList.indexWhere(
          (samplePage) =>
              samplePage.sampleItemEnum == SampleItemEnum.storagePermission);

      if (storagePermissionIndex != -1) {
        Permission.storage.status.then((status) {
          if (status.isGranted) {
            pageViewModel.filteredSampleList[storagePermissionIndex].isChecked =
                true;
          } else {
            pageViewModel.filteredSampleList[storagePermissionIndex].isChecked =
                false;
          }
          blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
        });
      }
    } else {
      // Read Storage Permission : photos And videos
      int readStoragePermissionPhotosAndVideosIndex =
          pageViewModel.filteredSampleList.indexWhere((samplePage) =>
              samplePage.sampleItemEnum ==
              SampleItemEnum.readStoragePermissionPhotosAndVideos);

      if (readStoragePermissionPhotosAndVideosIndex != -1) {
        Permission.photos.status.then((photosStatus) {
          if (photosStatus.isGranted) {
            Permission.videos.status.then((videosStatus) {
              if (videosStatus.isGranted) {
                pageViewModel
                    .filteredSampleList[
                        readStoragePermissionPhotosAndVideosIndex]
                    .isChecked = true;
              } else {
                pageViewModel
                    .filteredSampleList[
                        readStoragePermissionPhotosAndVideosIndex]
                    .isChecked = false;
              }
              blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
            });
          }
        });
      }

      // Read Storage Permission : Audios
      int readStoragePermissionAudiosIndex = pageViewModel.filteredSampleList
          .indexWhere((samplePage) =>
              samplePage.sampleItemEnum ==
              SampleItemEnum.readStoragePermissionAudios);
      if (readStoragePermissionAudiosIndex != -1) {
        Permission.audio.status.then((status) {
          if (status.isGranted) {
            pageViewModel.filteredSampleList[readStoragePermissionAudiosIndex]
                .isChecked = true;
          } else {
            pageViewModel.filteredSampleList[readStoragePermissionAudiosIndex]
                .isChecked = false;
          }
          blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
        });
      }
    }
  }

  // (페이지 종료 or 다른 페이지로 이동 (강제 종료는 탐지 못함))
  Future<void> onPagePauseAsync() async {
    // !!!위젯 종료 및, 다른 페이지로 이동 로직 작성!!
  }

  // (페이지 종료 (강제 종료는 탐지 못함))
  Future<void> onPageDestroyAsync() async {
    // !!!페이지 종료 로직 작성!!
    pageViewModel.sampleSearchBarTextEditController.dispose();
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

  // (검색 결과에 따라 샘플 페이지 리스트 필터링)
  void filteringSamplePageList(String searchKeyword) {
    if (searchKeyword == "") {
      // 원본 리스트로 뷰모델 데이터 변경 후 이벤트 발생
      pageViewModel.filteredSampleList = pageViewModel.allSampleList;
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
    } else {
      // 필터링한 리스트로 뷰모델 데이터 변경 후 이벤트 발생
      List<SampleItem> filteredSamplePageList = [];
      // 필터링 하기
      for (SampleItem samplePage in pageViewModel.allSampleList) {
        if (samplePage.sampleItemTitle
            .toLowerCase()
            .contains(searchKeyword.toLowerCase())) {
          filteredSamplePageList.add(samplePage);
        } else if (samplePage.sampleItemDescription
            .toLowerCase()
            .contains(searchKeyword.toLowerCase())) {
          filteredSamplePageList.add(samplePage);
        }
      }
      pageViewModel.filteredSampleList = filteredSamplePageList;
      blocObjects.blocSampleList.add(!blocObjects.blocSampleList.state);
    }
  }

  // (리스트 아이템 클릭 리스너)
  Future<void> onRouteListItemClickAsync(int index) async {
    SampleItem sampleItem = pageViewModel.filteredSampleList[index];

    switch (sampleItem.sampleItemEnum) {
      case SampleItemEnum.storagePermission:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo("release permission",
                        "do you want to release permission?", "yes", "no"),
                    (pageBusiness) {}));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            // 권한 요청
            PermissionStatus status = await Permission.storage.request();
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
      case SampleItemEnum.readStoragePermissionPhotosAndVideos:
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo("release permission",
                        "do you want to release permission?", "yes", "no"),
                    (pageBusiness) {}));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            // 권한 요청
            Map<Permission, PermissionStatus> status =
                await [Permission.photos, Permission.videos].request();
            if (status[Permission.photos]!.isGranted &&
                status[Permission.videos]!.isGranted) {
              // 권한 승인
              _togglePermissionSwitch(index);
            } else if (status[Permission.photos]!.isPermanentlyDenied ||
                status[Permission.videos]!.isPermanentlyDenied) {
              // 권한이 영구적으로 거부된 경우
              // 권한 설정으로 이동
              openAppSettings();
            }
          }
        }
        break;
      case SampleItemEnum
            .readStoragePermissionAudios: // Read Storage Permission : Audios
        {
          if (sampleItem.isChecked) {
            // 스위치 Off 시키기
            if (!_context.mounted) return;
            var outputVo = await showDialog(
                barrierDismissible: true,
                context: _context,
                builder: (context) => all_dialog_yes_or_no.PageEntrance(
                    all_dialog_yes_or_no.PageInputVo("release permission",
                        "do you want to release permission?", "yes", "no"),
                    (pageBusiness) {}));

            if (outputVo != null && outputVo.checkPositiveBtn) {
              // positive 버튼을 눌렀을 때
              // 권한 설정으로 이동
              openAppSettings();
            }
          } else {
            // 스위치 On 시키기
            // 권한 요청
            PermissionStatus status = await Permission.audio.request();
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
    }
  }

////
// [내부 함수]
// !!!내부에서만 사용할 함수를 아래에 구현!!

  // (권한 스위치 토글)
  void _togglePermissionSwitch(int index) {
    pageViewModel.filteredSampleList[index].isChecked =
        !pageViewModel.filteredSampleList[index].isChecked;
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
  GoRouterState goRouterState;

  // !!!페이지 데이터 정의!!
  // ex :
  // int sampleNumber = 0;

  // 샘플 목록 필터링용 검색창 컨트롤러 (검색창의 텍스트 정보를 가지고 있으므로 뷰모델에 저장, 여기 있어야 위젯이 변경되어도 검색어가 유지됨)
  TextEditingController sampleSearchBarTextEditController =
      TextEditingController();

  // (샘플 페이지 원본 리스트)
  List<SampleItem> allSampleList = [];

  // (샘플 페이지 리스트 검색 결과)
  List<SampleItem> filteredSampleList = [];

  PageViewModel(this.goRouterState) {
    // 초기 리스트 추가
    if (gd_const.androidApiLevel! < 33) {
      allSampleList.add(SampleItem(SampleItemEnum.storagePermission,
          "Storage Permission", "Storage Permission"));
    } else {
      allSampleList.add(SampleItem(
          SampleItemEnum.readStoragePermissionPhotosAndVideos,
          "Read Storage Permission : photos And videos",
          "Read Storage Permission : photos And videos"));
      allSampleList.add(SampleItem(
          SampleItemEnum.readStoragePermissionAudios,
          "Read Storage Permission : Audios",
          "Read Storage Permission : Audios"));
    }

    filteredSampleList = allSampleList;
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
  storagePermission,
  readStoragePermissionPhotosAndVideos,
  readStoragePermissionAudios,
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