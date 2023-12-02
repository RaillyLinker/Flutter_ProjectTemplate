// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_math/vector_math.dart' as math;

// (inner Folder)
import 'page_widget.dart' as page_widget;
import 'inner_widgets/iw_sample_list/sf_widget_state.dart'
    as iw_sample_list_state;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../a_templates/all_dialog_template/dialog_widget.dart'
    as all_dialog_template_view;
import '../../../a_templates/all_dialog_template/dialog_widget_state.dart'
    as all_dialog_template_state;
import '../../../dialogs/all/all_dialog_small_circle_transform_sample/dialog_widget.dart'
    as all_dialog_small_circle_transform_sample;
import '../../../dialogs/all/all_dialog_small_circle_transform_sample/dialog_widget_state.dart'
    as all_dialog_small_circle_transform_sample_state;

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

  final GlobalKey<iw_sample_list_state.SfWidgetState> iwSampleListStateGk =
      GlobalKey();

  // [private 변수]

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  void onRotateAnimationItemClicked() {
    var dialogGk = GlobalKey<all_dialog_template_state.DialogWidgetState>();

    // 회전 애니메이션
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "",
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.rotate(
          angle: math.radians(a1.value * 360),
          child: all_dialog_template_view.DialogWidget(
            globalKey: dialogGk,
            inputVo: const all_dialog_template_view.InputVo(),
            onDialogCreated: () {},
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    ).then((outputVo) {});
  }

  void onScaleAnimationItemClicked() {
    var dialogGk = GlobalKey<all_dialog_template_state.DialogWidgetState>();

    // 확대 애니메이션
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "",
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: all_dialog_template_view.DialogWidget(
            globalKey: dialogGk,
            inputVo: const all_dialog_template_view.InputVo(),
            onDialogCreated: () {},
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    ).then((outputVo) {});
  }

  void onSlideDownAnimationItemClicked() {
    var dialogGk = GlobalKey<all_dialog_template_state.DialogWidgetState>();

    // Slide Down 애니메이션
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "",
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 1600, 0.0),
          child: all_dialog_template_view.DialogWidget(
            globalKey: dialogGk,
            inputVo: const all_dialog_template_view.InputVo(),
            onDialogCreated: () {},
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    ).then((outputVo) {});
  }

  void onSmallCircleTransformItemClicked() {
    // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
    final GlobalKey<
            all_dialog_small_circle_transform_sample_state.DialogWidgetState>
        allDialogSmallCircleTransformSampleGk = GlobalKey();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            all_dialog_small_circle_transform_sample.DialogWidget(
              globalKey: allDialogSmallCircleTransformSampleGk,
              inputVo: const all_dialog_small_circle_transform_sample.InputVo(),
              onDialogCreated: () {},
            )).then((outputVo) {});
  }

// [private 함수]
}
