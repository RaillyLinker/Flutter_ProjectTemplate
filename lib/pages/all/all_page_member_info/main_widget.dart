// (external)
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:go_router/go_router.dart';

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
const pageName = "all_page_member_info";

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
      pageTitle: "회원 정보",
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      // todo all_page_join_the_membership_edit_member_info 참고
                    },
                    child: Stack(
                      children: [
                        gw_sfw_wrapper.SfwRefreshWrapper(
                          key: mainBusiness.myProfileAreaGk,
                          widgetBuild: (contest) {
                            mainBusiness.myProfileAreaContext = context;

                            if (mainBusiness.frontProfileIdx == null) {
                              return ClipOval(
                                  child: Container(
                                color: Colors.blue,
                                width: 100,
                                height: 100,
                                child: const Icon(
                                  Icons.photo_outlined,
                                  color: Colors.white,
                                  size: 70,
                                ),
                              ));
                            } else {
                              return ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image(
                                    image: NetworkImage(mainBusiness
                                        .myProfileList[
                                            mainBusiness.frontProfileIdx!]
                                        .imageFullUrl),
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
                          width: 30,
                          height: 30,
                          bottom: 0,
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
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 10,
                            child: Container(
                              color: Colors.red,
                              width: 200,
                              child: const Text(
                                "닉네임",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"),
                              ),
                            )),
                        Expanded(
                            flex: 20,
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.nicknameAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.nicknameAreaContext = context;

                                return Container(
                                  color: Colors.orange,
                                  child: Text(
                                    mainBusiness.nickName == null
                                        ? ""
                                        : mainBusiness.nickName!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontFamily: "MaruBuri"),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 10,
                            child: Container(
                              color: Colors.red,
                              width: 200,
                              child: const Text(
                                "비밀번호",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"),
                              ),
                            )),
                        Expanded(
                            flex: 20,
                            child: Container(
                              color: Colors.orange,
                              child: GestureDetector(
                                onTap: () {
                                  mainBusiness.goToChangePasswordPage();
                                },
                                child: const MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Text(
                                    "수정하기",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontFamily: "MaruBuri"),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 10,
                            child: Container(
                              color: Colors.red,
                              width: 200,
                              child: const Text(
                                "이메일",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"),
                              ),
                            )),
                        Expanded(
                          flex: 20,
                          child: gw_sfw_wrapper.SfwRefreshWrapper(
                            key: mainBusiness.emailAreaGk,
                            widgetBuild: (context) {
                              mainBusiness.emailAreaContext = context;

                              return Container(
                                color: Colors.orange,
                                child: Text(
                                  mainBusiness.myEmailList == null
                                      ? ""
                                      : mainBusiness.myEmailList.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontFamily: "MaruBuri"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 10,
                            child: Container(
                              color: Colors.red,
                              width: 200,
                              child: const Text(
                                "전화번호",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"),
                              ),
                            )),
                        Expanded(
                          flex: 20,
                          child: gw_sfw_wrapper.SfwRefreshWrapper(
                            key: mainBusiness.myPhoneNumberAreaGk,
                            widgetBuild: (context) {
                              mainBusiness.myPhoneNumberAreaContext = context;

                              return Container(
                                color: Colors.orange,
                                child: Text(
                                  mainBusiness.myPhoneNumberList == null
                                      ? ""
                                      : mainBusiness.myPhoneNumberList
                                          .toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontFamily: "MaruBuri"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 10,
                            child: Container(
                              color: Colors.red,
                              width: 200,
                              child: const Text(
                                "간편 로그인",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"),
                              ),
                            )),
                        Expanded(
                          flex: 20,
                          child: gw_sfw_wrapper.SfwRefreshWrapper(
                            key: mainBusiness.myOAuth2AreaGk,
                            widgetBuild: (context) {
                              mainBusiness.myOAuth2AreaContext = context;

                              return Container(
                                color: Colors.orange,
                                child: Text(
                                  mainBusiness.myOAuth2List == null
                                      ? ""
                                      : mainBusiness.myOAuth2List.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontFamily: "MaruBuri"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 10,
                            child: Container(
                              color: Colors.red,
                              width: 200,
                              child: const Text(
                                "회원 권한",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"),
                              ),
                            )),
                        Expanded(
                          flex: 20,
                          child: gw_sfw_wrapper.SfwRefreshWrapper(
                            key: mainBusiness.roleListAreaGk,
                            widgetBuild: (context) {
                              mainBusiness.roleListAreaContext = context;

                              return Container(
                                color: Colors.orange,
                                child: Text(
                                  mainBusiness.roleList == null
                                      ? ""
                                      : mainBusiness.roleList.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontFamily: "MaruBuri"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      mainBusiness.tapWithdrawalBtn();
                    },
                    child: const Text(
                      "회원 탈퇴하기",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.red, fontFamily: "MaruBuri"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
