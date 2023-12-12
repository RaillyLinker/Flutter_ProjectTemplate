// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import 'package:flutter_project_template/global_widgets/gw_slw_page_outer_frame.dart'
    as gw_slw_page_outer_frame;
import 'package:flutter_project_template/a_must_delete/todo_do_delete.dart'
    as todo_do_delete;

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
        BlocProvider.of<todo_do_delete.BlocPageInfo>(context)
            .state
            .pageBusiness;

    return gw_slw_page_outer_frame.SlwPageOuterFrame(
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      pageTitle: "Post 메소드 요청 샘플 1",
      child: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black),
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "변수명",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "MaruBuri"),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          "설명 및 입력",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "MaruBuri"),
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestBodyString",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "(Body ",
                                  style: TextStyle(fontFamily: "MaruBuri"),
                                )),
                                Expanded(
                                    child: Text("String",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("String Body 파라미터",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TextField(
                              controller: pageBusiness.pageViewModel
                                  .networkRequestParamTextFieldController1,
                              decoration: const InputDecoration(
                                  hintText: "\"\"",
                                  border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestBodyStringNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("String?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("String Body 파라미터 Nullable",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TextField(
                              controller: pageBusiness.pageViewModel
                                  .networkRequestParamTextFieldController2,
                              decoration: const InputDecoration(
                                  hintText: "null",
                                  border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestBodyInt",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("Int",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Int Body 파라미터",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false, signed: false),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: pageBusiness.pageViewModel
                                  .networkRequestParamTextFieldController3,
                              decoration: const InputDecoration(
                                  hintText: "0", border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestBodyIntNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("Int?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Int Body 파라미터 Nullable",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false, signed: false),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: pageBusiness.pageViewModel
                                  .networkRequestParamTextFieldController4,
                              decoration: const InputDecoration(
                                  hintText: "null",
                                  border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestBodyDouble",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("Double",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Double Body 파라미터",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true, signed: false),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9.]")),
                                TextInputFormatter.withFunction(
                                    (oldValue, newValue) {
                                  String text = newValue.text;
                                  if (text.isNotEmpty) {
                                    double.parse(text);
                                  }
                                  return newValue;
                                }),
                              ],
                              controller: pageBusiness.pageViewModel
                                  .networkRequestParamTextFieldController5,
                              decoration: const InputDecoration(
                                  hintText: "0.0",
                                  border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestBodyDoubleNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("Double?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Double Body 파라미터 Nullable",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true, signed: false),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9.]")),
                                TextInputFormatter.withFunction(
                                    (oldValue, newValue) {
                                  String text = newValue.text;
                                  if (text.isNotEmpty) {
                                    double.parse(text);
                                  }
                                  return newValue;
                                }),
                              ],
                              controller: pageBusiness.pageViewModel
                                  .networkRequestParamTextFieldController6,
                              decoration: const InputDecoration(
                                  hintText: "null",
                                  border: OutlineInputBorder()),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestBodyBoolean",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("Boolean",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Boolean Body 파라미터",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: DropdownButton<bool>(
                              value: pageBusiness.pageViewModel
                                  .networkRequestParamTextFieldValue7,
                              items: <bool>[true, false]
                                  .map<DropdownMenuItem<bool>>((bool value) {
                                return DropdownMenuItem<bool>(
                                  value: value,
                                  child: Text("$value",
                                      style: const TextStyle(
                                          fontFamily: "MaruBuri")),
                                );
                              }).toList(),
                              onChanged: (bool? newValue) {
                                pageBusiness.pageViewModel
                                        .networkRequestParamTextFieldValue7 =
                                    newValue!;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestBodyBooleanNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("Boolean?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Boolean Body 파라미터 Nullable",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: DropdownButton<bool?>(
                              value: pageBusiness.pageViewModel
                                  .networkRequestParamTextFieldValue8,
                              items: <bool?>[true, false, null]
                                  .map<DropdownMenuItem<bool?>>((bool? value) {
                                return DropdownMenuItem<bool?>(
                                  value: value,
                                  child: Text("$value",
                                      style: const TextStyle(
                                          fontFamily: "MaruBuri")),
                                );
                              }).toList(),
                              onChanged: (bool? newValue) {
                                pageBusiness.pageViewModel
                                        .networkRequestParamTextFieldValue8 =
                                    newValue;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestBodyStringList",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("array[string]",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("StringList Body 파라미터",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<
                                    page_business
                                    .BlocNetworkRequestParamTextFieldValue9,
                                    bool>(
                                  builder: (c, s) {
                                    List<Widget> widgetList = [];
                                    for (int idx = 0;
                                        idx <
                                            pageBusiness
                                                .pageViewModel
                                                .networkRequestParamTextFieldValue9
                                                .length;
                                        idx++) {
                                      TextEditingController tec = pageBusiness
                                              .pageViewModel
                                              .networkRequestParamTextFieldValue9[
                                          idx];

                                      List<Widget> textFieldRow = [
                                        Expanded(
                                          child: TextField(
                                            controller: tec,
                                            decoration: const InputDecoration(
                                                hintText: "\"\"",
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      ];

                                      if (pageBusiness
                                              .pageViewModel
                                              .networkRequestParamTextFieldValue9
                                              .length >
                                          1) {
                                        textFieldRow.add(Container(
                                          margin:
                                              const EdgeInsets.only(left: 5),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                pageBusiness
                                                    .deleteNetworkRequestParamTextFieldValue9(
                                                        idx);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Text(
                                                "-",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "MaruBuri"),
                                              )),
                                        ));
                                      }

                                      widgetList.add(Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: textFieldRow,
                                        ),
                                      ));
                                    }

                                    Column stringListColumn = Column(
                                      children: widgetList,
                                    );

                                    return stringListColumn;
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        pageBusiness
                                            .addNetworkRequestParamTextFieldValue9();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: const Text(
                                        "리스트 추가",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "MaruBuri"),
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "requestBodyStringListNullable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "MaruBuri"),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Text("(Body ",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text("array[string]?",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "MaruBuri"))),
                                Expanded(
                                    child: Text(")",
                                        style:
                                            TextStyle(fontFamily: "MaruBuri")))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("StringList Body 파라미터 Nullable",
                              style: TextStyle(fontFamily: "MaruBuri")),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<
                                    page_business
                                    .BlocNetworkRequestParamTextFieldValue10,
                                    bool>(
                                  builder: (c, s) {
                                    List<Widget> widgetList = [];
                                    for (int idx = 0;
                                        idx <
                                            pageBusiness
                                                .pageViewModel
                                                .networkRequestParamTextFieldValue10
                                                .length;
                                        idx++) {
                                      TextEditingController tec = pageBusiness
                                              .pageViewModel
                                              .networkRequestParamTextFieldValue10[
                                          idx];

                                      List<Widget> textFieldRow = [
                                        Expanded(
                                          child: TextField(
                                            controller: tec,
                                            decoration: const InputDecoration(
                                                hintText: "\"\"",
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      ];

                                      textFieldRow.add(Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              pageBusiness
                                                  .deleteNetworkRequestParamTextFieldValue10(
                                                      idx);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: const Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "MaruBuri"),
                                            )),
                                      ));

                                      widgetList.add(Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: textFieldRow,
                                        ),
                                      ));
                                    }

                                    if (pageBusiness
                                        .pageViewModel
                                        .networkRequestParamTextFieldValue10
                                        .isEmpty) {
                                      widgetList.add(const Text("(Null)",
                                          style: TextStyle(
                                              fontFamily: "MaruBuri")));
                                    }

                                    Column stringListColumn = Column(
                                      children: widgetList,
                                    );

                                    return stringListColumn;
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        pageBusiness
                                            .addNetworkRequestParamTextFieldValue10();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: const Text(
                                        "리스트 추가",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "MaruBuri"),
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                    onPressed: () {
                      pageBusiness.doNetworkRequest(context: context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "네트워크 요청 테스트",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "MaruBuri"),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
