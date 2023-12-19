// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_math/vector_math.dart' as math;

// (inner_folder)
import 'main_widget.dart' as main_widget;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;
import 'package:flutter_project_template/a_templates/all_dialog_template/main_widget.dart'
    as all_dialog_template;
import 'package:flutter_project_template/dialogs/all/all_dialog_small_circle_transform_sample/main_widget.dart'
    as all_dialog_small_circle_transform_sample;

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
          itemTitle: "회전 애니메이션",
          itemDescription: "다이얼로그가 회전하며 나타납니다.",
          onItemClicked: () {
            final GlobalKey<all_dialog_template.MainWidgetState>
                allDialogTemplateStateGk = GlobalKey();

            // 회전 애니메이션
            showGeneralDialog(
              barrierDismissible: true,
              barrierLabel: "",
              context: mainContext,
              pageBuilder: (ctx, a1, a2) {
                return Container();
              },
              transitionBuilder: (ctx, a1, a2, child) {
                return Transform.rotate(
                  angle: math.radians(a1.value * 360),
                  child: all_dialog_template.MainWidget(
                    key: allDialogTemplateStateGk,
                    inputVo:
                        all_dialog_template.InputVo(onDialogCreated: () {}),
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 300),
            ).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "확대 애니메이션",
          itemDescription: "다이얼로그가 확대되며 나타납니다.",
          onItemClicked: () {
            final GlobalKey<all_dialog_template.MainWidgetState>
                allDialogTemplateStateGk = GlobalKey();

            // 확대 애니메이션
            showGeneralDialog(
              barrierDismissible: true,
              barrierLabel: "",
              context: mainContext,
              pageBuilder: (ctx, a1, a2) {
                return Container();
              },
              transitionBuilder: (ctx, a1, a2, child) {
                var curve = Curves.easeInOut.transform(a1.value);
                return Transform.scale(
                  scale: curve,
                  child: all_dialog_template.MainWidget(
                    key: allDialogTemplateStateGk,
                    inputVo:
                        all_dialog_template.InputVo(onDialogCreated: () {}),
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 300),
            ).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "슬라이드 다운 애니메이션",
          itemDescription: "다이얼로그가 위에서 아래로 나타납니다.",
          onItemClicked: () {
            final GlobalKey<all_dialog_template.MainWidgetState>
                allDialogTemplateStateGk = GlobalKey();

            // Slide Down 애니메이션
            showGeneralDialog(
              barrierDismissible: true,
              barrierLabel: "",
              context: mainContext,
              pageBuilder: (ctx, a1, a2) {
                return Container();
              },
              transitionBuilder: (context, a1, a2, widget) {
                final curvedValue =
                    Curves.easeInOutBack.transform(a1.value) - 1.0;
                return Transform(
                  transform:
                      Matrix4.translationValues(0.0, curvedValue * 1600, 0.0),
                  child: all_dialog_template.MainWidget(
                    key: allDialogTemplateStateGk,
                    inputVo:
                        all_dialog_template.InputVo(onDialogCreated: () {}),
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 300),
            ).then((outputVo) {});
          }),
    );

    hoveringListTileViewModel.add(
      HoveringListTileViewModel(
          itemTitle: "작은 원으로 소멸하는 애니메이션",
          itemDescription: "작업이 완료되면 작은 원으로 변하였다가 사라집니다.",
          onItemClicked: () {
            // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
            final GlobalKey<
                    all_dialog_small_circle_transform_sample.MainWidgetState>
                allDialogSmallCircleTransformSampleAreaGk = GlobalKey();
            showDialog(
                barrierDismissible: false,
                context: mainContext,
                builder: (context) =>
                    all_dialog_small_circle_transform_sample.MainWidget(
                      key: allDialogSmallCircleTransformSampleAreaGk,
                      inputVo: all_dialog_small_circle_transform_sample.InputVo(
                        onDialogCreated: () async {
                          // 2초 대기
                          await Future.delayed(const Duration(seconds: 2));

                          // 다이얼로그 완료 처리
                          allDialogSmallCircleTransformSampleAreaGk
                              .currentState?.mainBusiness
                              .dialogComplete();
                        },
                      ),
                    )).then((outputVo) {});
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
