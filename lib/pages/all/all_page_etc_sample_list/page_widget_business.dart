// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/a_must_delete/todo_gc_delete.dart'
    as gc_template_classes;
import 'package:flutter_project_template/pages/all/all_page_crypt_sample/page_widget.dart'
    as all_page_crypt_sample;
import 'package:flutter_project_template/pages/all/all_page_global_variable_state_test_sample/page_widget.dart'
    as all_page_global_variable_state_test_sample;
import 'package:flutter_project_template/pages/all/all_page_shared_preferences_sample/page_entrance.dart'
    as all_page_shared_preferences_sample;
import 'package:flutter_project_template/pages/all/all_page_url_launcher_sample/page_entrance.dart'
    as all_page_url_launcher_sample;
import 'package:flutter_project_template/pages/all/all_page_widget_change_animation_sample_list/page_widget.dart'
    as all_page_widget_change_animation_sample_list;
import 'package:flutter_project_template/pages/all/all_page_gif_sample/main_widget.dart'
    as all_page_gif_sample;
import 'package:flutter_project_template/pages/all/all_page_image_selector_sample/page_widget.dart'
    as all_page_image_selector_sample;
import 'package:flutter_project_template/pages/all/all_page_image_loading_sample/page_widget.dart'
    as all_page_image_loading_sample;
import 'package:flutter_project_template/pages/all/all_page_context_menu_sample/main_widget.dart'
    as all_page_context_menu_sample;
import 'package:flutter_project_template/pages/all/all_page_gesture_area_overlap_test/page_widget.dart'
    as all_page_gesture_area_overlap_test;
import 'package:flutter_project_template/pages/all/all_page_form_sample/page_widget.dart'
    as all_page_form_sample;
import 'package:flutter_project_template/pages/all/all_page_horizontal_scroll_test/page_widget.dart'
    as all_page_horizontal_scroll_test;

// (app)
import 'package:flutter_project_template/pages/app/app_page_server_sample/page_entrance.dart'
    as app_page_server_sample;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageWidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState() {
    // !!!initState 로직 작성!!!

    setListItem();
  }

  // (전체 위젯 dispose)
  void dispose() {
    // !!!initState 로직 작성!!!
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained() async {
    // !!!onFocusGained 로직 작성!!!
  }

  Future<void> onFocusLost() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityGained() async {
    // !!!onFocusLost 로직 작성!!!
  }

  Future<void> onVisibilityLost() async {
    // !!!onVisibilityLost 로직 작성!!!
  }

  Future<void> onForegroundGained() async {
    // !!!onForegroundGained 로직 작성!!!
  }

  Future<void> onForegroundLost() async {
    // !!!onForegroundLost 로직 작성!!!
  }

  void onCheckPageInputVo({required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }

    // !!!PageInputVo 입력!!!
    inputVo = const page_widget.InputVo();
  }

  // [public 변수]
  late BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();

  List<SampleItemViewModel> itemList = [];
  gc_template_classes.RefreshableBloc itemListBloc =
      gc_template_classes.RefreshableBloc();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  void setListItem() {
    itemList = [];
    itemList.add(SampleItemViewModel(
        itemTitle: "가로 스크롤 테스트",
        itemDescription: "모바일 이외 환경에서 가로 스크롤 작동을 테스트 하기 위한 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_horizontal_scroll_test.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "SharedPreferences 샘플",
        itemDescription: "SharedPreferences 사용 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_shared_preferences_sample.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "Url Launcher 샘플",
        itemDescription: "Url Launcher 사용 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_url_launcher_sample.pageName);
        }));

    if (!kIsWeb) {
      itemList.add(SampleItemViewModel(
          itemTitle: "서버 샘플",
          itemDescription: "서버 포트 개방 샘플",
          onItemClicked: () {
            context.pushNamed(app_page_server_sample.pageName);
          }));
    }

    itemList.add(SampleItemViewModel(
        itemTitle: "전역 변수 상태 확인 샘플",
        itemDescription: "전역 변수 사용시의 상태 확인용 샘플 (특히 웹에서 새 탭으로 접속 했을 때를 확인하기)",
        onItemClicked: () {
          context
              .pushNamed(all_page_global_variable_state_test_sample.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "위젯 변경 애니메이션 샘플 리스트",
        itemDescription: "위젯 변경시의 애니메이션 적용 샘플 리스트",
        onItemClicked: () {
          context
              .pushNamed(all_page_widget_change_animation_sample_list.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "암/복호화 샘플",
        itemDescription: "암호화, 복호화 적용 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_crypt_sample.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "GIF 샘플",
        itemDescription: "GIF 이미지 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_gif_sample.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "이미지 선택 샘플",
        itemDescription: "로컬 저장소, 혹은 카메라에서 이미지를 가져오는 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_image_selector_sample.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "이미지 로딩 샘플",
        itemDescription: "네트워크 이미지를 가져올 때 로딩 처리 및 에러 처리 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_image_loading_sample.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "컨텍스트 메뉴 샘플",
        itemDescription: "마우스 우클릭시(모바일에서는 롱 클릭) 나타나는 메뉴 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_context_menu_sample.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "Gesture 위젯 영역 중첩 테스트",
        itemDescription: "Gesture 위젯 영역 중첩시 동작을 테스트합니다.",
        onItemClicked: () {
          context.pushNamed(all_page_gesture_area_overlap_test.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "Form 입력 샘플",
        itemDescription: "Form 입력 작성 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_form_sample.pageName);
        }));

    itemListBloc.refreshUi();
  }

// [private 함수]
}

class SampleItemViewModel {
  SampleItemViewModel(
      {required this.itemTitle,
      required this.itemDescription,
      required this.onItemClicked});

  // 샘플 타이틀
  final String itemTitle;

  // 샘플 설명
  final String itemDescription;

  final void Function() onItemClicked;

  bool isHovering = false;
  gc_template_classes.RefreshableBloc isHoveringBloc =
      gc_template_classes.RefreshableBloc();
}
