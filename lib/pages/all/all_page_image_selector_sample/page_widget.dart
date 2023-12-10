// (external)
import 'dart:typed_data';
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

// [위젯 뷰]
// 위젯의 화면 작성은 여기서 합니다.

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!!
// 폴더명과 동일하게 작성하세요.
const pageName = "all_page_image_selector_sample";

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
      pageTitle: "이미지 선택 샘플",
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    business.onProfileImageTap();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: Stack(
                      children: [
                        BlocProvider(
                          create: (context) => business.blocProfileImage,
                          child: BlocBuilder<
                              gc_template_classes.RefreshableBloc, bool>(
                            builder: (c, s) {
                              if (business.selectedImage == null) {
                                return ClipOval(
                                    child: Container(
                                  color: Colors.blue,
                                  width: 150,
                                  height: 150,
                                  child: const Icon(
                                    Icons.photo_outlined,
                                    color: Colors.white,
                                    size: 120,
                                  ),
                                ));
                              } else {
                                return ClipOval(
                                  child: SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: Image(
                                      image:
                                          MemoryImage(business.selectedImage!),
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        // 로딩 중일 때 플레이스 홀더를 보여줍니다.
                                        if (loadingProgress == null) {
                                          return child; // 로딩이 끝났을 경우
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        // 에러 발생 시 설정한 에러 위젯을 반환합니다.
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Positioned(
                          width: 40,
                          height: 40,
                          bottom: 10,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ]),
                            child: const Icon(
                              Icons.photo_library,
                              color: Colors.grey,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 이미지 리스트 선택
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                ),
                height: 120,
                //decoration: const BoxDecoration(
                //  color: Color.fromARGB(255, 249, 249, 249),
                //),
                child: Center(
                  child: BlocProvider(
                    create: (context) => business.blocImageList,
                    child:
                        BlocBuilder<gc_template_classes.RefreshableBloc, bool>(
                      builder: (c, s) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: business.imageFiles.length + 1,
                          itemBuilder: (context, index) {
                            // 첫번째 인덱스는 무조건 추가 버튼
                            if (0 == index) {
                              return Stack(
                                children: [
                                  Positioned(
                                      top: 50,
                                      width: 76,
                                      child: Center(
                                          child: Text(
                                        "${business.imageFiles.length}/${business.imageFileListMaxCount}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 158, 158, 158)),
                                      ))),
                                  Container(
                                    width: 76,
                                    height: 76,
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
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            business.pressAddPictureBtn();
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
                              Uint8List imageFile;
                              imageFile = business.imageFiles[index - 1];

                              return Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 76,
                                      height: 76,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image(
                                        image: MemoryImage(imageFile),
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          // 로딩 중일 때 플레이스 홀더를 보여줍니다.
                                          if (loadingProgress == null) {
                                            return child; // 로딩이 끝났을 경우
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          // 에러 발생 시 설정한 에러 위젯을 반환합니다.
                                          return const Center(
                                            child: Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: -10,
                                      right: -10,
                                      child: IconButton(
                                        onPressed: () {
                                          business
                                              .pressDeletePicture(index - 1);
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
              )
            ],
          ),
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
// final gc_template_classes.RefreshableBloc refreshableBloc = gc_template_classes.RefreshableBloc();
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
