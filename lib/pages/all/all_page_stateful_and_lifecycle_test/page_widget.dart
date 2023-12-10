// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

// (inner Folder)
import 'page_widget_business.dart' as page_widget_business;

// (all)
import '../../../global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;
import '../../../global_widgets/gw_sfw_test.dart' as gw_sfw_test;

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_stateful_and_lifecycle_test";

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
    business.refreshUi = refreshUi;
    business.onCheckPageInputVo(
        context: context, goRouterState: widget.goRouterState);
    business.pageWidgetViewModel =
        page_widget_business.PageWidgetViewModel(context: context);
    business.initState(context: context);
  }

  @override
  void dispose() {
    business.dispose(context: context);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    business.refreshUi = refreshUi;
    return PopScope(
      canPop: business.canPop,
      child: FocusDetector(
        // (페이지 위젯의 FocusDetector 콜백들)
        onFocusGained: () async {
          await business.onFocusGained(context: context);
        },
        onFocusLost: () async {
          await business.onFocusLost(context: context);
        },
        onVisibilityGained: () async {
          await business.onVisibilityGained(context: context);
        },
        onVisibilityLost: () async {
          await business.onVisibilityLost(context: context);
        },
        onForegroundGained: () async {
          await business.onForegroundGained(context: context);
        },
        onForegroundLost: () async {
          await business.onForegroundLost(context: context);
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
      business: business.pageWidgetViewModel.pageOutFrameBusiness,
      pageTitle: "Stateful 및 라이프사이클 테스트",
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                "BLoC 상태 변수",
                style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
              ),
              const SizedBox(
                height: 5,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    business.onBlocSampleClicked();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: BlocProvider(
                      create: (context) =>
                          business.pageWidgetViewModel.blocSampleBloc,
                      child: BlocBuilder<gc_template_classes.RefreshableBloc,
                          bool>(
                        builder: (c, s) {
                          return Text(
                              "${business.pageWidgetViewModel.blocSampleIntValue}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: "MaruBuri"));
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Stateful Widget 상태 변수",
                style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
              ),
              const SizedBox(
                height: 5,
              ),
              gw_sfw_test.SfwTest(
                globalKey: business.pageWidgetViewModel.statefulTestGk,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "BLoC 리스트 상태 변수",
                style: TextStyle(color: Colors.black, fontFamily: "MaruBuri"),
              ),
              const SizedBox(
                height: 5,
              ),
              // 이미지 리스트 선택
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                height: 150,
                //decoration: const BoxDecoration(
                //  color: Color.fromARGB(255, 249, 249, 249),
                //),
                child: Center(
                  child: BlocProvider(
                    create: (context) =>
                        business.pageWidgetViewModel.itemListBloc,
                    child:
                        BlocBuilder<gc_template_classes.RefreshableBloc, bool>(
                      builder: (c, s) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              1 + business.pageWidgetViewModel.itemList.length,
                          itemBuilder: (context, index) {
                            // 첫번째 인덱스는 무조건 추가 버튼
                            if (0 == index) {
                              return Stack(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    alignment: Alignment.center,
                                    // 중앙에 위치하도록 설정
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            width: 1.0, color: Colors.black),
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.black),
                                        left: BorderSide(
                                            width: 1.0, color: Colors.black),
                                        right: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            business.pressAddItemBtn();
                                          },
                                          iconSize: 35,
                                          color: const Color.fromARGB(
                                              255, 158, 158, 158),
                                          icon: const Icon(Icons.photo_library),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              page_widget_business.ItemListViewModel item =
                                  business
                                      .pageWidgetViewModel.itemList[index - 1];

                              return Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Stack(
                                  children: [
                                    // todo 아래에 에러 토글 버튼과 포커스 버튼
                                    Column(
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: BlocProvider(
                                            create: (context) =>
                                                item.inputTextFieldBloc,
                                            child: BlocBuilder<
                                                gc_template_classes
                                                .RefreshableBloc,
                                                bool>(
                                              builder: (c, s) {
                                                return Container(
                                                  color: Colors.white,
                                                  child: TextFormField(
                                                    controller: item
                                                        .inputTextFieldController,
                                                    focusNode: item
                                                        .inputTextFieldFocus,
                                                    decoration: InputDecoration(
                                                      errorText: item
                                                          .inputTextFieldErrorMsg,
                                                      floatingLabelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.blue),
                                                      border:
                                                          const OutlineInputBorder(),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10.0,
                                                              horizontal: 10.0),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                      ),
                                                      suffixIcon: IconButton(
                                                        onPressed: () {
                                                          item.inputTextFieldController
                                                              .text = "";
                                                        },
                                                        icon: const Icon(
                                                            Icons.clear),
                                                      ),
                                                    ),
                                                    onChanged: (value) {
                                                      // 입력값 변경시 에러 메세지 삭제
                                                      if (item.inputTextFieldErrorMsg !=
                                                          null) {
                                                        item.inputTextFieldErrorMsg =
                                                            null;
                                                        item.inputTextFieldBloc
                                                            .refreshUi();
                                                      }
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  business.itemErrorToggle(
                                                      index - 1);
                                                },
                                                child: Text("E")),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: Text("F"))
                                          ],
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      top: -10,
                                      right: -10,
                                      child: IconButton(
                                        onPressed: () {
                                          // todo
                                          business.pressDeleteItem(index - 1);
                                        },
                                        iconSize: 15,
                                        color: Colors.white,
                                        icon: const Icon(
                                          Icons.cancel,
                                          color: Colors.grey,
                                          size: 15.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    business.goToParentPage(context: context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "상위 페이지로 이동",
                    style:
                        TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
                  )),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// (BLoC 위젯 예시)
// BlocProvider(
//         create: (context) => business.refreshableBloc,
//         child: BlocBuilder<gc_template_classes.RefreshableBloc, bool>(
//         builder: (c,s){
//             return Text(business.sampleInt.toString());
//         },
//     ),
// )
