// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

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
        title: const Text(
          'Member Join : Email Verification',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
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
                                          labelText: 'Email',
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
                                      child: Text(
                                        pageBusiness
                                            .pageViewModel.emailCheckBtn,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
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
                                  labelText: "Password",
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
                                  labelText: "Password Check",
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
                const SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    pageBusiness.goToNextStep();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: 300,
                  height: 300,
                  margin: const EdgeInsets.only(top: 20),
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
                          "Password generation rules",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '1. Set the length of the password to at least 8 digits\n'
                          '2. Spaces cannot be used in the password.\n'
                          '3. The password must consist of a combination of letters, numbers, and special characters.\n'
                          '(Passwords using only one type or a combination of both cannot be generated.)\n'
                          '4. It is not recommended to use more than 3 consecutive numbers or strings.\n'
                          '(Example: 123. 456. Abc cannot be included in passwords)\n'
                          '5. Using the same character more than three times in a row is not recommended.\n'
                          '6. Do not use the following special characters as they are vulnerable to security\n'
                          '<, >, (, ), #, ’, /, |',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
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
