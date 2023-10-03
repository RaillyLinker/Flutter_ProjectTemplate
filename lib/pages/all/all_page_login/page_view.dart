// (external)
import 'package:flutter/foundation.dart';
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
      backgroundColor: Colors.blue,
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          '로그인',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: "MaruBuri"),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2.0),
          child: Divider(
            color: Colors.white,
            height: 2.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 45,
              ),
              const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 100.0,
              ),
              const SizedBox(height: 20.0),
              Container(
                width: 220.0,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  focusNode: pageBusiness.pageViewModel.emailTextFieldFocus,
                  keyboardType: TextInputType.emailAddress,
                  controller: pageBusiness.pageViewModel.idTextFieldController,
                  onFieldSubmitted: (value) {
                    pageBusiness.onIdFieldSubmitted();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintText: 'user@email.com',
                    labelText: "이메일 입력",
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const InkWell(
                      child: Icon(
                        Icons.email,
                        color: Colors.blue,
                        size: 24.0, // 아이콘 크기 조정
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: 220.0,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: BlocBuilder<page_business.BlocPasswordTextField, bool>(
                  builder: (c, s) {
                    return TextFormField(
                      focusNode:
                          pageBusiness.pageViewModel.passwordTextFieldFocus,
                      controller: pageBusiness
                          .pageViewModel.passwordTextFieldController,
                      obscureText: pageBusiness.pageViewModel.hidePassword,
                      onFieldSubmitted: (value) {
                        pageBusiness.onPasswordFieldSubmitted();
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        labelText: "비밀번호 입력",
                        hintText: 'xxxxxxxxxxx',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: const Icon(
                          Icons.key,
                          color: Colors.grey,
                          size: 24.0, // 아이콘 크기 조정
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(pageBusiness.pageViewModel.hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            pageBusiness.toggleHidePassword();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  pageBusiness.goToFindPasswordPage();
                },
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 180),
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: Text(
                          '비밀번호를 잊어버렸나요?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontFamily: "MaruBuri"),
                        )),
                        Text(
                          '✓',
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontFamily: "MaruBuri"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                height: 40,
                constraints: const BoxConstraints(minWidth: 200),
                child: ElevatedButton(
                  onPressed: () {
                    pageBusiness.accountLoginAsync();
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                  child: const Text(
                    '계정 로그인',
                    style: TextStyle(fontFamily: "MaruBuri"),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                constraints: const BoxConstraints(maxWidth: 185),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Text(
                      '아직 회원이 아닌가요?',
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              GestureDetector(
                onTap: () {
                  pageBusiness.selectRegisterWith();
                },
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 185),
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '회원 가입하러 가기',
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontFamily: "MaruBuri"),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
