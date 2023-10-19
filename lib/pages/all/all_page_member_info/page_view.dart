// (external)
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// (page)
import 'page_business.dart' as page_business;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!
class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    // pageBusiness 객체
    page_business.PageBusiness pageBusiness =
        BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
            .state
            .pageBusiness;

    // Mobile 앱 status bar 색상 변경
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: const Text(
          '회원 정보',
          style: TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    // todo all_page_join_the_membership_edit_member_info 참고
                  },
                  child: Stack(
                    children: [
                      BlocBuilder<page_business.BlocProfileImage, bool>(
                          builder: (c, s) {
                        if (pageBusiness.pageViewModel.frontProfileIdx ==
                            null) {
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
                            child: Image(
                              image: NetworkImage(pageBusiness
                                  .pageViewModel
                                  .myProfileList[pageBusiness
                                      .pageViewModel.frontProfileIdx!]
                                  .imageFullUrl),
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                // 로딩 중일 때 플레이스 홀더를 보여줍니다.
                                if (loadingProgress == null) {
                                  return child; // 로딩이 끝났을 경우
                                }
                                return const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                // 에러 발생 시 설정한 에러 위젯을 반환합니다.
                                return const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: Icon(Icons.error),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }),
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
                            child:
                                BlocBuilder<page_business.BlocNickname, bool>(
                              builder: (c, s) {
                                return Container(
                                  color: Colors.orange,
                                  child: Text(
                                    pageBusiness.pageViewModel.nickName == null
                                        ? ""
                                        : pageBusiness.pageViewModel.nickName!,
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
                              child: const Text(
                                "수정하기",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontFamily: "MaruBuri"),
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
                            child: BlocBuilder<page_business.BlocEmail, bool>(
                              builder: (c, s) {
                                return Container(
                                  color: Colors.orange,
                                  child: Text(
                                    pageBusiness.pageViewModel.myEmailList ==
                                            null
                                        ? ""
                                        : pageBusiness.pageViewModel.myEmailList
                                            .toString(),
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
                                "전화번호",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"),
                              ),
                            )),
                        Expanded(
                            flex: 20,
                            child: BlocBuilder<page_business.BlocPhoneNumber,
                                bool>(
                              builder: (c, s) {
                                return Container(
                                  color: Colors.orange,
                                  child: Text(
                                    pageBusiness.pageViewModel
                                                .myPhoneNumberList ==
                                            null
                                        ? ""
                                        : pageBusiness
                                            .pageViewModel.myPhoneNumberList
                                            .toString(),
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
                                "간편 로그인",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"),
                              ),
                            )),
                        Expanded(
                            flex: 20,
                            child: BlocBuilder<page_business.BlocOAuth2, bool>(
                              builder: (c, s) {
                                return Container(
                                  color: Colors.orange,
                                  child: Text(
                                    pageBusiness.pageViewModel.myOAuth2List ==
                                            null
                                        ? ""
                                        : pageBusiness
                                            .pageViewModel.myOAuth2List
                                            .toString(),
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
                                "회원 권한",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "MaruBuri"),
                              ),
                            )),
                        Expanded(
                            flex: 20,
                            child:
                                BlocBuilder<page_business.BlocPermission, bool>(
                              builder: (c, s) {
                                return Container(
                                  color: Colors.orange,
                                  child: Text(
                                    pageBusiness.pageViewModel.roleList == null
                                        ? ""
                                        : pageBusiness.pageViewModel.roleList
                                            .toString(),
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
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    pageBusiness.tapWithdrawalBtn();
                  },
                  child: const Text(
                    "회원 탈퇴하기",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontFamily: "MaruBuri"),
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
