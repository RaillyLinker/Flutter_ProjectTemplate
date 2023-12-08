// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_classes/gc_my_classes.dart' as gc_my_classes;
import '../../../global_functions/gf_my_functions.dart' as gf_my_functions;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_classes/gc_animated_builder.dart'
    as gc_animated_builder;

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
  final gw_page_outer_frame_business.SlWidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.SlWidgetBusiness();

  // (아이템 리스트)
  List<SampleItemViewModel> itemList = [];
  gc_template_classes.RefreshableBloc itemListBloc =
      gc_template_classes.RefreshableBloc();

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

  // 현재 적용중인 샘플 위젯
  Widget sampleWidget = Container(
    key: const ValueKey<int>(0),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(50.0),
    ),
    width: 100.0,
    height: 100.0,
  );
  gc_template_classes.RefreshableBloc sampleWidgetBloc =
      gc_template_classes.RefreshableBloc();

  // 샘플 위젯 타입 (0, 1, 2)
  SampleWidgetEnum sampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  // (아이템 리스트 세팅)
  void setListItem() {
    itemList = [];
    itemList.add(SampleItemViewModel(
        itemTitle: "애니메이션 없음",
        itemDescription: "애니메이션을 적용하지 않고 위젯 변경",
        onItemClicked: () {
          // 애니메이션 없음

          int sampleWidgetKeyValue = int.parse(
              gf_my_functions.getWidgetKeyValue(widget: sampleWidget)!);
          if (sampleWidgetEnum == SampleWidgetEnum.blueCircleWidget) {
            sampleWidgetEnum = SampleWidgetEnum.greenRoundSquareWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else if (sampleWidgetEnum ==
              SampleWidgetEnum.greenRoundSquareWidget) {
            sampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(0.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else {
            sampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          }

          widgetChangeAnimatedSwitcherConfig =
              gc_my_classes.AnimatedSwitcherConfig(
                  duration: const Duration(milliseconds: 0),
                  reverseDuration: null);
          sampleWidgetBloc.refreshUi();
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "Fade 애니메이션",
        itemDescription: "Fade 애니메이션을 적용하고 위젯 변경",
        onItemClicked: () {
          // Fade 애니메이션 적용

          int sampleWidgetKeyValue = int.parse(
              gf_my_functions.getWidgetKeyValue(widget: sampleWidget)!);
          if (sampleWidgetEnum == SampleWidgetEnum.blueCircleWidget) {
            sampleWidgetEnum = SampleWidgetEnum.greenRoundSquareWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else if (sampleWidgetEnum ==
              SampleWidgetEnum.greenRoundSquareWidget) {
            sampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(0.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else {
            sampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: 100.0,
              height: 100.0,
            );
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
          sampleWidgetBloc.refreshUi();
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "Scale Transition 애니메이션",
        itemDescription: "Scale Transition 애니메이션을 적용하고 위젯 변경",
        onItemClicked: () {
          // Scale 애니메이션 적용

          int sampleWidgetKeyValue = int.parse(
              gf_my_functions.getWidgetKeyValue(widget: sampleWidget)!);
          if (sampleWidgetEnum == SampleWidgetEnum.blueCircleWidget) {
            sampleWidgetEnum = SampleWidgetEnum.greenRoundSquareWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else if (sampleWidgetEnum ==
              SampleWidgetEnum.greenRoundSquareWidget) {
            sampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(0.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else {
            sampleWidgetEnum = SampleWidgetEnum.blueCircleWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: 100.0,
              height: 100.0,
            );
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
          sampleWidgetBloc.refreshUi();
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "Flip 애니메이션",
        itemDescription: "Flip 애니메이션을 적용하고 위젯 변경",
        onItemClicked: () {
          // Flip 애니메이션 적용

          int sampleWidgetKeyValue = int.parse(
              gf_my_functions.getWidgetKeyValue(widget: sampleWidget)!);
          if (sampleWidgetEnum == SampleWidgetEnum.redSquareWidget) {
            sampleWidgetEnum = SampleWidgetEnum.blueSquareWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(0.0),
              ),
              width: 100.0,
              height: 100.0,
            );
          } else {
            sampleWidgetEnum = SampleWidgetEnum.redSquareWidget;
            sampleWidget = Container(
              // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
              key: ValueKey<int>(sampleWidgetKeyValue + 1),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(0.0),
              ),
              width: 100.0,
              height: 100.0,
            );
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
          sampleWidgetBloc.refreshUi();
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

class MemberInfoViewModel {
  const MemberInfoViewModel(
      {required this.memberUid,
      required this.tokenType,
      required this.accessToken,
      required this.accessTokenExpireWhen,
      required this.refreshToken,
      required this.refreshTokenExpireWhen});

  final String memberUid;
  final String tokenType;
  final String accessToken;
  final String accessTokenExpireWhen;
  final String refreshToken;
  final String refreshTokenExpireWhen;
}

enum SampleWidgetEnum {
  blueCircleWidget,
  greenRoundSquareWidget,
  redSquareWidget,
  blueSquareWidget,
}
