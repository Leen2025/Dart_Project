import 'package:dio/dio.dart';
import 'package:leenhw5/models/albums_model.dart';
import 'package:leenhw5/models/photos_model.dart';
import 'package:leenhw5/models/posts_model.dart';
import 'package:leenhw5/models/todo_model.dart';
import 'package:leenhw5/models/user_model.dart';
import 'package:leenhw5/network/network_consent.dart';

class NetworkMethod {
  final _dio = Dio(
    BaseOptions(
      baseUrl: NetworkConsent.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  //for user model
  Future<List<UserModel>> getAllUsers() async {
    final response = await _dio.get(NetworkConsent.usersEndpoint);
    List<UserModel> user = [];
    for (var element in response.data) {
      final object = UserModel.fromMap(element);
      user.add(object);
    }
    return user;
  }

  //for todo model
  Future<List<TodoModel>> getUserTodos(int userId) async {
    final response = await _dio.get(
      NetworkConsent.todosEndpoint,
      queryParameters: {'userId': userId},
    );
    List<TodoModel> todos = [];
    for (var element in response.data) {
      final object = TodoModel.fromMap(element);
      todos.add(object);
    }
    return todos;
  }

  // for post model
  Future<List<PostModel>> getUserPosts(int userId) async {
    final response = await _dio.get(
      NetworkConsent.postEndpoint,
      queryParameters: {'userId': userId},
    );
    List<PostModel> posts = [];
    for (var element in response.data) {
      final object = PostModel.fromMap(element);
      posts.add(object);
    }
    return posts;
  }

  // for album model
  Future<List<AlbumsModel>> getAllAlbums() async {
    final response = await _dio.get(NetworkConsent.albumsEndpoint);
    List<AlbumsModel> albums = [];
    for (var element in response.data) {
      final object = AlbumsModel.fromMap(element);
      albums.add(object);
    }
    return albums;
  }

  // for photos model
  Future<List<PhotosModel>> getAllPhotos() async {
    final response = await _dio.get(NetworkConsent.photosEndpoint);
    List<PhotosModel> photos = [];
    for (var element in response.data) {
      final object = PhotosModel.fromMap(element);
      photos.add(object);
    }
    return photos;
  }
}

