// (external)
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/global_classes/gc_my_classes.dart'
    as gc_my_classes;
import 'package:flutter_project_template/global_classes/gc_animated_builder.dart'
    as gc_animated_builder;

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

  // 현재 샘플 위젯 타입
  final GlobalKey<gw_sfw_wrapper.SfwRefreshWrapperState> sampleWidgetAreaGk =
      GlobalKey();
  late BuildContext sampleWidgetContext;
  SampleWidgetEnum nowSampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;

  // 위젯 변경 애니메이션
  gc_my_classes.AnimatedSwitcherConfig widgetChangeAnimatedSwitcherConfig =
      gc_my_classes.AnimatedSwitcherConfig(
          duration: const Duration(
            milliseconds: 0,
          ),
          reverseDuration: null,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          });

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
          itemTitle: "애니메이션 없음",
          itemDescription: "애니메이션을 적용하지 않고 위젯 변경",
          onItemClicked: () {
            // 애니메이션 없음
            if (nowSampleWidgetEnum == SampleWidgetEnum.blueCircleWidget) {
              nowSampleWidgetEnum = SampleWidgetEnum.greenRoundSquareWidget;
            } else if (nowSampleWidgetEnum ==
                SampleWidgetEnum.greenRoundSquareWidget) {
              nowSampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            } else {
              nowSampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;
            }

            widgetChangeAnimatedSwitcherConfig =
                gc_my_classes.AnimatedSwitcherConfig(
                    duration: const Duration(milliseconds: 0),
                    reverseDuration: null);
            refreshUi();
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Fade 애니메이션",
          itemDescription: "Fade 애니메이션을 적용하고 위젯 변경",
          onItemClicked: () {
            // Fade 애니메이션 적용

            if (nowSampleWidgetEnum == SampleWidgetEnum.blueCircleWidget) {
              nowSampleWidgetEnum = SampleWidgetEnum.greenRoundSquareWidget;
            } else if (nowSampleWidgetEnum ==
                SampleWidgetEnum.greenRoundSquareWidget) {
              nowSampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            } else {
              nowSampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;
            }

            widgetChangeAnimatedSwitcherConfig =
                gc_my_classes.AnimatedSwitcherConfig(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    reverseDuration: null,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    });
            refreshUi();
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Scale Transition 애니메이션",
          itemDescription: "Scale Transition 애니메이션을 적용하고 위젯 변경",
          onItemClicked: () {
            // Scale 애니메이션 적용

            if (nowSampleWidgetEnum == SampleWidgetEnum.blueCircleWidget) {
              nowSampleWidgetEnum = SampleWidgetEnum.greenRoundSquareWidget;
            } else if (nowSampleWidgetEnum ==
                SampleWidgetEnum.greenRoundSquareWidget) {
              nowSampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            } else {
              nowSampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;
            }

            widgetChangeAnimatedSwitcherConfig =
                gc_my_classes.AnimatedSwitcherConfig(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    reverseDuration: null,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    });
            refreshUi();
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "Flip 애니메이션",
          itemDescription: "Flip 애니메이션을 적용하고 위젯 변경",
          onItemClicked: () {
            // Flip 애니메이션 적용

            if (nowSampleWidgetEnum == SampleWidgetEnum.redSquareWidget) {
              nowSampleWidgetEnum = SampleWidgetEnum.blueSquareWidget;
            } else {
              nowSampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            }

            widgetChangeAnimatedSwitcherConfig =
                gc_my_classes.AnimatedSwitcherConfig(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    reverseDuration: null,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return gc_animated_builder.wrapAnimatedBuilder(
                          child: child, animation: animation);
                    });
            refreshUi();
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

enum SampleWidgetEnum {
  blueCircleWidget,
  greenRoundSquareWidget,
  redSquareWidget,
  blueSquareWidget,
}
