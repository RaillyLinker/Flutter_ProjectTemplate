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
          '회원가입 : 본인 이메일 검증 (1/2)',
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
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 300),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                flex: 20,
                                child: BlocBuilder<
                                    page_business.BlocEmailEditText, bool>(
                                  builder: (c, s) {
                                    return TextFormField(
                                      onChanged: (text) {
                                        pageBusiness.emailTextEditOnChanged();
                                      },
                                      enabled: pageBusiness
                                          .pageViewModel.emailTextEditEnabled,
                                      focusNode: pageBusiness
                                          .pageViewModel.emailTextEditFocus,
                                      controller: pageBusiness.pageViewModel
                                          .emailTextEditController,
                                      decoration: InputDecoration(
                                          errorText: pageBusiness.pageViewModel
                                              .emailTextEditErrorMsg,
                                          labelText: '이메일',
                                          hintText: "user@email.com"),
                                    );
                                  },
                                )),
                            const Expanded(child: SizedBox()),
                            Expanded(
                                flex: 10,
                                child: BlocBuilder<
                                    page_business.BlocEmailCheckBtn,
                                    bool>(builder: (c, s) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      // 중복 확인 버튼 동작
                                      pageBusiness.onEmailBtnClick();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            top: 2, bottom: 2),
                                        child: Text(
                                          pageBusiness
                                              .pageViewModel.emailCheckBtn,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "MaruBuri"),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: BlocBuilder<
                                page_business.BlocPasswordTextField,
                                bool>(builder: (c, s) {
                              return TextFormField(
                                onChanged: (text) {
                                  pageBusiness.passwordTextEditOnChanged();
                                },
                                focusNode: pageBusiness
                                    .pageViewModel.passwordTextFieldFocus,
                                controller: pageBusiness
                                    .pageViewModel.passwordTextFieldController,
                                obscureText:
                                    pageBusiness.pageViewModel.hidePassword,
                                onFieldSubmitted: (value) {
                                  pageBusiness.onPasswordFieldSubmitted();
                                },
                                decoration: InputDecoration(
                                  errorText: pageBusiness
                                      .pageViewModel.passwordTextEditErrorMsg,
                                  labelText: "비밀번호",
                                  hintText: 'xxxxxxxxxxx',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        pageBusiness.pageViewModel.hidePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                    onPressed: () {
                                      pageBusiness.toggleHidePassword();
                                    },
                                  ),
                                ),
                              );
                            }))
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            pageBusiness.onPasswordInputRuleTap();
                          },
                          child: BlocBuilder<
                              page_business.BlocPasswordInputRule,
                              bool>(builder: (c, s) {
                            var passwordInputRule =
                                pageBusiness.pageViewModel.passwordInputRuleHide
                                    ? const SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "비밀번호 입력 규칙",
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
                                              "비밀번호 입력 규칙",
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
                                              '1. 비밀번호의 길이는 최소 8자 이상으로 입력하세요.\n'
                                              '2. 비밀번호에 공백은 허용되지 않습니다.\n'
                                              '3. 비밀번호는 영문 대/소문자, 숫자, 특수문자의 조합으로 입력하세요.\n'
                                              '4. 아래 특수문자는 사용할 수 없습니다.\n'
                                              '    <, >, (, ), #, ’, /, |',
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
                          }),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(child: BlocBuilder<
                                page_business.BlocPasswordCheckTextField,
                                bool>(builder: (c, s) {
                              return TextFormField(
                                onChanged: (text) {
                                  pageBusiness.passwordCheckTextEditOnChanged();
                                },
                                focusNode: pageBusiness
                                    .pageViewModel.passwordCheckTextFieldFocus,
                                controller: pageBusiness.pageViewModel
                                    .passwordCheckTextFieldController,
                                obscureText: pageBusiness
                                    .pageViewModel.hidePasswordCheck,
                                onFieldSubmitted: (value) {
                                  pageBusiness.onPasswordCheckFieldSubmitted();
                                },
                                decoration: InputDecoration(
                                  errorText: pageBusiness.pageViewModel
                                      .passwordCheckTextEditErrorMsg,
                                  labelText: "비밀번호 확인",
                                  hintText: 'xxxxxxxxxxx',
                                  suffixIcon: IconButton(
                                    icon: Icon(pageBusiness
                                            .pageViewModel.hidePasswordCheck
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      pageBusiness.toggleHidePasswordCheck();
                                    },
                                  ),
                                ),
                              );
                            }))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    pageBusiness.goToNextStep();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    '다음 (2/2)',
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