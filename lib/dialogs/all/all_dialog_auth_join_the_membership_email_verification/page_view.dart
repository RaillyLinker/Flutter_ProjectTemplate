// (external)
import 'package:flutter/material.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)

// [페이지 화면 위젯 작성 파일]
// 페이지 화면 구현을 담당합니다.
// 로직 처리는 pageBusiness 객체에 위임하세요.

//------------------------------------------------------------------------------
// (페이지 UI 위젯)
// !!!세부 화면 정의!!!
class PageView extends StatelessWidget {
  const PageView(this._pageBusiness, {super.key});

  // 페이지 비즈니스 객체
  final page_business.PageBusiness _pageBusiness;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
            child: Container(
                width: 400,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 20, right: 20, left: 20),
                        child: Column(children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  _pageBusiness.closeDialog();
                                },
                              )),
                          Container(
                            width: 400,
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 3, bottom: 3),
                            decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: const Center(
                              child: Text(
                                '본인 인증 이메일이 전송되었습니다.',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: "MaruBuri"),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            '본인 인증 코드 검증',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            width: 400,
                            child: Text(
                              '이메일 회원 가입을 위하여,\n본인 인증 이메일을\n(${_pageBusiness.pageInputVo.emailAddress})\n에 발송하였습니다.',
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "MaruBuri"),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            width: 400,
                            child: Form(
                              key: _pageBusiness
                                  .pageViewModel.verificationCodeFormKey,
                              child: TextFormField(
                                autofocus: true,
                                onFieldSubmitted: (value) {
                                  _pageBusiness.verifyCodeAndGoNext();
                                },
                                focusNode: _pageBusiness.pageViewModel
                                    .verificationCodeTextFieldFocus,
                                controller: _pageBusiness.pageViewModel
                                    .verificationCodeTextFieldController,
                                decoration: const InputDecoration(
                                  labelText: '본인 이메일 인증 코드',
                                  hintText: "발송된 본인 이메일 인증 코드를 입력하세요.",
                                ),
                                validator: (value) {
                                  // 검사 : return 으로 반환하는 에러 메세지가 null 이 아니라면 에러로 처리
                                  if (value == null || value.isEmpty) {
                                    return '이 항목을 입력 하세요.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                _pageBusiness.resendVerificationEmail();
                              },
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 160),
                                child: const Text(
                                  '본인 인증 이메일 재전송',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontFamily: "MaruBuri"),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Container(
                            width: 400,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 2, bottom: 2),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: const Text(
                              '이메일을 받지 못했다면,\n'
                              '- 입력한 이메일 주소가 올바른지 확인하세요.\n'
                              '- 이메일 스팸 보관함을 확인하세요.\n'
                              '- 이메일 저장소 용량이 충분한지 확인하세요.',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "MaruBuri"),
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          ElevatedButton(
                              onPressed: () {
                                _pageBusiness.verifyCodeAndGoNext();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const SizedBox(
                                  width: 400,
                                  height: 40,
                                  child: Center(
                                      child: Text('본인 인증 코드 검증',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "MaruBuri")))))
                        ]))))));
  }
}