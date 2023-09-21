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
          'Post Request Sample 1',
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
                        "Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(child: Text("(Body ")),
                                Expanded(
                                    child: Text("String",
                                        style: TextStyle(color: Colors.red))),
                                Expanded(child: Text(")"))
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
                          const Text("String Body Parameter"),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(child: Text("(Body ")),
                                Expanded(
                                    child: Text("String?",
                                        style: TextStyle(color: Colors.black))),
                                Expanded(child: Text(")"))
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
                          const Text("String Body Parameter Nullable"),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(child: Text("(Body ")),
                                Expanded(
                                    child: Text("Int",
                                        style: TextStyle(color: Colors.red))),
                                Expanded(child: Text(")"))
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
                          const Text("Int Body Parameter"),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(child: Text("(Body ")),
                                Expanded(
                                    child: Text("Int?",
                                        style: TextStyle(color: Colors.black))),
                                Expanded(child: Text(")"))
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
                          const Text("Int Body Parameter Nullable"),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(child: Text("(Body ")),
                                Expanded(
                                    child: Text("Double",
                                        style: TextStyle(color: Colors.red))),
                                Expanded(child: Text(")"))
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
                          const Text("Double Body Parameter"),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(child: Text("(Body ")),
                                Expanded(
                                    child: Text("Double?",
                                        style: TextStyle(color: Colors.black))),
                                Expanded(child: Text(")"))
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
                          const Text("Double Body Parameter Nullable"),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(child: Text("(Body ")),
                                Expanded(
                                    child: Text("Boolean",
                                        style: TextStyle(color: Colors.red))),
                                Expanded(child: Text(")"))
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
                          const Text("Boolean Body Parameter"),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: DropdownButton<bool>(
                              value: pageBusiness.pageViewModel
                                  .networkRequestParamTextFieldValue7,
                              items: <bool>[true, false]
                                  .map<DropdownMenuItem<bool>>((bool value) {
                                return DropdownMenuItem<bool>(
                                  value: value,
                                  child: Text(
                                    "$value",
                                  ),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(child: Text("(Body ")),
                                Expanded(
                                    child: Text("Boolean?",
                                        style: TextStyle(color: Colors.black))),
                                Expanded(child: Text(")"))
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
                          const Text("Boolean Body Parameter Nullable"),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: DropdownButton<bool?>(
                              value: pageBusiness.pageViewModel
                                  .networkRequestParamTextFieldValue8,
                              items: <bool?>[true, false, null]
                                  .map<DropdownMenuItem<bool?>>((bool? value) {
                                return DropdownMenuItem<bool?>(
                                  value: value,
                                  child: Text(
                                    "$value",
                                  ),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(child: Text("(Body ")),
                                Expanded(
                                    child: Text("array[string]",
                                        style: TextStyle(color: Colors.red))),
                                Expanded(child: Text(")"))
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
                          const Text("StringList Body Parameter"),
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
                                                    color: Colors.white),
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
                                        "Add List Item",
                                        style: TextStyle(color: Colors.white),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: const Row(
                              children: [
                                Expanded(child: Text("(Body ")),
                                Expanded(
                                    child: Text("array[string]?",
                                        style: TextStyle(color: Colors.black))),
                                Expanded(child: Text(")"))
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
                          const Text("StringList Body Parameter Nullable"),
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
                                                  color: Colors.white),
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
                                      widgetList.add(const Text("(Null)"));
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
                                        "Add List Item",
                                        style: TextStyle(color: Colors.white),
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
                      pageBusiness.doNetworkRequest();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Network Request Test",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
