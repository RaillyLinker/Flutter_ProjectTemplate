// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';
import 'dart:typed_data';

// (inner_folder)
import 'main_business.dart' as main_business;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/global_widgets/gw_sfw_wrapper.dart'
    as gw_sfw_wrapper;

// [위젯 뷰]

//------------------------------------------------------------------------------
// !!!페이지 진입 라우트 Name 정의!!! - 폴더명과 동일하게 작성하세요.
const pageName = "all_page_image_selector_sample";

// !!!페이지 호출/반납 애니메이션!!! - 동적으로 변경이 가능합니다.
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
class MainWidget extends StatefulWidget {
  const MainWidget({super.key, required this.goRouterState});

  final GoRouterState goRouterState;

  @override
  MainWidgetState createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> with WidgetsBindingObserver {
  // [콜백 함수]
  @override
  Widget build(BuildContext context) {
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    if (mainBusiness.pageInitFirst) {
      mainBusiness.pageInitFirst = false;
      mainBusiness.onCreate();
    }
    return PopScope(
      canPop: mainBusiness.canPop,
      child: FocusDetector(
        onFocusGained: () async {
          await mainBusiness.onFocusGainedAsync();
        },
        onFocusLost: () async {
          await mainBusiness.onFocusLostAsync();
        },
        onVisibilityGained: () async {
          await mainBusiness.onVisibilityGainedAsync();
        },
        onVisibilityLost: () async {
          await mainBusiness.onVisibilityLostAsync();
        },
        onForegroundGained: () async {
          await mainBusiness.onForegroundGainedAsync();
        },
        onForegroundLost: () async {
          await mainBusiness.onForegroundLostAsync();
        },
        child: getScreenWidget(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    final InputVo? inputVo =
        mainBusiness.onCheckPageInputVo(goRouterState: widget.goRouterState);
    if (inputVo == null) {
      mainBusiness.inputError = true;
    } else {
      mainBusiness.inputVo = inputVo;
    }
    mainBusiness.initState();
  }

  @override
  void dispose() {
    mainBusiness.mainContext = context;
    mainBusiness.refreshUi = refreshUi;
    mainBusiness.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // [public 변수]
  // (mainBusiness) - 데이터 변수 및 함수 저장 역할
  final main_business.MainBusiness mainBusiness = main_business.MainBusiness();

  //----------------------------------------------------------------------------
  // !!!위젯 관련 함수는 이 곳에서 저장 하여 사용 하세요.!!!
  // [public 함수]
  // (MainWidget Refresh 함수)
  void refreshUi() {
    setState(() {});
  }

  // [private 함수]

  //----------------------------------------------------------------------------
  // [화면 작성]
  Widget getScreenWidget() {
    // !!!화면 위젯 작성 하기!!!

    if (mainBusiness.inputError == true) {
      // 입력값이 미충족 되었을 때의 화면
      return gw_slw_page_outer_frame.ErrorPageWidget(
        business: gw_slw_page_outer_frame.ErrorPageWidgetBusiness(),
        errorMsg: "잘못된 접근입니다.",
      );
    }

    return gw_slw_page_outer_frame.SlwPageOuterFrame(
      business: mainBusiness.pageOutFrameBusiness,
      pageTitle: "이미지 선택 샘플",
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    mainBusiness.onProfileImageTap();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: Stack(
                      children: [
                        gw_sfw_wrapper.SfwRefreshWrapper(
                          key: mainBusiness.profileImageAreaGk,
                          widgetBuild: (profileImageAreaContext) {
                            mainBusiness.profileImageAreaContext =
                                profileImageAreaContext;

                            if (mainBusiness.selectedImage == null) {
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
                                    image: MemoryImage(
                                        mainBusiness.selectedImage!),
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
                                    errorBuilder: (context, error, stackTrace) {
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
                  child: gw_sfw_wrapper.SfwRefreshWrapper(
                    key: mainBusiness.imageListAreaGk,
                    widgetBuild: (imageListAreaContext) {
                      mainBusiness.imageListAreaContext = imageListAreaContext;

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mainBusiness.imageFiles.length + 1,
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
                                      "${mainBusiness.imageFiles.length}/${mainBusiness.imageFileListMaxCount}",
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          mainBusiness.pressAddPictureBtn();
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
                            imageFile = mainBusiness.imageFiles[index - 1];

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
                                        mainBusiness
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
