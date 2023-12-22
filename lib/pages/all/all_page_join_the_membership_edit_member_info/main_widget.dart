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
const pageName = "all_page_join_the_membership_edit_member_info";

// !!!페이지 호출/반납 애니메이션!!! - 동적으로 변경이 가능합니다.
Widget Function(BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child)
    pageTransitionsBuilder = (context, animation, secondaryAnimation, child) {
  return FadeTransition(opacity: animation, child: child);
};

// (입력 데이터)
class InputVo {
  // !!!위젯 입력값 선언!!!
  const InputVo({
    required this.memberId,
    required this.password,
    required this.verificationCode,
    required this.verificationUid,
  });

  final String memberId;
  final String password;
  final String verificationCode;
  final int verificationUid;
}

// (결과 데이터)
class OutputVo {
  // !!!위젯 출력값 선언!!!
  const OutputVo({required this.registerComplete});

  // 회원가입이 완료되었는지 여부
  final bool registerComplete;
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
      pageTitle: "회원 가입 : 회원 정보 입력 (2/2)",
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
                      mainBusiness.onProfileImageTap();
                    },
                    child: Stack(
                      children: [
                        gw_sfw_wrapper.SfwRefreshWrapper(
                          key: mainBusiness.profileImageAreaGk,
                          widgetBuild: (context) {
                            mainBusiness.profileImageContext = context;
                            if (mainBusiness.profileImage == null) {
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
                                    image:
                                        MemoryImage(mainBusiness.profileImage!),
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
                    margin: const EdgeInsets.only(top: 20),
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 20,
                            child: SizedBox(
                              width: 200,
                              child: gw_sfw_wrapper.SfwRefreshWrapper(
                                key: mainBusiness.nickNameTextFieldAreaGk,
                                widgetBuild: (context) {
                                  mainBusiness.nickNameTextFieldContext =
                                      context;

                                  return TextFormField(
                                    autofocus: true,
                                    enabled:
                                        mainBusiness.nickNameTextEditEnabled,
                                    keyboardType: TextInputType.text,
                                    controller: mainBusiness
                                        .nickNameTextFieldController,
                                    focusNode:
                                        mainBusiness.nickNameTextFieldFocus,
                                    decoration: InputDecoration(
                                      labelText: '닉네임',
                                      floatingLabelStyle:
                                          const TextStyle(color: Colors.blue),
                                      hintText: "사용할 닉네임을 입력 하세요.",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText: mainBusiness
                                          .nickNameTextFieldErrorMsg,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          mainBusiness
                                              .nickNameTextFieldController
                                              .text = "";
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      // 입력값 변경시 에러 메세지 삭제
                                      if (mainBusiness
                                              .nickNameTextFieldErrorMsg !=
                                          null) {
                                        mainBusiness.nickNameTextFieldErrorMsg =
                                            null;
                                        mainBusiness.nickNameTextFieldAreaGk
                                            .currentState
                                            ?.refreshUi();
                                      }
                                    },
                                    onEditingComplete: () {
                                      mainBusiness
                                          .onNickNameCheckBtnClickAsync();
                                    },
                                  );
                                },
                              ),
                            )),
                        const Expanded(child: SizedBox()),
                        Expanded(
                            flex: 10,
                            child: gw_sfw_wrapper.SfwRefreshWrapper(
                              key: mainBusiness.nickNameCheckBtnAreaGk,
                              widgetBuild: (context) {
                                mainBusiness.nickNameCheckBtnContext = context;

                                return ElevatedButton(
                                  onPressed: () {
                                    // 중복 확인 버튼 동작
                                    mainBusiness.onNickNameCheckBtnClickAsync();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Text(
                                    mainBusiness.nickNameCheckBtn,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "MaruBuri"),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      mainBusiness.onNicknameInputRuleTap();
                    },
                    child: gw_sfw_wrapper.SfwRefreshWrapper(
                      key: mainBusiness.nicknameInputRuleHideAreaGk,
                      widgetBuild: (context) {
                        mainBusiness.nicknameInputRuleHideContext = context;
                        var passwordInputRule =
                            mainBusiness.nicknameInputRuleHide
                                ? const SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "닉네임 입력 규칙",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontFamily: "MaruBuri"),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "닉네임 입력 규칙",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontFamily: "MaruBuri"),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '1. 닉네임은 2 글자 이상으로 입력하세요.\n'
                                          '2. 닉네임에 공백은 허용되지 않습니다.\n'
                                          '3. 아래 특수문자는 사용할 수 없습니다.\n'
                                          '    <, >, (, ), #, ’, /, |\n'
                                          '4. 욕설 등 부적절한 닉네임의 경우 강제로 닉네임이 변경될 수 있습니다.',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey,
                                              fontFamily: "MaruBuri"),
                                        )
                                      ],
                                    ),
                                  );

                        return Container(
                          width: 300,
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 10),
                          decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  // POINT
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                right: BorderSide(
                                  // POINT
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  // POINT
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                top: BorderSide(
                                  // POINT
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: passwordInputRule,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    // 회원가입 버튼 동작
                    mainBusiness.onRegisterBtnClick();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    '회원 가입',
                    style:
                        TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
