import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kingmaker/dto/todo_dto.dart';

final dio = Dio();
String? url = dotenv.env['URL'];

class TodoApi{
  final storage = const FlutterSecureStorage();
  Future<List<TodoDto>> getList(int memberId, String date) async{
    dynamic authorization =await storage.read(key:'authorization');
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authorization}",
    };

    try{
      final response = await dio.get(
        '$url/api/todo/list/$memberId?date=$date',
        options: Options(headers: headers),
      );
      print('TodoApi - getList ${response.data}');
      return response.data['data'].map<TodoDto>((memberTodo) {
        return TodoDto.fromJsonToListDto(memberTodo);
      }).toList();
    }catch (e) {
      print(e);
      return [];
    }
  }

  void registTodo(int memberId, TodoDto todoDto) async{
    final response = await dio.post(
      '$url/api/todo',
      data: todoDto.toRegistJson(memberId),
    );
  }

  void modifyTodo(TodoDto todoDto) async{
    final response = await dio.put(
      '$url/api/todo',
      data: todoDto.toModifytJson(),
    );
  }

  void deleteTodo(int todoId) async{
    final response = await dio.delete(
      '$url/api/todo?todoId=$todoId',
    );
  }

  Future<TodoDto> detailTodo(int todoId) async{
    try{
      final response = await dio.get(
        '$url/api/todo/$todoId',
      );
      print(response.data['data']);
      return TodoDto.fromJson(todoId, response.data['data']);
    } catch (e) {
      print(e);
      return {} as TodoDto;
    }
  }

  void achieveTodo(int todoId) async{
    final response = await dio.patch(
      '$url/api/todo/$todoId',
    );
  }
}

