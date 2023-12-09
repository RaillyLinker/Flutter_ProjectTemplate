// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget.dart' as page_widget;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget_business.dart'
    as gw_page_outer_frame_business;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_widgets/gw_stateful_test/sf_widget_state.dart'
    as gw_stateful_test_state;
import '../../../pages/all/all_page_page_and_router_sample_list/page_widget.dart'
    as all_page_page_and_router_sample_list;

// [위젯 비즈니스]
// 위젯의 비즈니스 로직 + State 변수 처리는 이 곳에서 합니다.

//------------------------------------------------------------------------------
// 페이지의 비즈니스 로직 담당
// PageBusiness 인스턴스는 해당 페이지가 소멸하기 전까지 활용됩니다.
class PageWidgetBusiness {
  // [콜백 함수]
  // (전체 위젯 initState)
  void initState({required BuildContext context}) {
    // !!!initState 로직 작성!!!
    if (kDebugMode) {
      print("+++ initState 호출됨");
    }
  }

  // (전체 위젯 dispose)
  void dispose({required BuildContext context}) {
    // !!!initState 로직 작성!!!
    if (kDebugMode) {
      print("+++ dispose 호출됨");
    }

    for (var item in pageWidgetViewModel.itemList) {
      item.inputTextFieldController.dispose();
      item.inputTextFieldFocus.dispose();
    }
  }

  // (전체 위젯의 FocusDetector 콜백들)
  Future<void> onFocusGained({required BuildContext context}) async {
    // !!!onFocusGained 로직 작성!!!
    if (kDebugMode) {
      print("+++ onFocusGained 호출됨");
    }
  }

  Future<void> onFocusLost({required BuildContext context}) async {
    // !!!onFocusLost 로직 작성!!!
    if (kDebugMode) {
      print("+++ onFocusLost 호출됨");
    }
  }

  Future<void> onVisibilityGained({required BuildContext context}) async {
    // !!!onFocusLost 로직 작성!!!
    if (kDebugMode) {
      print("+++ onVisibilityGained 호출됨");
    }
  }

  Future<void> onVisibilityLost({required BuildContext context}) async {
    // !!!onVisibilityLost 로직 작성!!!
    if (kDebugMode) {
      print("+++ onVisibilityLost 호출됨");
    }
  }

  Future<void> onForegroundGained({required BuildContext context}) async {
    // !!!onForegroundGained 로직 작성!!!
    if (kDebugMode) {
      print("+++ onForegroundGained 호출됨");
    }
  }

  Future<void> onForegroundLost({required BuildContext context}) async {
    // !!!onForegroundLost 로직 작성!!!
    if (kDebugMode) {
      print("+++ onForegroundLost 호출됨");
    }
  }

  void onCheckPageInputVo(
      {required BuildContext context, required GoRouterState goRouterState}) {
    // !!!pageInputVo 체크!!!
    // ex :
    // if (!goRouterState.uri.queryParameters
    //     .containsKey("inputValueString")) {
    //   // 필수 파라미터가 없는 경우에 대한 처리
    // }
    if (kDebugMode) {
      print("+++ onCheckPageInputVo 호출됨");
    }

    // !!!PageInputVo 입력!!!
    inputVo = const page_widget.InputVo();
  }

  // [public 변수]
  // (페이지 pop 가능 여부 변수)
  bool canPop = true;

  // (위젯 입력값)
  late page_widget.InputVo inputVo;

  // (페이지 뷰모델 객체)
  late PageWidgetViewModel pageWidgetViewModel;

  // [public 함수]
  // (Widget 화면 갱신) - WidgetUi.viewWidgetBuild 의 return 값을 다시 불러 옵니다.
  late VoidCallback refreshUi;

// !!!사용 함수 추가하기!!!

  // (BLoC 샘플 텍스트 클릭시)
  void onBlocSampleClicked() {
    pageWidgetViewModel.blocSampleIntValue += 1;
    pageWidgetViewModel.blocSampleBloc.refreshUi();
  }

  void goToParentPage({required BuildContext context}) {
    context.pushNamed(all_page_page_and_router_sample_list.pageName);
  }

  void pressAddItemBtn() {
    pageWidgetViewModel.itemList.add(ItemListViewModel());
    pageWidgetViewModel.itemListBloc.refreshUi();
  }

  void pressDeleteItem(int i) {
    pageWidgetViewModel.itemList[i].inputTextFieldFocus.dispose();
    pageWidgetViewModel.itemList[i].inputTextFieldController.dispose();

    // 여기서 itemListBloc을 닫은 후 다시 만듭니다.
    pageWidgetViewModel.itemList[i].inputTextFieldBloc.close();
    pageWidgetViewModel.itemList[i].inputTextFieldBloc =
        gc_template_classes.RefreshableBloc();

    pageWidgetViewModel.itemList.removeAt(i);
    pageWidgetViewModel.itemListBloc.refreshUi();
  }

  void itemErrorToggle(int index) {
    var item = pageWidgetViewModel.itemList[index];
    if (item.inputTextFieldErrorMsg == null) {
      item.inputTextFieldErrorMsg = "error";
    } else {
      item.inputTextFieldErrorMsg = null;
    }
    item.inputTextFieldBloc.refreshUi();
  }
}

// (페이지에서 사용할 변수 저장 클래스)
class PageWidgetViewModel {
  PageWidgetViewModel({required BuildContext context});

// !!!페이지에서 사용할 변수를 아래에 선언하기!!!
  // BLoC 객체 샘플 :
  // final gc_template_classes.RefreshableBloc refreshableBloc = gc_template_classes.RefreshableBloc();

  // (pageOutFrameBusiness)
  final gw_page_outer_frame_business.SlWidgetBusiness pageOutFrameBusiness =
      gw_page_outer_frame_business.SlWidgetBusiness();

  // (statefulTestBusiness)
  var statefulTestGk = GlobalKey<gw_stateful_test_state.SfWidgetState>();

  List<ItemListViewModel> itemList = [];
  gc_template_classes.RefreshableBloc itemListBloc =
      gc_template_classes.RefreshableBloc();

  // (sampleBLoC)
  gc_template_classes.RefreshableBloc blocSampleBloc =
      gc_template_classes.RefreshableBloc();
  int blocSampleIntValue = 0;
}

class ItemListViewModel {
  final TextEditingController inputTextFieldController =
      TextEditingController();
  final FocusNode inputTextFieldFocus = FocusNode();
  String? inputTextFieldErrorMsg;
  gc_template_classes.RefreshableBloc inputTextFieldBloc =
      gc_template_classes.RefreshableBloc();
}
