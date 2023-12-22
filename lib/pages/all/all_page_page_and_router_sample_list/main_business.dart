// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/pages/all/all_page_input_and_output_push_test/main_widget.dart'
    as all_page_input_and_output_push_test;
import 'package:flutter_project_template/a_templates/all_page_template/main_widget.dart'
    as all_page_template;
import 'package:flutter_project_template/pages/all/all_page_page_transition_animation_sample_list/main_widget.dart'
    as all_page_page_transition_animation_sample_list;
import 'package:flutter_project_template/pages/all/all_page_grid_sample/main_widget.dart'
    as all_page_grid_sample;
import 'package:flutter_project_template/pages/all/all_page_stateful_and_lifecycle_test/main_widget.dart'
    as all_page_stateful_and_lifecycle_test;

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
          itemTitle: "페이지 템플릿",
          itemDescription: "템플릿 페이지를 호출합니다.",
          onItemClicked: () {
            mainContext.pushNamed(all_page_template.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "페이지 Stateful 상태 및 생명주기 테스트",
          itemDescription: "페이지 Stateful 상태 및 생명주기를 테스트 합니다.",
          onItemClicked: () {
            mainContext
                .pushNamed(all_page_stateful_and_lifecycle_test.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "페이지 입/출력 테스트",
          itemDescription: "페이지 Push 시에 전달하는 입력값, Pop 시에 반환하는 출력값 테스트",
          onItemClicked: () async {
            all_page_input_and_output_push_test.OutputVo? pageResult =
                await mainContext.pushNamed(
                    all_page_input_and_output_push_test.pageName,
                    queryParameters: {
                  "inputValueString": "테스트 입력값",
                  "inputValueStringList": ["a", "b", "c"],
                  "inputValueInt": "1234" // int 를 원하더라도, 여기선 String 으로 줘야함
                });

            BuildContext context = mainContext;
            if (pageResult == null) {
              if (!context.mounted) return;
              showToast(
                "반환값이 없습니다.",
                context: context,
                animation: StyledToastAnimation.scale,
              );
            } else {
              if (!context.mounted) return;
              showToast(
                pageResult.resultValue,
                context: context,
                animation: StyledToastAnimation.scale,
              );
            }
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "페이지 이동 애니메이션 샘플 리스트",
          itemDescription: "페이지 이동시 적용되는 애니메이션 샘플 리스트",
          onItemClicked: () {
            mainContext.pushNamed(
                all_page_page_transition_animation_sample_list.pageName);
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "페이지 Grid 샘플",
          itemDescription: "화면 사이즈에 따라 동적으로 변하는 Grid 페이지 샘플",
          onItemClicked: () {
            mainContext.pushNamed(all_page_grid_sample.pageName);
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
