import 'package:book_review_app/data/book.dart';
import 'package:book_review_app/screens/book_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:book_review_app/env/key.dart' as config;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late TextEditingController txtSearchController;


  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  Future<List<Book>> _getBooks(String category) async {
    http.Response response = await http.get(Uri.parse(
        'https://www.googleapis.com/books/v1/volumes?q=$category+inauthor:keyes&key=${config.apiKey}'));
    var data = response.body;
    var decodedData = json.decode(data);
    List<Book> books = [];
    for (var b in decodedData["items"]) {
      Book book = Book(
          b["volumeInfo"]["title"],
          b["volumeInfo"]["averageRating"],
          b["volumeInfo"]["authors"][0],
          b["volumeInfo"]["imageLinks"]["thumbnail"],
          b["volumeInfo"]["description"]);
      books.add(book);
    }
    return books;
  }

  @override
  void initState() {
    txtSearchController = TextEditingController();
    super.initState();
    _getBooks('best');
    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        //elevation: 0.0,
        title: Center(
          child: Text(
            "App Name",
            style: TextStyle(
              color: Colors.teal[700],
              fontSize: 25.0,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
                  Text('Search book'),
                  Container(
                      padding: EdgeInsets.all(20),
                      width: 200,
                      child: TextField(
                        controller: txtSearchController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (text) {
                        //  _getBooks(text);
                        },
                      )),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () =>
                              _getBooks(txtSearchController.text))),
                ]),

            Flexible(
              child: FutureBuilder(
                  future: _getBooks('novels'),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: Text('loading...'),
                      );
                    } else {
                      return ListView.builder(
                        controller: controller,
                        itemCount: 10,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ListTile(
                          title: Container(
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 7,
                                        offset: Offset(3, 5), // Shadow position
                                      ),
                                    ],
                                  ),
                                  width: 120,
                                  height: 180,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: FittedBox(
                                      fit: BoxFit.none,
                                      child: Image(
                                        image: NetworkImage(
                                            snapshot.data[index].picture),
                                        width: 200,
                                        height: 200,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index].title,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: '',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data[index].author,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: '',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    Text(
                                      '❤' +
                                          snapshot.data[index].rating
                                              .toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: '',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    BookDescription(snapshot.data[index])));
                          },
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
