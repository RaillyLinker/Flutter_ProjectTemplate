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
          '회원 가입 : 회원 정보 입력 (2/2)',
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
                // todo
                Stack(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: Colors.blue,
                      size: 100.0,
                    ),
                    Positioned(
                      width: 30,
                      height: 30,
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
                          Icons.account_box_outlined,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ],
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
                              child: BlocBuilder<
                                  page_business.BlocNicknameEditText, bool>(
                                builder: (c, s) {
                                  return TextFormField(
                                    onChanged: (text) {
                                      pageBusiness.nickNameTextEditOnChanged();
                                    },
                                    enabled: pageBusiness
                                        .pageViewModel.nickNameTextEditEnabled,
                                    focusNode: pageBusiness
                                        .pageViewModel.nickNameTextEditFocus,
                                    controller: pageBusiness.pageViewModel
                                        .nickNameTextEditController,
                                    decoration: InputDecoration(
                                      errorText: pageBusiness.pageViewModel
                                          .nickNameTextEditErrorMsg,
                                      labelText: '닉네임',
                                    ),
                                  );
                                },
                              ),
                            )),
                        const Expanded(child: SizedBox()),
                        Expanded(
                            flex: 10,
                            child: BlocBuilder<
                                page_business.BlocNicknameCheckBtn,
                                bool>(builder: (c, s) {
                              return ElevatedButton(
                                onPressed: () {
                                  // 중복 확인 버튼 동작
                                  pageBusiness.onNickNameCheckBtnClickAsync();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text(
                                  pageBusiness.pageViewModel.nickNameCheckBtn,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "MaruBuri"),
                                ),
                              );
                            })),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pageBusiness.onNicknameInputRuleTap();
                  },
                  child: BlocBuilder<page_business.BlocNicknameInputRule, bool>(
                      builder: (c, s) {
                    var passwordInputRule =
                        pageBusiness.pageViewModel.nicknameInputRuleHide
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
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 10),
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: passwordInputRule,
                    );
                  }),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    // 회원가입 버튼 동작
                    pageBusiness.onRegisterBtnClick();
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
