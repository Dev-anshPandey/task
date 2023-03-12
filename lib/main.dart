import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var datacommit;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJsonData();
  }

  var data;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        getJsonCommitData(data[index]["name"],index);
                      },
                      child: Card(
                        child: Container(
                          height: 50,
                          width: 100,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Repo name - "),
                                    Text(data[index]["name"]),
                                    // Text(datacommit)
                                  ],
                                )
                              ]),
                        ),
                      ),
                    );
                  })),
    );
  }

  getJsonData() async {
    final response = await http
        .get(Uri.parse("https://api.github.com/users/dev-anshpandey/repos"));
   // print(response.body);
    setState(() {
      isLoading = false;
      data = json.decode(response.body);
      print(response.body);
    });
   
  }

  getJsonCommitData(String repoName,int index) async {
    final response = await http.get(Uri.parse(
        "https://api.github.com/repos/dev-anshpandey/$repoName/commits"));
    print(repoName);
    // isLoading = false;
    setState(() {
          datacommit = json.decode(response.body);
    });
     return  showModalBottomSheet(
      context: context,
          builder: (context) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 200,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        
                        children: [
                          Text("Commit SHA : "),
                          Text(datacommit[0]["sha"]),
                        ],
                      ),
                      Row(
                       
                        children: [
                           Text("Commit Url : "),
                          Text(datacommit[0]["url"]),
                        ],
                      ),
                       Row(
                       
                        children: [
                           Text("Commit Node_id : "),
                          Text(datacommit[0]["node_id"]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
    );
  }
}



















