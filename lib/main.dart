import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '무한 스크롤',
      home: RandomWords(), // 액티비티 불러오기
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <int>[]; // WordPair (단어) 배열
  final _biggerFont = const TextStyle(fontSize: 18.0); // 폰트 사이즈 선언

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0), // 패딩
        itemBuilder: (context, i) { // 안스에서 어댑터 안에 getView와 같은 역할
          if (i.isOdd) return Divider(); // 홀수번째는 구분선 추가
          final index = i ~/ 2; // 나눈값 정수 반환 (구분선 제외를 위한 나누기)
          if (index >= _suggestions.length) { // 스크롤량이 절반이상일시 단어추가
            _suggestions.add(index);  // 번호를 배열에 추가
          }
          return _buildRow(_suggestions[index]); // 리스트 타일 생성
        });
  }
  Widget _buildRow(int pair) { // 리스트 타일 생성 함수
    return ListTile(
      title: Text( // 타이틀
        pair.toString(),
        style: _biggerFont,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Number List'), // 앱바 타이틀
      ),
      body: _buildSuggestions(), // 리스트뷰 반환 함수
    );
  }
}
class RandomWords extends StatefulWidget { // StatefulWidget (상태 변경 가능)
  @override
  RandomWordsState createState() => new RandomWordsState(); // 이 위젯이 생성시 RandomWordsState를 불러옴
}