// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vector_math/vector_math.dart' as math;

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import '../../../global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../a_templates/all_dialog_template/dialog_widget.dart'
    as all_dialog_template_view;
import '../../../a_templates/all_dialog_template/dialog_widget_business.dart'
    as all_dialog_template_state;
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
        itemTitle: "회전 애니메이션",
        itemDescription: "다이얼로그가 회전하며 나타납니다.",
        onItemClicked: () {
          var dialogBusiness = all_dialog_template_state.DialogWidgetBusiness();

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
                  business: dialogBusiness,
                  inputVo: const all_dialog_template_view.InputVo(),
                  onDialogCreated: () {},
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ).then((outputVo) {});
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "확대 애니메이션",
        itemDescription: "다이얼로그가 확대되며 나타납니다.",
        onItemClicked: () {
          var dialogBusiness = all_dialog_template_state.DialogWidgetBusiness();

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
                  business: dialogBusiness,
                  inputVo: const all_dialog_template_view.InputVo(),
                  onDialogCreated: () {},
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ).then((outputVo) {});
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "슬라이드 다운 애니메이션",
        itemDescription: "다이얼로그가 위에서 아래로 나타납니다.",
        onItemClicked: () {
          var dialogBusiness = all_dialog_template_state.DialogWidgetBusiness();

          // Slide Down 애니메이션
          showGeneralDialog(
            barrierDismissible: true,
            barrierLabel: "",
            context: context,
            pageBuilder: (ctx, a1, a2) {
              return Container();
            },
            transitionBuilder: (context, a1, a2, widget) {
              final curvedValue =
                  Curves.easeInOutBack.transform(a1.value) - 1.0;
              return Transform(
                transform:
                    Matrix4.translationValues(0.0, curvedValue * 1600, 0.0),
                child: all_dialog_template_view.DialogWidget(
                  business: dialogBusiness,
                  inputVo: const all_dialog_template_view.InputVo(),
                  onDialogCreated: () {},
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ).then((outputVo) {});
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "작은 원으로 소멸하는 애니메이션",
        itemDescription: "작업이 완료되면 작은 원으로 변하였다가 사라집니다.",
        onItemClicked: () {
          // 다이얼로그에서 다른 다이얼로그를 호출하는 샘플
          final all_dialog_small_circle_transform_sample_business
              .DialogWidgetBusiness
              allDialogSmallCircleTransformSampleBusiness =
              all_dialog_small_circle_transform_sample_business
                  .DialogWidgetBusiness();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) =>
                  all_dialog_small_circle_transform_sample.DialogWidget(
                    business: allDialogSmallCircleTransformSampleBusiness,
                    inputVo: const all_dialog_small_circle_transform_sample
                        .InputVo(),
                    onDialogCreated: () async {
                      // 2초 대기
                      await Future.delayed(const Duration(seconds: 2));

                      // 다이얼로그 완료 처리
                      allDialogSmallCircleTransformSampleBusiness
                          .dialogComplete();
                    },
                  )).then((outputVo) {});
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
