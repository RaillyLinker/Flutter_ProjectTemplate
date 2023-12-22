// (external)
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/pages/all/all_page_page_and_router_sample_list/main_widget.dart'
    as all_page_page_and_router_sample_list;
import 'package:flutter_project_template/pages/all/all_page_dialog_sample_list/main_widget.dart'
    as all_page_dialog_sample_list;
import 'package:flutter_project_template/pages/all/all_page_dialog_animation_sample_list/main_widget.dart'
    as all_page_dialog_animation_sample_list;
import 'package:flutter_project_template/pages/all/all_page_network_request_sample_list/main_widget.dart'
    as all_page_network_request_sample_list;
import 'package:flutter_project_template/pages/all/all_page_auth_sample/main_widget.dart'
    as all_page_auth_sample;
import 'package:flutter_project_template/pages/all/all_page_etc_sample_list/main_widget.dart'
    as all_page_etc_sample_list;

// (mobile)
import 'package:flutter_project_template/pages/mobile/mobile_page_permission_sample_list/main_widget.dart'
    as mobile_page_permission_sample_list;

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
          itemTitle: "페이지 / 라우터 샘플 리스트",
          itemDescription: "페이지 이동, 파라미터 전달 등의 샘플 리스트",
          onItemClicked: () {
            mainContext
                .pushNamed(all_page_page_and_router_sample_list.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "다이얼로그 샘플 리스트",
          itemDescription: "다이얼로그 호출 샘플 리스트",
          onItemClicked: () {
            mainContext.pushNamed(all_page_dialog_sample_list.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "다이얼로그 애니메이션 샘플 리스트",
          itemDescription: "다이얼로그 호출 애니메이션 샘플 리스트",
          onItemClicked: () {
            mainContext
                .pushNamed(all_page_dialog_animation_sample_list.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "네트워크 요청 샘플 리스트",
          itemDescription: "네트워크 요청 및 응답 처리 샘플 리스트",
          onItemClicked: () {
            mainContext
                .pushNamed(all_page_network_request_sample_list.pageName);
          }),
    );

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      hoveringListTileViewModel.add(
        HoveringListTileViewModel(
            itemTitle: "모바일 권한 샘플 리스트",
            itemDescription: "모바일 디바이스 권한 처리 샘플 리스트",
            onItemClicked: () {
              mainContext
                  .pushNamed(mobile_page_permission_sample_list.pageName);
            }),
      );
    }

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "계정 샘플",
          itemDescription: "계정 관련 기능 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_auth_sample.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "기타 샘플 리스트",
          itemDescription: "기타 테스트 샘플을 모아둔 리스트",
          onItemClicked: () {
            mainContext.pushNamed(all_page_etc_sample_list.pageName);
          }),
    );

    return hoveringListTileViewModel;
  }

  // [private 함수]
  void _doNothing() {}
}

class HoveringListTileViewModel {
  HoveringListTileViewModel(
      {required this.itemTitle,
      required this.itemDescription,
      required this.onItemClicked});

  // [public 변수]
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> hoveringTileAreaGk =
      GlobalKey();
  late BuildContext hoveringTileAreaContext;
  bool isHovering = false;

  final String itemTitle;
  final String itemDescription;
  final void Function() onItemClicked;
}
