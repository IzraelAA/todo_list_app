import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<http.Response> getPosts() async {
    return await http.get(Uri.parse(baseUrl));
  }

  Future<http.Response> getPostById(int id) async {
    return await http.get(Uri.parse("$baseUrl/$id"));
  }

  Future<http.Response> createPost(Map<String, dynamic> postData) async {
    return await http.post(Uri.parse(baseUrl), body: postData);
  }

  Future<http.Response> updatePost(int id, Map<String, dynamic> postData) async {
    return await http.put(Uri.parse("$baseUrl/$id"), body: postData);
  }

  Future<http.Response> deletePost(int id) async {
    return await http.delete(Uri.parse("$baseUrl/$id"));
  }
}
