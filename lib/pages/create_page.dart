import 'package:flutter/material.dart';



import '../service/auth_service.dart';


import '../service/rtdb_service.dart';
import 'model/post_model.dart';

class GreatPage extends StatefulWidget {
  const GreatPage({super.key});

  @override
  State<GreatPage> createState() => _GreatPageState();
}

class _GreatPageState extends State<GreatPage> {
  var isLoading = false;
  var firstController = TextEditingController();
  var lastController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();
  _createPost (){
    String firstname = firstController.text.toString();
    String lastname = lastController.text.toString();
    String content = contentController.text.toString();
    String date = dateController.text.toString();
    if(firstname.isEmpty || lastname.isEmpty) return;

    _apiCreatePost(firstname, lastname,content,date);
  }
  _apiCreatePost (String firstname, String lastname,String content,String date) {
    setState(() {
      isLoading = false;
    });
    var post = Post(firstname: firstname, lastname: lastname,content: content,date: date);
    RTDBService.addPost(post).then((value) =>
    {
      _resAddPost ()
    });
  }
  _resAddPost() {
    setState(( ){
      isLoading = false;
    });
     Navigator.of(context).pop({'data': 'done '}) ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: const Text("Add Post",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(

                    controller: firstController,
                    decoration:
                    const InputDecoration(hintText: "Firstname",
                      hintStyle: TextStyle(fontSize: 17, color: Colors.grey),


                    ) // InputDecoration
                ),
                TextField(
                    controller: lastController,
                    decoration:
                    const InputDecoration(hintText: "Lastname",
                      hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    ) // InputDecoration
                ),
                TextField(
                    controller: contentController,
                    decoration:
                    const InputDecoration(hintText: "Content",
                      hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    ),

                ),
                TextField(
                    controller: dateController,
                    decoration:
                    const InputDecoration(
                        hintText: "Date",
                      hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
                    ) // InputDecoration
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    _createPost();

                  },
                  color: Colors.red,
                  child: const Text(
                    "Create",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}