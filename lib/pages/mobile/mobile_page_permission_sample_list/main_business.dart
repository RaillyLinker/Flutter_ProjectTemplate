// (external)
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/dialogs/all/all_dialog_yes_or_no/main_widget.dart'
    as all_dialog_yes_or_no;
import 'package:flutter_project_template/global_data/gd_const.dart' as gd_const;

// [위젯 비즈니스]

//------------------------------------------------------------------------------
class MainBusiness {
  // [CallBack 함수]
  // (inputVo 확인 콜백)
  // State 클래스의 initState 에서 실행 되며, Business 클래스의 initState 실행 전에 실행 됩니다.
  // 필수 정보 누락시 null 을 반환, null 이 반환 되었을 때는 inputError 가 true 가 됩니다.
  main_widget.InputVo? onCheckPageInputVo(
      {required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters.containsKey("inputValueString")) {
    //   return null;
    // }

    // !!!PageInputVo 입력!!!
    return const main_widget.InputVo();
  }

  // (진입 최초 단 한번 실행) - 아직 위젯이 생성 되기 전
  void initState() {
    // !!!initState 로직 작성!!!
    hoveringTileViewModelList = getNewItemWidgetList();
  }

  // (종료 시점 단 한번 실행)
  void dispose() {
    // !!!dispose 로직 작성!!!
  }

  // (최초 실행시 단 한번 실행) - 위젯 build 바로 직전, 모든 것이 준비 되었을 때
  void onCreate() {
    // !!!onCreate 로직 작성!!!
  }

  Future<void> onFocusGainedAsync() async {
    // !!!onFocusGainedAsync 로직 작성!!!
    _checkAllPermissionsAsync();
  }

  Future<void> onFocusLostAsync() async {
    // !!!onFocusLostAsync 로직 작성!!!
  }

  Future<void> onVisibilityGainedAsync() async {
    // !!!onVisibilityGainedAsync 로직 작성!!!
  }

  Future<void> onVisibilityLostAsync() async {
    // !!!onVisibilityLostAsync 로직 작성!!!
  }

  Future<void> onForegroundGainedAsync() async {
    // !!!onForegroundGainedAsync 로직 작성!!!
  }

  Future<void> onForegroundLostAsync() async {
    // !!!onForegroundLostAsync 로직 작성!!!
  }

  //----------------------------------------------------------------------------
  // !!!메인 위젯에서 사용할 변수는 이곳에서 저장하여 사용하세요.!!!
  // [public 변수]
  // (위젯 입력값)
  late main_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수) - false 로 설정시 pop 불가
  bool canPop = true;

  // (입력값 미충족 여부)
  bool inputError = false;

  // (context 객체)
  late BuildContext mainContext;

  // (최초 실행 플래그)
  bool pageInitFirst = true;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState>
      hoveringTileViewModelListAreaGk = GlobalKey();
  late BuildContext hoveringTileListAreaContext;
  List<HoveringListTileViewModel> hoveringTileViewModelList = [];

  // [private 변수]

  //----------------------------------------------------------------------------
  // !!!비즈니스 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (메인 위젯 화면 갱신)
  late VoidCallback refreshUi;

  // (현 상황에 맞는 아이템 리스트 반환)
  List<HoveringListTileViewModel> getNewItemWidgetList() {
    List<HoveringListTileViewModel> hoveringListTileViewModel = [];
    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "camera 권한",
          itemDescription:
              "Android : Camera, iOS : Photos (Camera Roll and Camera)",
          permissionTypeEnum: PermissionTypeEnum.camera,
          onItemClicked: ({required int index}) async {
            final HoveringListTileViewModel hoveringListTileViewModel =
                hoveringTileViewModelList[index];

            if (hoveringListTileViewModel.isSwitchChecked) {
              // 스위치 Off 시키기
              final GlobalKey<all_dialog_yes_or_no.MainWidgetState>
                  allDialogYesOrNoStateGk = GlobalKey();
              if (!mainContext.mounted) return;
              var outputVo = await showDialog(
                  barrierDismissible: true,
                  context: mainContext,
                  builder: (context) => all_dialog_yes_or_no.MainWidget(
                        key: allDialogYesOrNoStateGk,
                        inputVo: all_dialog_yes_or_no.InputVo(
                          dialogTitle: "권한 해제",
                          dialogContent:
                              "권한 해제를 위해선\n디바이스 설정으로 이동해야합니다.\n디바이스 설정으로 이동하시겠습니까?",
                          positiveBtnTitle: "예",
                          negativeBtnTitle: "아니오",
                          onDialogCreated: () {},
                        ),
                      ));

              if (outputVo != null && outputVo.checkPositiveBtn) {
                // positive 버튼을 눌렀을 때
                // 권한 설정으로 이동
                openAppSettings();
              }
            } else {
              // 스위치 On 시키기
              PermissionStatus permissionStatus =
                  await Permission.camera.status;

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
                  hoveringListTileViewModel.isSwitchChecked =
                      !hoveringListTileViewModel.isSwitchChecked;
                  hoveringListTileViewModel.isSwitchCheckedAreaGk.currentState
                      ?.refreshUi();
                }
              }
            }
          }),
    );

    // todo 추가하기

    // 디바이스 분기 예시
    if (Platform.isIOS) {
      // ios 일 때

      var versionParts = Platform.operatingSystemVersion
          .split(' ')
          .where((part) => part.contains('.'))
          .first
          .split('.');
      var major = int.parse(versionParts[0]);
      var minor = int.parse(versionParts[1]);

      if (major >= 14) {
        // 14 이상일 때
      }

      if (major > 9 || (major == 9 && minor >= 3)) {
        // 9.3 이상일 때
      }
    } else if (Platform.isAndroid) {
      // android 일때

      if (gd_const.androidApiLevel! < 33) {
        // android 33 미만
      }
    }

    return hoveringListTileViewModel;
  }

  // [private 함수]
  void _doNothing() {}

  // (모든 권한을 확인 하고 리스트 정보 갱신)
  Future<void> _checkAllPermissionsAsync() async {
    for (HoveringListTileViewModel hoveringTileViewModel
        in hoveringTileViewModelList) {
      switch (hoveringTileViewModel.permissionTypeEnum) {
        case PermissionTypeEnum.camera:
          {
            // Camera 권한 여부 확인
            PermissionStatus permissionStatus = await Permission.camera.status;

            if (permissionStatus.isGranted) {
              hoveringTileViewModel.isSwitchChecked = true;
            } else {
              hoveringTileViewModel.isSwitchChecked = false;
            }
            hoveringTileViewModel.isSwitchCheckedAreaGk.currentState
                ?.refreshUi();
          }
          break;
        // todo 추가하기
      }
    }
  }
}

class HoveringListTileViewModel {
  HoveringListTileViewModel(
      {required this.itemTitle,
      required this.itemDescription,
      required this.onItemClicked,
      required this.permissionTypeEnum});

  // [public 변수]
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> hoveringTileAreaGk =
      GlobalKey();
  late BuildContext hoveringTileAreaContext;
  bool isHovering = false;

  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> isSwitchCheckedAreaGk =
      GlobalKey();
  late BuildContext isSwitchCheckedAreaContext;
  bool isSwitchChecked = false;

  final String itemTitle;
  final String itemDescription;
  final void Function({required int index}) onItemClicked;
  final PermissionTypeEnum permissionTypeEnum;
}

enum PermissionTypeEnum {
  // Android : Camera, iOS : Photos (Camera Roll and Camera)
  camera,
  // todo 추가하기
}
