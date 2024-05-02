import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/models/comment.dart';
import 'package:plant_app/services/user_provider.dart';
import 'package:provider/provider.dart';

class ApiService {
  static String baseUrl = 'https://plant-app-dev-422020.ey.r.appspot.com';

  // GET ALL POSTS
  Future<Map<String, dynamic>> getAllPosts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.userId;
    print(userId);
    final response =
        await http.get(Uri.parse('$baseUrl/posts/?userId=$userId'));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(utf8.decode(response.bodyBytes));
      return decodedJson['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  // GET POST BY ID
  Future<Map<String, dynamic>> getPostById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$id'));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(utf8.decode(response.bodyBytes));
      return decodedJson['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  // LIKE POST
  Future<void> likePost(int id, BuildContext context) async {
    // Retrieve the userProvider using the context provided
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final response = await http.post(
      Uri.parse('$baseUrl/posts/$id/likes'),
      headers: {
        'Authorization':
            'Bearer $token', // Include the auth token in the header
      },
    );

    if (response.statusCode != 204) {
      throw Exception(
          'Failed to load data with status code: ${response.statusCode}');
    }
  }

  // GET COMMENTS
  Future<List<Comment>> getComments(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$id/comments'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data != null && data['comments'] != null) {
        List<dynamic> commentsJson = data['comments'];
        return commentsJson
            .map<Comment>((json) => Comment.fromJson(json))
            .toList();
      } else {
        return <Comment>[]; // Return an empty list if there's no 'comments' key
      }
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // POST COMMENT
  Future<void> postComment(int id, BuildContext context, String text) async {
    // Retrieve the userProvider using the context provided
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final response = await http.post(
      Uri.parse('$baseUrl/posts/$id/comments'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'text': text}),
    );

    // Consider handling other successful status codes or using a range check
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception(
          'Failed to post comment with status code: ${response.statusCode}');
    }
  }
}
