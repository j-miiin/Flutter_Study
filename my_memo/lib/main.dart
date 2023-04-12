import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'memo_service.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MemoService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MemoService>(
      builder: (context, memoService, child) {
        // memoService로부터 memoList 가져오기
        List<Memo> memoList = memoService.memoList;

        return Scaffold(
          appBar: AppBar(
            title: Text("mymemo"),
          ),
          body: memoList.isEmpty
              ? Center(child: Text("메모를 작성해주세요"))
              : ListView.builder(
                  itemCount: memoList.length,
                  itemBuilder: ((context, index) {
                    Memo memo = memoList[index]; // index에 해당하는 memo 가져오기
                    return ListTile(
                      // 메모 고정 아이콘
                      leading: IconButton(
                        icon: Icon(CupertinoIcons.pin),
                        onPressed: () {},
                      ),
                      // 메모 내용 (최대 3줄까지 보이도록)
                      title: Text(
                        memo.content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // 아이템 클릭 시
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(
                              index: index,
                            ),
                          ),
                        );
                      },
                    );
                  })),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // + 버튼 클릭시 메모 생성 및 수정 페이지로 이동
              memoService.createMemo(content: "");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      DetailPage(index: memoService.memoList.length - 1),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// 메모 생성 및 수정 페이지
class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.index});

  final int index;

  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 위젯 트리 상단에 있는 Provider로 등록한 클래스에 접근 가능 (화면 새로고침 필요 없을 때 사용)
    MemoService memoService = context.read<MemoService>();
    Memo memo = memoService.memoList[index];

    contentController.text = memo.content; // TextEditingController의 초기값을 설정해줌

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // 삭제 버튼 클릭시
              showDeleteDialog(context, memoService);
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: contentController,
          decoration: InputDecoration(
            hintText: "메모를 입력하세요",
            border: InputBorder.none,
          ),
          autofocus: true,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          onChanged: (value) {
            // 텍스트필드 안의 값이 변할 때
            memoService.updateMemo(index: index, content: value);
          },
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context, MemoService memoService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("정말로 삭제하시겠습니까?"),
          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("취소"),
            ),
            // 확인 버튼
            TextButton(
              onPressed: () {
                memoService.deleteMemo(index: index);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }
}
