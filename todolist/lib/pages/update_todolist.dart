import 'package:flutter/material.dart';
// http method package
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UpdatePage extends StatefulWidget {
  //const UpdatePage({Key? key}) : super(key: key);
  //เหมือนในหน้า detail
  final v1, v2, v3; //ส่ง value มา 3 ตัว คือ id, tilte, detail
  const UpdatePage(this.v1, this.v2, this.v3);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  //เป็นการประกาศตัวแปรไว้
  var _v1, _v2, _v3;
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

//พิมพ์ init แล้วเลือก function แรก
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
// เป็น v1data ก็ได้
    _v1 = widget.v1; //id
    _v2 = widget.v2; // title
    _v3 = widget.v3; // detail
    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไข'),
        actions: [
          IconButton(
              onPressed: () {
                print("Delete ID:$_v1");
                deleteTodo();
                //pop ให้เด้งกลับหลังจากลบ
                Navigator.pop(context, 'delete');
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            //ข้อความ
            //Text("Todo List",
            //    style: TextStyle(
            //        fontSize: 30,
            //        fontFamily: 'Sarabun',
            //        color: Colors.green[900])),
            //SizedBox(height: 20),
            //รูปภาพ
            //Image.asset(
            // 'assets/images/logo2.png',
            //width: 150,
            // ),
            SizedBox(height: 20),
            // ช่องกรอกข้อมูล title
            TextField(
                controller: todo_title,
                decoration: InputDecoration(
                    labelText: 'รายการที่ต้องทำ',
                    border: OutlineInputBorder())),
            SizedBox(
              height: 30,
            ),
            TextField(
                minLines: 4,
                maxLines: 8,
                controller: todo_detail,
                decoration: InputDecoration(
                    labelText: 'รายละเอียด', border: OutlineInputBorder())),
            SizedBox(
              height: 30,
            ),
            // ปุ่มเพิ่มข้อมูล
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  print('-----------');
                  print('title: ${todo_title.text}');
                  print('detail: ${todo_detail.text}');
                  postTodo();
                  final snackBar = SnackBar(
                    content: const Text('update success completed'),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text("แก้ไข"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(50, 20, 50, 20)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 30))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    //var url = Uri.https('d15b-202-28-78-205.ngrok.io', '/api/post-todolist');
    var url = Uri.http('10.80.25.200:8000', '/api/update-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('------result-------');
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http('10.80.25.200:8000', '/api/delete-todolist/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('------result-------');
    print(response.body);
  }
}
