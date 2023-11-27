import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'theme.dart';

class RecruitingFormPage extends StatefulWidget {
  @override
  _RecruitingFormPageState createState() => _RecruitingFormPageState();
}

class _RecruitingFormPageState extends State<RecruitingFormPage> {
  List<Widget> textForms = [];
  int questionIndex = 1; // 질문의 index를 추적
  DateTime? startDate;
  DateTime? endDate;
  final colorScheme = LetsCrewTheme.lightColorScheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recruiting Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("리크루팅 기간 선택: "),
                  SizedBox(
                    width: 10.w,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            startDate = value;
                          });
                        }
                      });
                    },
                    child: Text(
                      '시작 날짜',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(colorScheme.tertiary),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      ).then((value) {
                        if (value != null) {
                          setState(() {
                            endDate = value;
                          });
                        }
                      });
                    },
                    child: Text(
                      '종료 날짜',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(colorScheme.tertiary),
                    ),
                  ),
                ],
              ),
              startDate != null && endDate != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '선택된 날짜: ${DateFormat('yyyy-MM-dd').format(startDate!)} ~ ${DateFormat('yyyy-MM-dd').format(endDate!)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        textForms.add(TextFormWidget(
                          keyType: 0,
                          questionIndex: questionIndex,
                          response: '',
                        ));
                        questionIndex++;
                      });
                    },
                    child: Text(
                      '짧은 글 질문 추가',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(colorScheme.tertiary),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        textForms.add(TextFormWidget(
                          keyType: 1,
                          questionIndex: questionIndex,
                          response: '',
                        ));
                        questionIndex++;
                      });
                    },
                    child: Text(
                      '긴 글 질문 추가',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(colorScheme.tertiary),
                    ),
                  ),
                ],
              ),
              Column(
                children: textForms,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Firebase에 저장
                  saveToFirebase();
                },
                child: Text(
                  '저장하기',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(colorScheme.tertiary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveToFirebase() async {
    CollectionReference recruitingForm =
        FirebaseFirestore.instance.collection('recruiting');

    DocumentReference clubRecruiting = recruitingForm.doc('CRA');

    Map<String, dynamic> questionsMap = {};

    for (Widget formWidget in textForms) {
      if (formWidget is TextFormWidget) {
        int questionIndex = formWidget.questionIndex;
        // Add the question to the map
        questionsMap[questionIndex.toString()] = {
          'question': (formWidget as TextFormWidget).getResponse(),
          'lengthLong': formWidget.keyType,
        };
      }
    }

    await clubRecruiting.set({
      'questions': questionsMap,
      'startDate': startDate != null
          ? DateFormat('yyyy-MM-dd').format(startDate!)
          : null,
      'endDate':
          endDate != null ? DateFormat('yyyy-MM-dd').format(endDate!) : null,
    });

    print('데이터가 Firebase에 저장되었습니다.');
  }
}

class TextFormWidget extends StatefulWidget {
  final int keyType;
  final int questionIndex;
  String response;

  TextFormWidget({
    required this.keyType,
    required this.questionIndex,
    required this.response,
  });

  String get labelText => keyType == 0 ? '짧은 글 질문' : '긴 글 질문';

  @override
  _TextFormWidgetState createState() => _TextFormWidgetState();

  setResponse(String response) {
    this.response = response;
  }

  getResponse() {
    return response;
  }
}

class _TextFormWidgetState extends State<TextFormWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textController.addListener(() {
      setState(() {
        widget.setResponse(_textController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _textController,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
