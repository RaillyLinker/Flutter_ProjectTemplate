// (external)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_out_frames.dart' as gw_page_out_frames;
import '../../../global_classes/gc_template_classes.dart'
    as gc_template_classes;

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView({super.key});

  @override
  Widget build(BuildContext context) {
    // pageBusiness 객체
    page_business.PageBusiness pageBusiness =
        BlocProvider.of<gc_template_classes.BlocPageInfo>(context)
            .state
            .pageBusiness;

    return gw_page_out_frames.PageOutFrame(
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      floatingActionButton: null,
      child: SingleChildScrollView(
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
                  autofillHints: const [AutofillHints.username],
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
                      autofillHints: const [AutofillHints.password],
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
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    pageBusiness.goToFindPasswordPage();
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: const Row(
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
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    pageBusiness.selectRegisterWith();
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 185),
                    child: const Row(
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
