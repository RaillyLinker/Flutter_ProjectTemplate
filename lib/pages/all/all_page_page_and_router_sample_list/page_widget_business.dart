// (external)
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../all_page_input_and_output_push_test/page_widget.dart'
    as all_page_input_and_output_push_test;
import '../../../a_templates/all_page_template/page_widget.dart'
    as all_page_template;
import '../../../pages/all/all_page_page_transition_animation_sample_list/page_widget.dart'
    as all_page_page_transition_animation_sample_list;
import '../../../pages/all/all_page_grid_sample/page_widget.dart'
    as all_page_grid_sample;
import '../../../pages/all/all_page_stateful_and_lifecycle_test/page_widget.dart'
    as all_page_stateful_and_lifecycle_test;

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
        itemTitle: "페이지 템플릿",
        itemDescription: "템플릿 페이지를 호출합니다.",
        onItemClicked: () {
          context.pushNamed(all_page_template.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "Stateful 및 라이프사이클 테스트",
        itemDescription: "위젯 상태 변경 테스트",
        onItemClicked: () {
          context.pushNamed(all_page_stateful_and_lifecycle_test.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "페이지 입/출력 테스트",
        itemDescription: "페이지 Push 시에 전달하는 입력값, Pop 시에 반환하는 출력값 테스트",
        onItemClicked: () async {
          all_page_input_and_output_push_test.OutputVo? pageResult =
              await context.pushNamed(
                  all_page_input_and_output_push_test.pageName,
                  queryParameters: {
                "inputValueString": "테스트 입력값",
                "inputValueStringList": ["a", "b", "c"],
                "inputValueInt": "1234" // int 를 원하더라도, 여기선 String 으로 줘야함
              });

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
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "페이지 이동 애니메이션 샘플 리스트",
        itemDescription: "페이지 이동시 적용되는 애니메이션 샘플 리스트",
        onItemClicked: () {
          context.pushNamed(
              all_page_page_transition_animation_sample_list.pageName);
        }));

    itemList.add(SampleItemViewModel(
        itemTitle: "페이지 Grid 샘플",
        itemDescription: "화면 사이즈에 따라 동적으로 변하는 Grid 페이지 샘플",
        onItemClicked: () {
          context.pushNamed(all_page_grid_sample.pageName);
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
