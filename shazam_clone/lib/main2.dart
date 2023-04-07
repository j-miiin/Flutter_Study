import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shazam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Builder(builder: (context) {
        DefaultTabController.of(context)?.addListener(() {
          setState(() {});
        });

        return Scaffold(
          body: Stack(
            children: [
              TabBarView(
                children: [
                  FirstTab(),
                  SecondTab(),
                  ThirdTab(),
                ],
              ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: TabPageSelector(
                          color: DefaultTabController.of(context)?.index == 1
                              ? Colors.blue[300]
                              : Colors.grey[400],
                          selectedColor:
                              DefaultTabController.of(context)?.index == 1
                                  ? Colors.white
                                  : Colors.blue,
                          indicatorSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// 첫번째 페이지
class FirstTab extends StatelessWidget {
  const FirstTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const songs = [
      {
        'imageUrl': 'https://i.ytimg.com/vi/jAO0KXRdz_4/hqdefault.jpg',
        'title': '가을밤에 든 생각',
        'artist': '잔나비',
      },
      {
        'imageUrl': 'https://i.ytimg.com/vi/jAO0KXRdz_4/hqdefault.jpg',
        'title': '가을밤에 든 생각',
        'artist': '잔나비',
      },
      {
        'imageUrl': 'https://i.ytimg.com/vi/jAO0KXRdz_4/hqdefault.jpg',
        'title': '가을밤에 든 생각',
        'artist': '잔나비',
      },
      {
        'imageUrl': 'https://i.ytimg.com/vi/jAO0KXRdz_4/hqdefault.jpg',
        'title': '가을밤에 든 생각',
        'artist': '잔나비',
      },
      {
        'imageUrl': 'https://i.ytimg.com/vi/jAO0KXRdz_4/hqdefault.jpg',
        'title': '가을밤에 든 생각',
        'artist': '잔나비',
      },
      {
        'imageUrl': 'https://i.ytimg.com/vi/jAO0KXRdz_4/hqdefault.jpg',
        'title': '가을밤에 든 생각',
        'artist': '잔나비',
      },
    ];

    return Center(child: Text('첫번째 페이지'));
  }
}

// 두번째 페이지
class SecondTab extends StatelessWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.indigo],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    DefaultTabController.of(context)!.animateTo(0);
                  },
                  child: Column(children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "라이브러리",
                      style: TextStyle(color: Colors.white),
                    )
                  ]),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    DefaultTabController.of(context)!.animateTo(2);
                  },
                  child: Column(children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.show_chart,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "차트",
                      style: TextStyle(color: Colors.white),
                    )
                  ]),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              'Shazam하려면 탭하세요',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Stack(alignment: Alignment.center, children: [
              Container(
                width: 179,
                height: 178,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white),
              ),
              Image.network(
                'https://user-images.githubusercontent.com/62470991/230337252-da4f4bfd-10e8-4e8e-8c7a-771ec2cd06b9.png',
                width: 180,
                height: 180,
                fit: BoxFit.cover,
                color: Colors.blue.withOpacity(0.8),
              ),
            ]),
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: Colors.blue),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      )),
    );
  }
}

// 세번째 페이지
class ThirdTab extends StatelessWidget {
  const ThirdTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const chartData = {
      'korea': [
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
      ],
      'global': [
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
      ],
      'newyork': [
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
        {
          'imageUrl': 'https://i.ibb.co/xf2HpfG/dynamite.jpg',
          'name': 'Dynamite',
          'artist': 'BTS',
        },
      ],
    };

    return Column(
      children: [
        Container(
          height: 65,
          child: Center(
            child: Text(
              "차트",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              height: 180,
              color: Color.fromARGB(255, 74, 20, 140),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 55),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("국가 및 도시별 차트",
                          style: TextStyle(
                              color: Color.fromARGB(255, 74, 20, 140))),
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                    ),
                  ),
                  Text(
                    "전 세계",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text("대한민국 차트"),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "모두 보기",
                      style: TextStyle(color: Colors.lightBlue, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      'https://i.ibb.co/xf2HpfG/dynamite.jpg',
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      "Dynamite",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "BTS",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
