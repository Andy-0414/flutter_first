import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '무한 스크롤',
      theme: ThemeData(
        primaryColor: Colors.indigoAccent
      ),
      home: RandomWords(), // 액티비티 불러오기
    );
  }
}

class RandomWords extends StatefulWidget { // StatefulWidget (상태 변경 가능)
  @override
  RandomWordsState createState() => new RandomWordsState(); // 이 위젯이 생성시 RandomWordsState를 불러옴
}
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <int>[]; // WordPair (단어) 배열
  final _saved = new Set<int>();
  final _biggerFont = const TextStyle(fontSize: 18.0); // 폰트 사이즈 선언

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context){
        final Iterable<ListTile> tiles = _saved.map((int pair){
          return ListTile(title: Text(pair.toString(),style: _biggerFont,));
        });

        final List<Widget> divided =ListTile.divideTiles(context: context,tiles: tiles,).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('Like List'),
          ),
          body: ListView(children: divided),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Number List'), // 앱바 타이틀
        actions: <Widget>[
          new IconButton(icon:Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(), // 리스트뷰 반환 함수
    );
  }
  Widget _buildRow(int pair) { // 리스트 타일 생성 함수
  final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text( // 타이틀
        pair.toString(),
        style: _biggerFont,
      ),
      trailing: new Icon(   // Add the lines from here... 
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }
          else{
            _saved.add(pair);
          }
        });
      },
    );
  }
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
}