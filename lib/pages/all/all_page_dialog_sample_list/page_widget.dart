// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/a_must_delete/todo_do_delete.dart'
    as gw_do_delete;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_dialog_sample_list";

// !!!페이지 호출/반납 애니메이션!!!
// 동적으로 변경이 가능합니다.
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
class PageWidget extends StatefulWidget {
  const PageWidget({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  PageWidgetState createState() => PageWidgetState();
}

class PageWidgetState extends State<PageWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    business = page_widget_business.PageWidgetBusiness();
    business.viewModel = page_widget_business.PageWidgetViewModel(
        context: context,
        inputVo: business.onCheckPageInputVo(
            context: context, goRouterState: widget.goRouterState));
    business.refreshUi = refreshUi;
    business.initState();
  }

  @override
  void dispose() {
    business.viewModel.context = context;
    business.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    business.viewModel.context = context;
    business.refreshUi = refreshUi;
    return PopScope(
      canPop: business.viewModel.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          await business.onFocusGained();
        },
        onFocusLost: () async {
          await business.onFocusLost();
        },
        onVisibilityGained: () async {
          await business.onVisibilityGained();
        },
        onVisibilityLost: () async {
          await business.onVisibilityLost();
        },
        onForegroundGained: () async {
          await business.onForegroundGained();
        },
        onForegroundLost: () async {
          await business.onForegroundLost();
        },
        child: viewWidgetBuild(context: context, business: business),
      ),
    );
  }

  // [public 변수]
  late page_widget_business.PageWidgetBusiness business;

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }

  // (현 상황에 맞는 아이템 리스트 반환)
  List<Widget> getNewItemWidgetList() {
    List<Widget> itemWidgetList = [];
    itemWidgetList.add(
      Column(
        children: [
          HoveringListTile(
              globalKey: GlobalKey(),
              itemTitle: "다이얼로그 템플릿",
              itemDescription: "템플릿 다이얼로그를 호출합니다.",
              onItemClicked: () {
                business.onDialogTemplateItemClicked();
              }),
          const Divider(
            color: Colors.grey,
            height: 0.1,
          ),
        ],
      ),
    );

    itemWidgetList.add(
      Column(
        children: [
          HoveringListTile(
              globalKey: GlobalKey(),
              itemTitle: "확인 다이얼로그",
              itemDescription: "버튼이 하나인 확인 다이얼로그를 호출합니다.",
              onItemClicked: () {
                business.onInfoDialogItemClicked();
              }),
          const Divider(
            color: Colors.grey,
            height: 0.1,
          ),
        ],
      ),
    );

    itemWidgetList.add(
      Column(
        children: [
          HoveringListTile(
              globalKey: GlobalKey(),
              itemTitle: "예/아니오 다이얼로그",
              itemDescription: "버튼이 두개인 다이얼로그를 호출합니다.",
              onItemClicked: () {
                business.onYesOrNoDialogItemClicked();
              }),
          const Divider(
            color: Colors.grey,
            height: 0.1,
          ),
        ],
      ),
    );

    itemWidgetList.add(
      Column(
        children: [
          HoveringListTile(
              globalKey: GlobalKey(),
              itemTitle: "로딩 스피너 다이얼로그",
              itemDescription: "로딩 스피너 다이얼로그를 호출하고 2초 후 종료합니다.",
              onItemClicked: () {
                business.onLoadingSpinnerDialogItemClicked();
              }),
          const Divider(
            color: Colors.grey,
            height: 0.1,
          ),
        ],
      ),
    );

    itemWidgetList.add(
      Column(
        children: [
          HoveringListTile(
              globalKey: GlobalKey(),
              itemTitle: "아래에 붙은 다이얼로그",
              itemDescription: "아래에서 올라오는 다이얼로그를 호출합니다.",
              onItemClicked: () {
                business.onBottomSheetModalDialogItemClicked();
              }),
          const Divider(
            color: Colors.grey,
            height: 0.1,
          ),
        ],
      ),
    );

    itemWidgetList.add(
      Column(
        children: [
          HoveringListTile(
              globalKey: GlobalKey(),
              itemTitle: "다이얼로그 속 다이얼로그",
              itemDescription: "다이얼로그에서 다이얼로그를 호출합니다.",
              onItemClicked: () {
                business.onDialogInDialogItemClicked();
              }),
          const Divider(
            color: Colors.grey,
            height: 0.1,
          ),
        ],
      ),
    );

    itemWidgetList.add(
      Column(
        children: [
          HoveringListTile(
              globalKey: GlobalKey(),
              itemTitle: "다이얼로그 외부 색 설정",
              itemDescription: "다이얼로그 영역 바깥의 색상을 지정합니다.",
              onItemClicked: () {
                business.onDialogBackgroundColorItemClicked();
              }),
          const Divider(
            color: Colors.grey,
            height: 0.1,
          ),
        ],
      ),
    );

    itemWidgetList.add(
      Column(
        children: [
          HoveringListTile(
              globalKey: GlobalKey(),
              itemTitle: "컨텍스트 메뉴 샘플",
              itemDescription: "다이얼로그에서 컨텍스트 메뉴를 사용하는 샘플",
              onItemClicked: () {
                business.onContextMenuDialogItemClicked();
              }),
          const Divider(
            color: Colors.grey,
            height: 0.1,
          ),
        ],
      ),
    );

    itemWidgetList.add(
      Column(
        children: [
          HoveringListTile(
              globalKey: GlobalKey(),
              itemTitle: "다이얼로그 Stateful 상태 및 생명주기 테스트",
              itemDescription: "다이얼로그 Stateful 상태 및 생명주기를 테스트 합니다.",
              onItemClicked: () {
                business.onDialogStatefulAndLifecycleTestItemClicked();
              }),
          const Divider(
            color: Colors.grey,
            height: 0.1,
          ),
        ],
      ),
    );

    return itemWidgetList;
  }

  // [private 함수]

  // [뷰 위젯 작성 공간]
  Widget viewWidgetBuild(
      {required BuildContext context,
      required page_widget_business.PageWidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return gw_slw_page_outer_frame.SlwPageOuterFrame(
      business: business.viewModel.pageOutFrameBusiness,
      pageTitle: "다이얼로그 샘플 리스트",
      child: gw_do_delete.SfwListViewBuilder(
        globalKey: business.viewModel.sfwListViewBuilderStateGk,
        itemWidgetList: getNewItemWidgetList(),
      ),
    );
  }
}

// (호버링 리스트 타일)
class HoveringListTile extends StatefulWidget {
  const HoveringListTile(
      {required this.globalKey,
      required this.itemTitle,
      required this.itemDescription,
      required this.onItemClicked})
      : super(key: globalKey);

  // [콜백 함수]
  @override
  HoveringListTileState createState() => HoveringListTileState();

  // [public 변수]
  final GlobalKey<HoveringListTileState> globalKey;

  // !!!외부 입력 변수 선언 하기!!!
  // 샘플 타이틀
  final String itemTitle;

  // 샘플 설명
  final String itemDescription;

  final void Function() onItemClicked;

  // [화면 작성]
  Widget widgetUiBuild(
      {required BuildContext context,
      required HoveringListTileState currentState}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return MouseRegion(
      // 커서 변경 및 호버링 상태 변경
      cursor: SystemMouseCursors.click,
      onEnter: (details) {
        currentState.isHovering = true;
        currentState.refreshUi();
      },
      onExit: (details) {
        currentState.isHovering = false;
        currentState.refreshUi();
      },
      child: GestureDetector(
        // 클릭시 제스쳐 콜백
        onTap: () {
          onItemClicked();
        },
        child: Container(
          color: currentState.isHovering
              ? Colors.blue.withOpacity(0.2)
              : Colors.white,
          child: ListTile(
            mouseCursor: SystemMouseCursors.click,
            title: Text(
              itemTitle,
              style: const TextStyle(fontFamily: "MaruBuri"),
            ),
            subtitle: Text(
              itemDescription,
              style: const TextStyle(fontFamily: "MaruBuri"),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}

class HoveringListTileState extends State<HoveringListTile> {
  HoveringListTileState();

  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    return widget.widgetUiBuild(context: context, currentState: this);
  }

  @override
  void initState() {
    super.initState();
    // !!!initState 작성!!!
  }

  @override
  void dispose() {
    // !!!dispose 작성!!!
    super.dispose();
  }

  // [public 변수]
  bool isHovering = false;

  // [private 변수]

  // [public 함수]
  // (Stateful Widget 화면 갱신)
  void refreshUi() {
    setState(() {});
  }
}
