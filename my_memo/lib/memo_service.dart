import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';

// Memo 데이터의 형식을 정해줍니다. 추후 isPinned, updatedAt 등의 정보도 저장할 수 있습니다.
class Memo {
  Memo({required this.content, this.isChecked = false, this.updatedAt = ""});

  String content;
  bool isChecked;
  String updatedAt;

  Map toJson() {
    return {'content': content, 'isChecked': isChecked, 'updatedAt': updatedAt};
  }

  factory Memo.fromJson(json) {
    return Memo(
        content: json['content'],
        isChecked: json['isChecked'],
        updatedAt: (json['updatedAt'] != null) ? json['updatedAt'] : "");
  }
}

// Memo 데이터는 모두 여기서 관리
class MemoService extends ChangeNotifier {
  MemoService() {
    loadMemoList();
  }

  List<Memo> memoList = [
    Memo(content: '장보기 목록: 사과, 양파'), // 더미(dummy) 데이터
    Memo(content: '새 메모'), // 더미(dummy) 데이터
  ];

  createMemo({required String content}) {
    var now = new DateTime.now();
    String time = DateFormat("yy-MM-dd HH:mm:ss").format(now);
    Memo memo = Memo(content: content, isChecked: false, updatedAt: time);
    memoList.add(memo);
    notifyListeners(); // Consumer<MemoService>의 builder 부분을 호출해서 화면을 새로고침
    saveMemoList();
  }

  updateMemo({required int index, required String content}) {
    Memo memo = memoList[index];
    memo.content = content;
    var now = new DateTime.now();
    String time = DateFormat("yy-MM-dd HH:mm:ss").format(now);
    memo.updatedAt = time;
    notifyListeners();
    saveMemoList();
  }

  updateMemoChecked({required int index, required bool isChecked}) {
    Memo memo = memoList[index];
    memo.isChecked = isChecked;
    memoList.sort((m1, m2) {
      if (m1.isChecked)
        return -1;
      else if (m1.isChecked == m2.isChecked)
        return 0;
      else
        return 1;
    });
    notifyListeners();
    saveMemoList();
  }

  deleteMemo({required int index}) {
    memoList.removeAt(index);
    notifyListeners();
    saveMemoList();
  }

  saveMemoList() {
    List memoJsonList = memoList.map((memo) => memo.toJson()).toList();
    // [{"content": "1"}, {"content": "2"}]

    String jsonString = jsonEncode(memoJsonList);
    // '[{"content": "1"}, {"content": "2"}]'

    prefs.setString("memoList", jsonString);
  }

  loadMemoList() {
    String? jsonString = prefs.getString('memoList');
    // '[{"content": "1"}, {"content": "2"}]'

    if (jsonString == null) return; // null 이면 로드하지 않음

    List memoJsonList = jsonDecode(jsonString);
    // [{"content": "1"}, {"content": "2"}]

    memoList = memoJsonList.map((json) => Memo.fromJson(json)).toList();
  }
}
