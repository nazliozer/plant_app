import 'package:flutter/material.dart';
import 'package:plant_app/models/post.dart';
import 'package:plant_app/services/api_service.dart';
import 'package:plant_app/widgets/details.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;
  const PostDetailPage({Key? key, required this.postId}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 218, 242, 168),
              Color.fromRGBO(237, 240, 230, 1),
              Color.fromRGBO(236, 237, 228, 1),
              Color.fromRGBO(235, 233, 221, 1),
              Color.fromRGBO(237, 234, 221, 1),
              Color.fromARGB(255, 218, 242, 168)
            ],
            stops: [0.1, 0.25, 0.5, 0.75, 0.8, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder<Map<String, dynamic>>(
          future: ApiService().getPostById(context, widget.postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error.toString()}"));
            } else if (snapshot.hasData) {
              Post post =
                  Post.fromJson(snapshot.data!); // Assuming non-null for demo
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: DetailsWidget(
                    postId: post.id,
                    postTitle: post.title,
                    postBody: post.content,
                    authorName: post.createdByUsername,
                    authorProfileImage: post.authorProfileImage,
                    postDate: post.createdAt,
                    imageUrl: post.imgUrl,
                    isLiked: post.isLiked,
                  ),
                ),
              );
            } else {
              return Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }
}
