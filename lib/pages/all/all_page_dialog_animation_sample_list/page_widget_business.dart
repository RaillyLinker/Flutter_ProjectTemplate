// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_math/vector_math.dart' as math;

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import '../../../global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import '../../../global_widgets/todo_do_delete.dart' as gw_do_delete;
import '../../../a_templates/all_dialog_template/main_widget.dart'
    as all_dialog_template;
import '../../../dialogs/all/all_dialog_small_circle_transform_sample/dialog_widget.dart'
    as all_dialog_small_circle_transform_sample;
import '../../../dialogs/all/all_dialog_small_circle_transform_sample/dialog_widget_business.dart'
    as all_dialog_small_circle_transform_sample_business;

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

  page_widget.InputVo? onCheckPageInputVo(
      {required BuildContext context, required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!! - 필수 정보 누락시 null 반환
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   return null;
    // }

    // !!!PageInputVo 입력!!!
    return const page_widget.InputVo();
  }

  // [public 변수]
  // (페이지 뷰모델 객체)
  late PageWidgetViewModel viewModel;

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

  void onRotateAnimationItemClicked() {
    final GlobalKey<all_dialog_template.MainWidgetState>
        allDialogTemplateStateGk = GlobalKey();

    // 회전 애니메이션
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "",
      context: viewModel.context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.rotate(
          angle: math.radians(a1.value * 360),
          child: all_dialog_template.MainWidget(
            key: allDialogTemplateStateGk,
            inputVo: all_dialog_template.InputVo(onDialogCreated: () {}),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    ).then((outputVo) {});
  }

  void onScaleUpAnimationItemClicked() {
    final GlobalKey<all_dialog_template.MainWidgetState>
        allDialogTemplateStateGk = GlobalKey();

    // 확대 애니메이션
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "",
      context: viewModel.context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: all_dialog_template.MainWidget(
            key: allDialogTemplateStateGk,
            inputVo: all_dialog_template.InputVo(onDialogCreated: () {}),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    ).then((outputVo) {});
  }

  void onSlideDownAnimationItemClicked() {
    final GlobalKey<all_dialog_template.MainWidgetState>
        allDialogTemplateStateGk = GlobalKey();

    // Slide Down 애니메이션
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "",
      context: viewModel.context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 1600, 0.0),
          child: all_dialog_template.MainWidget(
            key: allDialogTemplateStateGk,
            inputVo: all_dialog_template.InputVo(onDialogCreated: () {}),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    ).then((outputVo) {});
  }

  void onSmallCircleCloseAnimationItemClicked() {
    // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
    final all_dialog_small_circle_transform_sample_business.DialogWidgetBusiness
        allDialogSmallCircleTransformSampleBusiness =
        all_dialog_small_circle_transform_sample_business
            .DialogWidgetBusiness();
    showDialog(
        barrierDismissible: false,
        context: viewModel.context,
        builder: (context) =>
            all_dialog_small_circle_transform_sample.DialogWidget(
              business: allDialogSmallCircleTransformSampleBusiness,
              inputVo: const all_dialog_small_circle_transform_sample.InputVo(),
              onDialogCreated: () async {
                // 2초 대기
                await Future.delayed(const Duration(seconds: 2));

                // 다이얼로그 완료 처리
                allDialogSmallCircleTransformSampleBusiness.dialogComplete();
              },
            )).then((outputVo) {});
  }

// !!!사용 함수 추가하기!!!
}

// (페이지에서 사용할 변수 저장 클래스)
class PageWidgetViewModel {
  PageWidgetViewModel(
      {required this.context, required page_widget.InputVo? inputVo}) {
    if (inputVo == null) {
      // !!!InputVo 가 충족 되지 않은 경우에 대한 처리!!!
      context.pop();
    } else {
      this.inputVo = inputVo;
    }
  }

  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (페이지 컨텍스트 객체)
  BuildContext context;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

// !!!페이지에서 사용할 변수를 아래에 선언하기!!!

  // (pageOutFrameBusiness)
  final gw_slw_page_outer_frame.SlwPageOuterFrameBusiness pageOutFrameBusiness =
      gw_slw_page_outer_frame.SlwPageOuterFrameBusiness();
  final GlobalKey<gw_do_delete.SfwListViewBuilderState>
      sfwListViewBuilderStateGk = GlobalKey();
}
