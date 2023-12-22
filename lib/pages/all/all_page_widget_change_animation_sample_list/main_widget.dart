// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner_folder)
import 'main_business.dart' as main_business;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;

// [위젯 뷰]

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!! - 폴더명과 동일하게 작성하세요.
const pageName = "all_widget_change_animation_sample_list";

// !!!페이지 호출/반납 애니메이션!!! - 동적으로 변경이 가능합니다.
Widget Function(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child)
    pageTransitionsBuilder = (context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
};

// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo();
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo();
}

//------------------------------------------------------------------------------
class MainWidget extends StatefulWidget {
  const MainWidget({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    if (mainBusiness.pageInitFirst) {
      mainBusiness.pageInitFirst = false;
      mainBusiness.onCreate();
    }
    return PopScope(
      canPop: mainBusiness.canPop,
      child: FocusDetector(
        onFocusGained: () async {
          await mainBusiness.onFocusGainedAsync();
        },
        onFocusLost: () async {
          await mainBusiness.onFocusLostAsync();
        },
        onVisibilityGained: () async {
          await mainBusiness.onVisibilityGainedAsync();
        },
        onVisibilityLost: () async {
          await mainBusiness.onVisibilityLostAsync();
        },
        onForegroundGained: () async {
          await mainBusiness.onForegroundGainedAsync();
        },
        onForegroundLost: () async {
          await mainBusiness.onForegroundLostAsync();
        },
        child: getScreenWidget(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    final InputVo? inputVo =
        mainBusiness.onCheckPageInputVo(goRouterState: widget.goRouterState);
    if (inputVo == null) {
      mainBusiness.inputError = true;
    } else {
      mainBusiness.inputVo = inputVo;
    }
    mainBusiness.initState();
  }

  @override
  void dispose() {
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    mainBusiness.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // [public 변수]
  // (mainBusiness) - 데이터 변수 및 함수 저장 역할
  final main_business.MainBusiness mainBusiness = main_business.MainBusiness();

  //----------------------------------------------------------------------------
  // !!!위젯 관련 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (MainWidget Refresh 함수)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget() {
    // !!!화면 위젯 작성 하기!!!

    if (mainBusiness.inputError == true) {
      // 입력값이 미충족 되었을 때의 화면
      return gw_slw_page_outer_frame.ErrorPageWidget(
        business: gw_slw_page_outer_frame.ErrorPageWidgetBusiness(),
        errorMsg: "잘못된 접근입니다.",
      );
    }

    return gw_slw_page_outer_frame.SlwPageOuterFrame(
      business: mainBusiness.pageOutFrameBusiness,
      pageTitle: "위젯 변경 애니메이션 샘플 리스트",
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 150,
              alignment: Alignment.center,
              child: gw_sfw_wrapper.SfwRefreshWrapper(
                key: mainBusiness.sampleWidgetAreaGk,
                widgetBuild: (sampleWidgetContext) {
                  mainBusiness.sampleWidgetContext = sampleWidgetContext;

                  late Widget changedWidget;
                  if (mainBusiness.nowSampleWidgetEnum ==
                      main_business.SampleWidgetEnum.greenRoundSquareWidget) {
                    changedWidget = Container(
                      key: UniqueKey(), // 애니메이션 적용을 위해 하위 위젯의 키가 달라져야 함.
                      // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      width: 100.0,
                      height: 100.0,
                    );
                  } else if (mainBusiness.nowSampleWidgetEnum ==
                      main_business.SampleWidgetEnum.redSquareWidget) {
                    changedWidget = Container(
                      key: UniqueKey(), // 애니메이션 적용을 위해 하위 위젯의 키가 달라져야 함.
                      // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      width: 100.0,
                      height: 100.0,
                    );
                  } else if (mainBusiness.nowSampleWidgetEnum ==
                      main_business.SampleWidgetEnum.blueCircleWidget) {
                    changedWidget = Container(
                      key: UniqueKey(), // 애니메이션 적용을 위해 하위 위젯의 키가 달라져야 함.
                      // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      width: 100.0,
                      height: 100.0,
                    );
                  } else if (mainBusiness.nowSampleWidgetEnum ==
                      main_business.SampleWidgetEnum.blueSquareWidget) {
                    changedWidget = Container(
                      key: UniqueKey(), // 애니메이션 적용을 위해 하위 위젯의 키가 달라져야 함.
                      // 애니메이션을 적용하려면 적용되는 위젯의 key 가 이전과 달라야 함
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      width: 100.0,
                      height: 100.0,
                    );
                  }

                  return AnimatedSwitcher(
                      duration: mainBusiness
                          .widgetChangeAnimatedSwitcherConfig.duration,
                      reverseDuration: mainBusiness
                          .widgetChangeAnimatedSwitcherConfig.reverseDuration,
                      switchInCurve: mainBusiness
                          .widgetChangeAnimatedSwitcherConfig.switchInCurve,
                      switchOutCurve: mainBusiness
                          .widgetChangeAnimatedSwitcherConfig.switchOutCurve,
                      layoutBuilder: mainBusiness
                          .widgetChangeAnimatedSwitcherConfig.layoutBuilder,
                      transitionBuilder: mainBusiness
                          .widgetChangeAnimatedSwitcherConfig.transitionBuilder,
                      child: changedWidget);
                },
              ),
            ),
            gw_sfw_wrapper.SfwRefreshWrapper(
              key: mainBusiness.hoveringTileViewModelListAreaGk,
              widgetBuild: (hoveringTileListAreaContext) {
                mainBusiness.hoveringTileListAreaContext =
                    hoveringTileListAreaContext;
                return ListView.builder(
                  shrinkWrap: true, // 리스트뷰 크기 고정
                  primary: false, // 리스트뷰 내부는 스크롤 금지
                  itemCount: mainBusiness.hoveringTileViewModelList.length,
                  itemBuilder: (context, index) {
                    final main_business.HoveringListTileViewModel
                        hoveringListTileViewModel =
                        mainBusiness.hoveringTileViewModelList[index];

                    return gw_sfw_wrapper.SfwRefreshWrapper(
                      key: hoveringListTileViewModel.hoveringTileAreaGk,
                      widgetBuild: (hoveringTileAreaContext) {
                        hoveringListTileViewModel.hoveringTileAreaContext =
                            hoveringTileAreaContext;
                        return Column(
                          children: [
                            MouseRegion(
                              // 커서 변경 및 호버링 상태 변경
                              cursor: SystemMouseCursors.click,
                              onEnter: (details) {
                                hoveringListTileViewModel.isHovering = true;
                                hoveringListTileViewModel
                                    .hoveringTileAreaGk.currentState
                                    ?.refreshUi();
                              },
                              onExit: (details) {
                                hoveringListTileViewModel.isHovering = false;
                                hoveringListTileViewModel
                                    .hoveringTileAreaGk.currentState
                                    ?.refreshUi();
                              },
                              child: GestureDetector(
                                // 클릭시 제스쳐 콜백
                                onTap: () {
                                  hoveringListTileViewModel.onItemClicked();
                                },
                                child: Container(
                                  color: hoveringListTileViewModel.isHovering
                                      ? Colors.blue.withOpacity(0.2)
                                      : Colors.white,
                                  child: ListTile(
                                    mouseCursor: SystemMouseCursors.click,
                                    title: Text(
                                      hoveringListTileViewModel.itemTitle,
                                      style: const TextStyle(
                                          fontFamily: "MaruBuri"),
                                    ),
                                    subtitle: Text(
                                      hoveringListTileViewModel.itemDescription,
                                      style: const TextStyle(
                                          fontFamily: "MaruBuri"),
                                    ),
                                    trailing: const Icon(Icons.chevron_right),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 0.1,
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
