import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:herewegoo/pages/signin_page.dart';
import 'package:herewegoo/service/auth_service.dart';

import '../service/rtdb_service.dart';
import 'create_page.dart';
import 'model/post_model.dart';

class MainPage extends StatefulWidget {
  static const String id = "main_page";
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isLoading = false;
  List<Post> items = [];
  Future _callCreatePage() async {
    Map<String, dynamic> results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const GreatPage();
    }));
    if (results != null && results.containsKey("data")) {
      print(results['data']);
      _apiPostList();
    }
  }
  _apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var list = await RTDBService.getPosts();
    items.clear();
    setState(() {
      items = list;
      isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _apiPostList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("All Posts",style: TextStyle(color: Colors.white),),
        actions: [
          MaterialButton(

            onPressed: () => AuthService.signOutUser(context),
            child: const Icon(Icons.login,color: Colors.white,),
          ),
        ],
      ),
      body: Stack(children: [
        ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            return itemOfPost(items[index]);
          },
        ),
      ],),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        onPressed: () {
          _callCreatePage();
        },
        child: const Icon(Icons.add),
      ),
      );

  }
  Widget itemOfPost(Post post) {
    return  Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
              onPressed: (BuildContext context) {},
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: "Update"),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
              onPressed: (BuildContext context) {},
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: "Update"),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

              Row(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [ Text(
                  post.firstname!,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17),
                ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    post.lastname!,
                    style: const TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17
                    ),
                  ),],
              ),


              Text(
                post.date!,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                post.content!,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),

            ])
          ],
        ),
      ),
    );
  }
}

