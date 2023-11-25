// (external)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// (page)
import 'page_business.dart' as page_business;

// (all)
import '../../../global_widgets/gw_page_outer_frame/widget_view.dart'
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

    return gw_page_outer_frame_view.WidgetView(
      business: pageBusiness.pageViewModel.pageOutFrameBusiness,
      inputVo: gw_page_outer_frame_view.InputVo(

        pageTitle: "Post 메소드 요청 샘플 4 (multipart/form-data - JsonString)",
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
                              "requestFormString",
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
                            const Text("String Form 파라미터",
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
                              "requestFormStringNullable",
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
                            const Text("String Form 파라미터 Nullable",
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
                              "requestFormInt",
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
                            const Text("Int Form 파라미터",
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
                              "requestFormIntNullable",
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
                            const Text("Int Form 파라미터 Nullable",
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
                              "requestFormDouble",
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
                            const Text("Double Form 파라미터",
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
                              "requestFormDoubleNullable",
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
                            const Text("Double Form 파라미터 Nullable",
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
                              "requestFormBoolean",
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
                            const Text("Boolean Form 파라미터",
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
                              "requestFormBooleanNullable",
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
                            const Text("Boolean Form 파라미터 Nullable",
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
                              "requestFormStringList",
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
                            const Text("StringList Form 파라미터",
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
                                              ),
                                            ),
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
                                      ),
                                    ),
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
                              "requestFormStringListNullable",
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
                            const Text("StringList Form 파라미터 Nullable",
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
                                            ),
                                          ),
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
                                      ),
                                    ),
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
                              "multipartFile",
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
                                      child: Text("MultipartFile",
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
                            const Text("Multipart File",
                                style: TextStyle(fontFamily: "MaruBuri")),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  BlocBuilder<
                                      page_business
                                          .BlocNetworkRequestParamMultipartPath11,
                                      bool>(
                                    builder: (c, s) {
                                      if (pageBusiness.pageViewModel.pickFile1 ==
                                          null) {
                                        return const Text("Null",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: "MaruBuri"));
                                      } else {
                                        return Text(
                                            pageBusiness
                                                .pageViewModel.pickFile1!.name,
                                            style: const TextStyle(
                                                fontFamily: "MaruBuri"));
                                      }
                                    },
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          pageBusiness.pickFile1();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        child: const Text(
                                          "파일 선택",
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
                              "multipartFileNullable",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MaruBuri"),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 260),
                              child: const Row(
                                children: [
                                  Expanded(
                                      child: Text("(Body ",
                                          style:
                                          TextStyle(fontFamily: "MaruBuri"))),
                                  Expanded(
                                      child: Text("MultipartFile?",
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
                            const Text("Multipart File Nullable",
                                style: TextStyle(fontFamily: "MaruBuri")),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  BlocBuilder<
                                      page_business
                                          .BlocNetworkRequestParamMultipartPath12,
                                      bool>(
                                    builder: (c, s) {
                                      if (pageBusiness.pageViewModel.pickFile2 ==
                                          null) {
                                        return const Text("Null",
                                            style: TextStyle(
                                                fontFamily: "MaruBuri"));
                                      } else {
                                        return Text(
                                            pageBusiness
                                                .pageViewModel.pickFile2!.name,
                                            style: const TextStyle(
                                                fontFamily: "MaruBuri"));
                                      }
                                    },
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: BlocBuilder<
                                        page_business
                                            .BlocNetworkRequestParamMultipartPath12,
                                        bool>(
                                      builder: (c, s) {
                                        if (pageBusiness
                                            .pageViewModel.pickFile2 ==
                                            null) {
                                          return ElevatedButton(
                                              onPressed: () {
                                                pageBusiness.pickFile2();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Text(
                                                "파일 선택",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "MaruBuri"),
                                              ));
                                        } else {
                                          return ElevatedButton(
                                              onPressed: () {
                                                pageBusiness.deleteFile2();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                              ),
                                              child: const Text(
                                                "파일 선택 취소",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "MaruBuri"),
                                              ));
                                        }
                                      },
                                    ),
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
                        pageBusiness.doNetworkRequest();
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
      ),
    );
  }
}
