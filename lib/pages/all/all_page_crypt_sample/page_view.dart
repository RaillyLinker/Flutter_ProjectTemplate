// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/sl_widget.dart'
    as gw_page_outer_frame_view;
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

    return gw_page_outer_frame_view.SlWidget(
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame_view.InputVo(
        pageTitle: "암/복호화 샘플",
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(
                                  color: Colors.blue, width: 1.0), // 테두리 스타일 조정
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Form(
                                key: pageBusiness.pageViewModel.aes256FormKey,
                                child: Column(
                                  children: [
                                    const Text('AES256 알고리즘',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "MaruBuri")),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                            flex: 20,
                                            child: TextFormField(
                                              controller: pageBusiness
                                                  .pageViewModel
                                                  .aes256SecretKeyTextController,
                                              maxLength: 32,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(
                                                        RegExp(r'[a-zA-Z0-9]')),
                                              ],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return '암호키를 입력하세요.';
                                                } else if (!RegExp(
                                                        r'^[a-zA-Z0-9]{32}$')
                                                    .hasMatch(value)) {
                                                  return '암호키 32자를 입력하세요.';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  labelText: '암호키',
                                                  hintText: "암호화 키 32자 입력"),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                            flex: 20,
                                            child: TextFormField(
                                              controller: pageBusiness
                                                  .pageViewModel
                                                  .aes256IvTextController,
                                              maxLength: 16,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(
                                                        RegExp(r'[a-zA-Z0-9]')),
                                              ],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return '초기화 벡터를 입력하세요.';
                                                } else if (!RegExp(
                                                        r'^[a-zA-Z0-9]{16}$')
                                                    .hasMatch(value)) {
                                                  return '초기화 벡터 16자를 입력하세요.';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  labelText: '초기화 벡터',
                                                  hintText: "암호 초기화 벡터 16자 입력"),
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                            flex: 20,
                                            child: TextFormField(
                                              controller: pageBusiness
                                                  .pageViewModel
                                                  .aes256EncryptTextController,
                                              decoration: const InputDecoration(
                                                  labelText: '암호화할 평문',
                                                  hintText: "암호화할 평문을 입력하세요."),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                            flex: 10,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (pageBusiness.pageViewModel
                                                    .aes256FormKey.currentState!
                                                    .validate()) {
                                                  pageBusiness
                                                      .pageViewModel
                                                      .aes256FormKey
                                                      .currentState!
                                                      .save();
                                                  pageBusiness.doEncrypt();
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "암호화",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "MaruBuri"),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Expanded(
                                            flex: 20,
                                            child: Text(
                                              "결과 :",
                                              style: TextStyle(
                                                  fontFamily: "MaruBuri"),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                            flex: 80,
                                            child: BlocBuilder<
                                                page_business
                                                .BlocEncryptResultText,
                                                bool>(
                                              builder: (c, s) {
                                                return SelectableText(
                                                  pageBusiness.pageViewModel
                                                      .aes256EncryptResultText,
                                                  style: const TextStyle(
                                                      fontFamily: "MaruBuri"),
                                                );
                                              },
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                            flex: 20,
                                            child: TextFormField(
                                              controller: pageBusiness
                                                  .pageViewModel
                                                  .aes256DecryptTextController,
                                              decoration: const InputDecoration(
                                                  labelText: '복호화할 암호문',
                                                  hintText: "복호화할 암호문을 입력하세요."),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                            flex: 10,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (pageBusiness.pageViewModel
                                                    .aes256FormKey.currentState!
                                                    .validate()) {
                                                  pageBusiness
                                                      .pageViewModel
                                                      .aes256FormKey
                                                      .currentState!
                                                      .save();
                                                  pageBusiness.doDecrypt();
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
                                                      color: Colors.white,
                                                      fontFamily: "MaruBuri"),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Expanded(
                                            flex: 20,
                                            child: Text(
                                              "결과 :",
                                              style: TextStyle(
                                                  fontFamily: "MaruBuri"),
                                            )),
                                        const Expanded(child: SizedBox()),
                                        Expanded(
                                            flex: 80,
                                            child: BlocBuilder<
                                                page_business
                                                .BlocDecryptResultText,
                                                bool>(
                                              builder: (c, s) {
                                                return SelectableText(
                                                  pageBusiness.pageViewModel
                                                      .aes256DecryptResultText,
                                                  style: const TextStyle(
                                                      fontFamily: "MaruBuri"),
                                                );
                                              },
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
