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
          'Sign in',
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
                child: BlocBuilder<page_business.BlocAccountId, bool>(
                  builder: (c, s) {
                    String hintText;
                    String labelText;
                    IconData icon;
                    TextInputType textInputType;

                    switch (pageBusiness.pageViewModel.accountSignInType) {
                      case page_business.SignInType.nickname:
                        {
                          // 닉네임
                          labelText = "Nickname";
                          hintText = 'John Doe';
                          icon = Icons.account_box;
                          textInputType = TextInputType.text;
                        }
                        break;
                      case page_business.SignInType.email:
                        {
                          // 이메일
                          labelText = "Email";
                          hintText = 'user@email.com';
                          icon = Icons.email;
                          textInputType = TextInputType.emailAddress;
                        }
                        break;
                      case page_business.SignInType.phoneNumber:
                        {
                          // 전화번호
                          labelText = "Phone Number";
                          hintText = '00)000-0000-0000';
                          icon = Icons.phone;
                          textInputType = TextInputType.phone;
                        }
                        break;
                      default:
                        {
                          throw Exception("accountSignInType not supported");
                        }
                    }

                    return TextFormField(
                      focusNode: pageBusiness.pageViewModel.emailTextFieldFocus,
                      keyboardType: textInputType,
                      controller:
                          pageBusiness.pageViewModel.emailTextFieldController,
                      onFieldSubmitted: (value) {
                        pageBusiness.onIdFieldSubmitted();
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintText: hintText,
                        labelText: labelText,
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
                        prefixIcon: InkWell(
                          onTap: () {
                            // 아이콘 클릭 시
                            pageBusiness.changeSigninType();
                          },
                          child: Icon(
                            icon,
                            color: Colors.blue,
                            size: 24.0, // 아이콘 크기 조정
                          ),
                        ),
                      ),
                    );
                  },
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
                        labelText: "Password",
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
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  pageBusiness.changeSigninType();
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
                          'different account type',
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
              const SizedBox(height: 10.0),
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
                          'Forgot Your Password?',
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
              ElevatedButton(
                onPressed: () {
                  pageBusiness.accountSignInAsync();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                child: const Text(
                  'Sign in with Account',
                  style: TextStyle(fontFamily: "MaruBuri"),
                ),
              ),
              const SizedBox(height: 30.0),
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
                        Expanded(
                            child: Text(
                          'Not a member?',
                          style: TextStyle(
                              color: Colors.white, fontFamily: "MaruBuri"),
                        )),
                        Text(
                          'Register now',
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontFamily: "MaruBuri"),
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
