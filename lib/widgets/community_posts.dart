import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/screens/create_post_screen.dart';
import 'package:plant_app/screens/post_detail_screen.dart';

class PostPage extends StatefulWidget {
  final String postTitle;
  // final String postSummary;
  final String postBody;
  final int reactsCount;
  // final int viewsCount;
  final String authorName;
  final String authorProfileImage;
  final DateTime postDate;

  PostPage({
    required this.postTitle,
    // required this.postSummary,
    required this.postBody,
    required this.reactsCount,
    // required this.viewsCount,
    required this.authorName,
    required this.authorProfileImage,
    required this.postDate,
  });

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool _expanded = false;
  var allItems = List.generate(50, (index) => 'item $index');
  var items = [];
  var searchHistory = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(queryListener);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(queryListener);
    searchController.dispose();
  }

  void queryListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        items = allItems;
      });
    } else {
      setState(() {
        items = allItems
            .where((e) => e.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> words = widget.postBody.split(' ');
    String displayedText =
        _expanded ? widget.postBody : words.take(25).join(' ');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),

        /// here the desired height
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            "Community",
            style: GoogleFonts.poppins(
              color: Color.fromRGBO(57, 79, 74, 50),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
              child: SizedBox(
                height: 40,
                child: SearchBar(
                  surfaceTintColor: MaterialStateProperty.all(
                      Color.fromRGBO(245, 246, 246, 1)),
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(255, 255, 255, 1)),
                  overlayColor: MaterialStateProperty.all(
                      Color.fromRGBO(240, 239, 237, 1)),
                  shadowColor: MaterialStateProperty.all(
                      Color.fromRGBO(224, 231, 231, 100)),
                  controller: searchController,
                  leading: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                  hintText: 'Search',
                  textStyle: MaterialStateProperty.all(GoogleFonts.poppins(
                    color: Color.fromRGBO(57, 79, 74, 100),
                  )),
                ),
              ),
            ),

            // width: 100,
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 224, 228, 208),
                  spreadRadius: 3,
                  blurRadius: 40,
                  offset: Offset(0, 2),
                ),
              ]),
              width: 100,
              height: 190,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "lib/assets/images/plant.jpeg",
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostDetailPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(),
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 201, 224, 109),
                          Color.fromARGB(255, 218, 242, 168)
                        ],
                        stops: [0.25, 0.75],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(220, 226, 201, 0.498),
                          spreadRadius: 10,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          widget.postTitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Color.fromRGBO(34, 58, 51, 40)),
                        ),
                      ),
                      SizedBox(height: 8),
                      // SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: displayedText,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    if (words.length >
                                        20) // Show "Read More" button if post body has more than 50 words
                                      TextSpan(
                                        text: '...',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    if (words.length >
                                        20) // Show "Read More" button if post body has more than 50 words
                                      TextSpan(
                                        text: ' Read More',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.blue,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PostDetailPage(),
                                              ),
                                            );
                                          },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Text(widget.postSummary),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              NetworkImage(widget.authorProfileImage),
                        ),
                        title: Text(
                          widget.authorName,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color.fromRGBO(34, 58, 51, 50)),
                        ),
                        subtitle: Text(
                            widget.postDate.toLocal().toString().split(' ')[0],
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Color.fromRGBO(34, 58, 51, 50))),
                        trailing: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 246, 247, 226),
                            shadowColor: Color.fromARGB(255, 216, 229, 160),
                          ),
                          icon: Icon(Icons.comment_sharp,
                              color: Color.fromARGB(255, 116, 118, 107)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostDetailPage()),
                            );
                          },
                          label: Text(
                            'Comments',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(116, 124, 122, 1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Builder(
                builder: (context) => CreatePostScreen(),
              ),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 201, 224, 109),
        child: Icon(
          Icons.question_answer_sharp,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}
