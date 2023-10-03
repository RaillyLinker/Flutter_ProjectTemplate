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
          '비밀번호 변경',
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
                                  labelText: "현재 비밀번호 입력",
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
                        Row(
                          children: [
                            Expanded(child: BlocBuilder<
                                page_business.BlocNewPasswordTextField,
                                bool>(builder: (c, s) {
                              return TextFormField(
                                onChanged: (text) {
                                  pageBusiness.newPasswordTextEditOnChanged();
                                },
                                focusNode: pageBusiness
                                    .pageViewModel.newPasswordTextFieldFocus,
                                controller: pageBusiness.pageViewModel
                                    .newPasswordTextFieldController,
                                obscureText:
                                    pageBusiness.pageViewModel.hideNewPassword,
                                onFieldSubmitted: (value) {
                                  pageBusiness.onNewPasswordFieldSubmitted();
                                },
                                decoration: InputDecoration(
                                  errorText: pageBusiness.pageViewModel
                                      .newPasswordTextEditErrorMsg,
                                  labelText: "새 비밀번호 입력",
                                  hintText: 'xxxxxxxxxxx',
                                  suffixIcon: IconButton(
                                    icon: Icon(pageBusiness
                                            .pageViewModel.hideNewPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      pageBusiness.toggleHideNewPassword();
                                    },
                                  ),
                                ),
                              );
                            }))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: BlocBuilder<
                                page_business.BlocNewPasswordCheckTextField,
                                bool>(builder: (c, s) {
                              return TextFormField(
                                onChanged: (text) {
                                  pageBusiness
                                      .newPasswordCheckTextEditOnChanged();
                                },
                                focusNode: pageBusiness.pageViewModel
                                    .newPasswordCheckTextFieldFocus,
                                controller: pageBusiness.pageViewModel
                                    .newPasswordCheckTextFieldController,
                                obscureText: pageBusiness
                                    .pageViewModel.hideNewPasswordCheck,
                                onFieldSubmitted: (value) {
                                  pageBusiness
                                      .onNewPasswordCheckFieldSubmitted();
                                },
                                decoration: InputDecoration(
                                  errorText: pageBusiness.pageViewModel
                                      .newPasswordCheckTextEditErrorMsg,
                                  labelText: "새 비밀번호 확인 입력",
                                  hintText: 'xxxxxxxxxxx',
                                  suffixIcon: IconButton(
                                    icon: Icon(pageBusiness
                                            .pageViewModel.hideNewPasswordCheck
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      pageBusiness.toggleHideNewPasswordCheck();
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
                Container(
                  height: 40,
                  constraints: const BoxConstraints(minWidth: 200),
                  child: ElevatedButton(
                    onPressed: () {
                      pageBusiness.changePassword();
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    child: const Text(
                      '비밀번호 변경',
                      style:
                      TextStyle(color: Colors.white, fontFamily: "MaruBuri"),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 300,
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 2, bottom: 2),
                  decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          // POINT
                          color: Colors.black,
                          width: 1.0,
                        ),
                        right: BorderSide(
                          // POINT
                          color: Colors.black,
                          width: 1.0,
                        ),
                        bottom: BorderSide(
                          // POINT
                          color: Colors.black,
                          width: 1.0,
                        ),
                        top: BorderSide(
                          // POINT
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "비밀번호 입력 규칙",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: "MaruBuri"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '1. 비밀번호의 길이는 최소 8자 이상으로 입력하세요.\n'
                          '2. 비밀번호에 공백은 허용되지 않습니다.\n'
                          '3. 비밀번호는 영문 대/소문자, 숫자, 특수문자의 조합으로 입력하세요.\n'
                          '4. 문자, 숫자를 3 글자 이상 연속된 값으로 입력하는 것은 보안상 좋지 않습니다.\n'
                          '    (예 : 123..., 456..., abc...)\n'
                          '5. 같은 글자를 3번 이상 반복하는 것은 보안상 좋지 않습니다.\n'
                          '6. 아래 특수문자는 사용할 수 없습니다.\n'
                          '    <, >, (, ), #, ’, /, |',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: "MaruBuri"),
                        )
                      ],
                    ),
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
