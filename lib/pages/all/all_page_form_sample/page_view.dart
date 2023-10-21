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
// todo

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
          "Form 입력 샘플",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child:
            // 여기부터 Form 하나
            Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.black),
              bottom: BorderSide(width: 1.0, color: Colors.black),
              left: BorderSide(width: 1.0, color: Colors.black),
              right: BorderSide(width: 1.0, color: Colors.black),
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Form(
            key: pageBusiness.pageViewModel.testFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Test 폼',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "MaruBuri")),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: '무제한 입력', hintText: "아무 값이나 입력 하세요."),
                  // controller: pageBusiness
                  //     .pageViewModel
                  //     .aes256SecretKeyTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이 항목을 입력 하세요.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: '영문 / 숫자 16자 입력', hintText: "영문 / 숫자를 16자 입력 하세요."),
                  // controller: pageBusiness
                  //     .pageViewModel
                  //     .aes256IvTextController,
                  maxLength: 16,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이 항목을 입력 하세요.';
                    } else if (!RegExp(r'^[a-zA-Z0-9]{16}$').hasMatch(value)) {
                      return '영문 / 숫자를 16자 입력 하세요.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: '숫자 16자 이내 입력', hintText: "숫자를 16자 이내에 입력 하세요."),
                  // controller: pageBusiness
                  //     .pageViewModel
                  //     .aes256IvTextController,
                  maxLength: 16,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이 항목을 입력 하세요.';
                    } else if (!RegExp(r'^[0-9]{1,16}$').hasMatch(value)) {
                      return '숫자를 16자 이내에 입력 하세요.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autofillHints: const [AutofillHints.password],
                  // focusNode:
                  // pageBusiness.pageViewModel.passwordTextFieldFocus,
                  // controller: pageBusiness
                  //     .pageViewModel
                  //     .aes256IvTextController,
                  // obscureText: pageBusiness.pageViewModel.hidePassword,
                  // onFieldSubmitted: (value) {
                  //   pageBusiness.onPasswordFieldSubmitted();
                  // },
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
                    // suffixIcon: IconButton(
                    //   icon: Icon(pageBusiness.pageViewModel.hidePassword
                    //       ? Icons.visibility
                    //       : Icons.visibility_off,),
                    //   onPressed: () {
                    //     pageBusiness.toggleHidePassword();
                    //   },
                    // ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (pageBusiness.pageViewModel.testFormKey.currentState!
                        .validate()) {
                      pageBusiness.pageViewModel.testFormKey.currentState!
                          .save();
                      // todo
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Center(
                    child: Text(
                      "복호화",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
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
