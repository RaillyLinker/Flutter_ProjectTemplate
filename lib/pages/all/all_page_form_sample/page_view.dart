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
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: const Text(
          "폼 입력 샘플",
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
                const Text('테스트 폼',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "MaruBuri")),
                const SizedBox(height: 30.0),
                TextFormField(
                  key: pageBusiness.pageViewModel.inputAnythingTextFieldKey,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '무제한 입력',
                    hintText: "아무 값이나 입력 하세요.",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  controller: pageBusiness
                      .pageViewModel.inputAnythingTextFieldController,
                  focusNode:
                      pageBusiness.pageViewModel.inputAnythingTextFieldFocus,
                  validator: (value) {
                    // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
                    if (value == null || value.isEmpty) {
                      return '이 항목을 입력 하세요.';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    // 입력창 포커스 상태에서 엔터
                    if (pageBusiness
                        .pageViewModel.inputAnythingTextFieldKey.currentState!
                        .validate()) {
                      FocusScope.of(context).requestFocus(pageBusiness
                          .pageViewModel.inputAlphabetTextFieldFocus);
                    } else {
                      FocusScope.of(context).requestFocus(pageBusiness
                          .pageViewModel.inputAnythingTextFieldFocus);
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  key: pageBusiness.pageViewModel.inputAlphabetTextFieldKey,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: '영문 / 숫자 16자 입력',
                    hintText: "영문 / 숫자를 16자 입력 하세요.",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  controller: pageBusiness
                      .pageViewModel.inputAlphabetTextFieldController,
                  focusNode:
                      pageBusiness.pageViewModel.inputAlphabetTextFieldFocus,
                  maxLength: 16,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  ],
                  validator: (value) {
                    // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
                    if (value == null || value.isEmpty) {
                      return '이 항목을 입력 하세요.';
                    } else if (!RegExp(r'^[a-zA-Z0-9]{16}$').hasMatch(value)) {
                      return '영문 / 숫자를 16자 입력 하세요.';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    // 입력창 포커스 상태에서 엔터
                    if (pageBusiness
                        .pageViewModel.inputAlphabetTextFieldKey.currentState!
                        .validate()) {
                      FocusScope.of(context).requestFocus(
                          pageBusiness.pageViewModel.inputNumberTextFieldFocus);
                    } else {
                      FocusScope.of(context).requestFocus(pageBusiness
                          .pageViewModel.inputAlphabetTextFieldFocus);
                    }
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  key: pageBusiness.pageViewModel.inputNumberTextFieldKey,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '숫자 16자 이내 입력',
                    hintText: "숫자를 16자 이내에 입력 하세요.",
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  controller:
                      pageBusiness.pageViewModel.inputNumberTextFieldController,
                  focusNode:
                      pageBusiness.pageViewModel.inputNumberTextFieldFocus,
                  maxLength: 16,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
                    if (value == null || value.isEmpty) {
                      return '이 항목을 입력 하세요.';
                    } else if (!RegExp(r'^[0-9]{1,16}$').hasMatch(value)) {
                      return '숫자를 16자 이내에 입력 하세요.';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    // 입력창 포커스 상태에서 엔터
                    if (pageBusiness
                        .pageViewModel.inputNumberTextFieldKey.currentState!
                        .validate()) {
                      FocusScope.of(context).requestFocus(
                          pageBusiness.pageViewModel.inputSecretTextFieldFocus);
                    } else {
                      FocusScope.of(context).requestFocus(
                          pageBusiness.pageViewModel.inputNumberTextFieldFocus);
                    }
                  },
                ),
                const SizedBox(height: 10.0),
                BlocBuilder<page_business.BlocSecretTestInput, bool>(
                    builder: (c, s) {
                  return TextFormField(
                    key: pageBusiness.pageViewModel.inputSecretTextFieldKey,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "암호값 입력",
                      hintText: '암호값을 입력하면 숨김 처리가 됩니다.',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: const Icon(
                        Icons.key,
                        color: Colors.grey,
                        size: 24.0, // 아이콘 크기 조정
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          pageBusiness.pageViewModel.inputSecretTextFieldHide
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          pageBusiness.pageViewModel.inputSecretTextFieldHide =
                              !pageBusiness
                                  .pageViewModel.inputSecretTextFieldHide;
                          pageBusiness.blocObjects.blocSecretTestInput.add(
                              !pageBusiness
                                  .blocObjects.blocSecretTestInput.state);
                        },
                      ),
                    ),
                    controller: pageBusiness
                        .pageViewModel.inputSecretTextFieldController,
                    focusNode:
                        pageBusiness.pageViewModel.inputSecretTextFieldFocus,
                    autofillHints: const [AutofillHints.password],
                    obscureText:
                        pageBusiness.pageViewModel.inputSecretTextFieldHide,
                    validator: (value) {
                      // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
                      if (value == null || value.isEmpty) {
                        return '이 항목을 입력 하세요.';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      // 입력창 포커스 상태에서 엔터
                      if (pageBusiness
                          .pageViewModel.inputSecretTextFieldKey.currentState!
                          .validate()) {
                        pageBusiness.completeTestForm();
                      } else {
                        FocusScope.of(context).requestFocus(pageBusiness
                            .pageViewModel.inputSecretTextFieldFocus);
                      }
                    },
                  );
                }),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () {
                    if (pageBusiness.pageViewModel.testFormKey.currentState!
                        .validate()) {
                      pageBusiness.completeTestForm();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "폼 완료",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "MaruBuri",
                          fontSize: 18,
                        ),
                      ),
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
