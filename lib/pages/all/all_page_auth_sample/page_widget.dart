// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/a_must_delete/todo_gc_delete.dart'
    as gc_template_classes;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_auth_sample";

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
    business.onCheckPageInputVo(goRouterState: widget.goRouterState);
    business.refreshUi = refreshUi;
    business.context = context;
    business.initState();
  }

  @override
  void dispose() {
    business.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    business.refreshUi = refreshUi;
    business.context = context;
    return PopScope(
      canPop: business.canPop,
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
        child: WidgetUi.viewWidgetBuild(context: context, business: business),
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
}

class WidgetUi {
  // [뷰 위젯]
  static Widget viewWidgetBuild(
      {required BuildContext context,
      required page_widget_business.PageWidgetBusiness business}) {
    // !!!뷰 위젯 반환 콜백 작성 하기!!!

    return gw_slw_page_outer_frame.SlwPageOuterFrame(
      business: business.pageOutFrameBusiness,
      pageTitle: "계정 샘플",
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocProvider(
              create: (context) => business.memberInfoBloc,
              child: BlocBuilder<gc_template_classes.RefreshableBloc, bool>(
                builder: (c, s) {
                  return Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 10, left: 10, right: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '멤버 정보',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    '    - memberUid : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "MaruBuri"),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: SelectableText(
                                    business.memberInfoViewModel == null
                                        ? "null"
                                        : business
                                            .memberInfoViewModel!.memberUid,
                                    style:
                                        const TextStyle(fontFamily: "MaruBuri"),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    '    - tokenType : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "MaruBuri"),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: SelectableText(
                                    business.memberInfoViewModel == null
                                        ? "null"
                                        : business
                                            .memberInfoViewModel!.tokenType,
                                    style:
                                        const TextStyle(fontFamily: "MaruBuri"),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    '    - accessToken : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "MaruBuri"),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: SelectableText(
                                    business.memberInfoViewModel == null
                                        ? "null"
                                        : business
                                            .memberInfoViewModel!.accessToken,
                                    style:
                                        const TextStyle(fontFamily: "MaruBuri"),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    '    - accessTokenExpireWhen : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "MaruBuri"),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: SelectableText(
                                    business.memberInfoViewModel == null
                                        ? "null"
                                        : business.memberInfoViewModel!
                                            .accessTokenExpireWhen,
                                    style:
                                        const TextStyle(fontFamily: "MaruBuri"),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    '    - refreshToken : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "MaruBuri"),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: SelectableText(
                                    business.memberInfoViewModel == null
                                        ? "null"
                                        : business
                                            .memberInfoViewModel!.refreshToken,
                                    style:
                                        const TextStyle(fontFamily: "MaruBuri"),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    '    - refreshTokenExpireWhen : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "MaruBuri"),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: SelectableText(
                                    business.memberInfoViewModel == null
                                        ? "null"
                                        : business.memberInfoViewModel!
                                            .refreshTokenExpireWhen,
                                    style:
                                        const TextStyle(fontFamily: "MaruBuri"),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 40.0),
                          const Text(
                            '계정 관련 기능 샘플 리스트',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                        ]),
                  );
                },
              ),
            ),
            BlocProvider(
              create: (context) => business.itemListBloc,
              child: BlocBuilder<gc_template_classes.RefreshableBloc, bool>(
                builder: (c, s) {
                  return ListView.builder(
                    shrinkWrap: true, // 리스트뷰 크기 고정
                    primary: false, // 리스트뷰 내부는 스크롤 금지
                    itemCount: business.itemList.length,
                    itemBuilder: (context, index) {
                      var sampleItem = business.itemList[index];

                      return Column(
                        children: [
                          BlocProvider(
                            create: (context) => sampleItem.isHoveringBloc,
                            child: BlocBuilder<
                                gc_template_classes.RefreshableBloc, bool>(
                              builder: (c, s) {
                                return MouseRegion(
                                  // 커서 변경 및 호버링 상태 변경
                                  cursor: SystemMouseCursors.click,
                                  onEnter: (details) {
                                    sampleItem.isHovering = true;
                                    sampleItem.isHoveringBloc.refreshUi();
                                  },
                                  onExit: (details) {
                                    sampleItem.isHovering = false;
                                    sampleItem.isHoveringBloc.refreshUi();
                                  },
                                  child: GestureDetector(
                                    // 클릭시 제스쳐 콜백
                                    onTap: () {
                                      sampleItem.onItemClicked();
                                    },
                                    child: Container(
                                      color: sampleItem.isHovering
                                          ? Colors.blue.withOpacity(0.2)
                                          : Colors.white,
                                      child: ListTile(
                                        mouseCursor: SystemMouseCursors.click,
                                        title: Text(
                                          sampleItem.itemTitle,
                                          style: const TextStyle(
                                              fontFamily: "MaruBuri"),
                                        ),
                                        subtitle: Text(
                                          sampleItem.itemDescription,
                                          style: const TextStyle(
                                              fontFamily: "MaruBuri"),
                                        ),
                                        trailing:
                                            const Icon(Icons.chevron_right),
                                      ),
                                    ),
                                  ),
                                );
                              },
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

// (BLoC 갱신 구역 설정 방법)
// 위젯을 작성 하다가 특정 부분은 상태에 따라 UI 가 변하도록 하고 싶은 부분이 있습니다.
// 이 경우 Stateful 위젯을 생성 해서 사용 하면 되지만,
// 간단히 갱신 영역을 지정 하여 해당 구역만 갱신 하도록 하기 위해선 BLoC 갱신 구역을 설정 하여 사용 하면 됩니다.
// Business 클래스 안에 BLoC 갱신 구역 조작 객체로
// gc_template_classes.RefreshableBloc refreshableBloc = gc_template_classes.RefreshableBloc();
// 위와 같이 선언 및 생성 하고,
// Widget 에서는, 갱신 하려는 구역을
// BlocProvider(
//         create: (context) => business.refreshableBloc,
//         child: BlocBuilder<gc_template_classes.RefreshableBloc, bool>(
//         builder: (c,s){
//             return Text(business.sampleInt.toString());
//         },
//     ),
// )
// 위와 같이 감싸 줍니다.
// 만약 위와 같은 Text 위젯에서 숫자 표시를 갱신 하려면,
// business.sampleInt += 1;
// business.refreshableBloc.refreshUi();
// 이처럼 Text 위젯에서 사용 하는 상태 변수의 값을 변경 하고,
// 갱신 구역 객체의 refreshUi() 함수를 실행 시키면,
// builder 가 다시 실행 되며, 그 안의 위젯이 재조립 되어 화면을 갱신 합니다.
