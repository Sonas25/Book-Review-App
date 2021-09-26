import 'package:book_review_app/data/book.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class BookDescription extends StatelessWidget {
  final Book bookmodel;
  BookDescription(this.bookmodel);
  Positioned myBook() {
    return Positioned(
      top: 80.0,
      left: 40.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     blurRadius: 2,
          //     offset: Offset(1, 1), // Shadow position
          //   ),
          // ],
        ),
        width: 120,
        height: 190,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image(
            image: NetworkImage(bookmodel.picture),
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple[800],
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 140.0,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(20),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     blurRadius: 10.0,
                      //     offset: Offset(3.0, 0),
                      //   ),
                      // ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        Container(
                          padding: EdgeInsets.only(left: 170.0),
                          child: Column(
                            children: [
                              Text(
                                bookmodel.author,
                                style: GoogleFonts.dancingScript(
                                  textStyle: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                bookmodel.title,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                '❤ ' + bookmodel.rating.toString(),
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 80.0),
                        Text(
                          'Description',
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                bookmodel.description.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            myBook(),
          ],
        ),
      ),
    );
  }
}
