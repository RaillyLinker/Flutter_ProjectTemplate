// (external)
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/pages/all/all_page_crypt_sample/main_widget.dart'
    as all_page_crypt_sample;
import 'package:flutter_project_template/pages/all/all_page_global_variable_state_test_sample/main_widget.dart'
    as all_page_global_variable_state_test_sample;
import 'package:flutter_project_template/pages/all/all_page_shared_preferences_sample/main_widget.dart'
    as all_page_shared_preferences_sample;
import 'package:flutter_project_template/pages/all/all_page_url_launcher_sample/main_widget.dart'
    as all_page_url_launcher_sample;
import 'package:flutter_project_template/pages/all/all_page_widget_change_animation_sample_list/main_widget.dart'
    as all_page_widget_change_animation_sample_list;
import 'package:flutter_project_template/pages/all/all_page_gif_sample/main_widget.dart'
    as all_page_gif_sample;
import 'package:flutter_project_template/pages/all/all_page_image_selector_sample/main_widget.dart'
    as all_page_image_selector_sample;
import 'package:flutter_project_template/pages/all/all_page_image_loading_sample/main_widget.dart'
    as all_page_image_loading_sample;
import 'package:flutter_project_template/pages/all/all_page_context_menu_sample/main_widget.dart'
    as all_page_context_menu_sample;
import 'package:flutter_project_template/pages/all/all_page_gesture_area_overlap_test/main_widget.dart'
    as all_page_gesture_area_overlap_test;
import 'package:flutter_project_template/pages/all/all_page_form_sample/main_widget.dart'
    as all_page_form_sample;
import 'package:flutter_project_template/pages/all/all_page_horizontal_scroll_test/main_widget.dart'
    as all_page_horizontal_scroll_test;

// (app)
import 'package:flutter_project_template/pages/app/app_page_server_sample/main_widget.dart'
    as app_page_server_sample;

// (pc)
import 'package:flutter_project_template/pages/pc/pc_page_flutter_resource_image_resize/main_widget.dart'
    as pc_page_flutter_resource_image_resize;

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
          itemTitle: "가로 스크롤 테스트",
          itemDescription: "모바일 이외 환경에서 가로 스크롤 작동을 테스트 하기 위한 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_horizontal_scroll_test.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "SharedPreferences 샘플",
          itemDescription: "SharedPreferences 사용 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_shared_preferences_sample.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Url Launcher 샘플",
          itemDescription: "Url Launcher 사용 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_url_launcher_sample.pageName);
          }),
    );

    if (!kIsWeb) {
      hoveringListTileViewModel.add(
        HoveringListTileViewModel(
            itemTitle: "서버 샘플",
            itemDescription: "서버 포트 개방 샘플",
            onItemClicked: () {
              mainContext.pushNamed(app_page_server_sample.pageName);
            }),
      );
    }

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "전역 변수 상태 확인 샘플",
          itemDescription: "전역 변수 사용시의 상태 확인용 샘플 (특히 웹에서 새 탭으로 접속 했을 때를 확인하기)",
          onItemClicked: () {
            mainContext
                .pushNamed(all_page_global_variable_state_test_sample.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "위젯 변경 애니메이션 샘플 리스트",
          itemDescription: "위젯 변경시의 애니메이션 적용 샘플 리스트",
          onItemClicked: () {
            mainContext.pushNamed(
                all_page_widget_change_animation_sample_list.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "암/복호화 샘플",
          itemDescription: "암호화, 복호화 적용 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_crypt_sample.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "GIF 샘플",
          itemDescription: "GIF 이미지 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_gif_sample.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "이미지 선택 샘플",
          itemDescription: "로컬 저장소, 혹은 카메라에서 이미지를 가져오는 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_image_selector_sample.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "이미지 로딩 샘플",
          itemDescription: "네트워크 이미지를 가져올 때 로딩 처리 및 에러 처리 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_image_loading_sample.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "컨텍스트 메뉴 샘플",
          itemDescription: "마우스 우클릭시(모바일에서는 롱 클릭) 나타나는 메뉴 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_context_menu_sample.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Gesture 위젯 영역 중첩 테스트",
          itemDescription: "Gesture 위젯 영역 중첩시 동작을 테스트합니다.",
          onItemClicked: () {
            mainContext.pushNamed(all_page_gesture_area_overlap_test.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Form 입력 샘플",
          itemDescription: "Form 입력 작성 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_form_sample.pageName);
          }),
    );

    if (!kIsWeb && !Platform.isAndroid && !Platform.isIOS) {
      // pc
      hoveringListTileViewModel.add(
        HoveringListTileViewModel(
            itemTitle: "플러터 이미지 리소스 리사이징",
            itemDescription: "플러터 이미지 리소스 리사이징",
            onItemClicked: () {
              mainContext
                  .pushNamed(pc_page_flutter_resource_image_resize.pageName);
            }),
      );
    }

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
