import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pocketclinic_assignment/resources/constants.dart';
import 'package:pocketclinic_assignment/model/visit.dart';
import 'package:pocketclinic_assignment/resources/urls.dart';

class DataProvider with ChangeNotifier {
  Future<void> handleLoginProcess() async {
    try {
      final dio = Dio();
      var response = await dio.post(
        '$LOGIN_URL',
        data: {'email': 'randal@gmail.com'},
      );
      debugPrint('response: ${response.data}');
      // String responseString = '${response.data}';
      String responseString = '${response.toString()}';
      // responseString = responseString
      //     .replaceAll("{", "{\"")
      //     .replaceAll("}", "\"}")
      //     .replaceAll(":", "\":\"")
      //     .replaceAll(",", "\",\"");
      debugPrint('responseString: $responseString');

      // String accessToken= json.decode(responseString);

      var accessToken = json.decode(responseString);
      debugPrint('accessToken: $accessToken');

      final String accessTokenn = accessToken['accessToken'];
      debugPrint('accessTokenn: $accessTokenn');
      authtoken = accessTokenn;

      // final List<dynamic> responseData = json.decode(response.body);
      // final List<Photo> fetchedPhotos = responseData.map((post) => Photo.fromJson(post)).toList();

      // photos = fetchedPhotos;
      // print('photos length ${photos.length}');
    } catch (error) {
      print(error);
    }
    // return photos;
  }

  void storeFieldInCookie(String field) {}
  static String authtoken = '';

  bool isLoading = false;

  List<Visit>? allVisitsData = [];

  Future<void> getVisits() async {
    isLoading = true;
    allVisitsData = await fetchAllVisits();
    isLoading = false;

    notifyListeners();
  }

  Future<List<Visit>> fetchAllVisits() async {
    debugPrint('fetchAllVisits authtoken: ${authtoken}');

    // try {
    final dio = Dio();
    var response = await dio.get(
      VISITS_URL,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authtoken",
        },
        validateStatus: (_) => true,
      ),
    );
    // if(response.statusCode == 401){
    //   // call your refresh token api here and save it in shared preference
    //   await getToken();
    //   signInData(data);
    // }
    // debugPrint('fetchAllVisits response: ${response.data}');

    // final List<dynamic> responseData = json.decode(response.data);
    var responseData = json.decode(response.toString());
    var visitsData = responseData["data"] as List;

    // debugPrint('fetchAllVisits responseData: ${responseData}');
    debugPrint('fetchAllVisits visitsData length: ${visitsData.length}');

    // final List<Tasks> allVisits = visitsData.map((visit) => Tasks.fromJson(visit['validatedTasksForUser'])).toList();

    List<Visit>? allVisits =
        visitsData.map((visit) => Visit.fromJson(visit)).toList();

    List<Tasks>? validatedTasksForUser = [];

    // allVisits.forEach((visit) {
    //   validatedTasksForUser.add(visit.validatedTasksForUser);
    //
    //   });

    debugPrint('fetchAllVisits allVisits: ${allVisits.length}');

    // String responseString= '${response.data}';

    // responseString = responseString
    //     .replaceAll("{","{\"")
    //     .replaceAll("}","\"}")
    //     .replaceAll(":","\":\"")
    //     .replaceAll(",","\",\"");
    // debugPrint('responseString: $responseString');

    // String accessToken= json.decode(responseString);

    // var accessToken= json.decode(responseString);
    // debugPrint('accessToken: $accessToken');

    // final String accessTokenn=accessToken['accessToken'];
    // debugPrint('accessTokenn: $accessTokenn');

    // final List<dynamic> responseData = json.decode(response.body);
    // final List<Photo> fetchedPhotos = responseData.map((post) => Photo.fromJson(post)).toList();

    // photos = fetchedPhotos;
    // print('photos length ${photos.length}');
    // } catch (error) {
    //   print(error.);
    // }
    // return photos;
    return allVisits;
  }

  int taskMaxLength = 0;

  Map<Tasks, Visit> getAllVisitTasks() {
    Map<Tasks, Visit> visitTasksMap = {};
    List<String> notesList = [];
    // List<Tasks>? allTasks = [];
    // debugPrint('taskCardView ->  visitDataProvider.allVisitsData: ${ visitDataProvider.allVisitsData?.length}');

    allVisitsData?.forEach(
      (visit) {
        if (visit.validatedTasksForUser != null) {
          // allTasks+=visit.validatedTasksForUser!;
          // allTasks.addAll(visit.validatedTasksForUser as Iterable<Tasks>);
          visit.validatedTasksForUser?.forEach((task) {
            visitTasksMap[task] = visit;

            if (task.note != null) {
              int? currentNoteLength = task.task?.length;
              currentNoteLength ??= 0;

              taskMaxLength = max(currentNoteLength, taskMaxLength);
              // debugPrint('getAllVisitTasks noteMaxLength $taskMaxLength');
            }
          });
        }
      },
    );

    return visitTasksMap;
  }

  String appendEmptySpaceToNoteString(String task) {
    // debugPrint('note.length:${task.length} taskMaxLength:${taskMaxLength}');
    while (task.length != taskMaxLength) {
      task += ' ';
    }
    return task;
  }

  Map<Tasks, Visit> getAllPendingVisitTasks() {
    Map<Tasks, Visit> visitTasks = getAllVisitTasks();
    Map<Tasks, Visit> updatedVisitTasks = {};

    visitTasks.forEach((task, visit) {
      if (task.status?.toUpperCase() == PENDING) {
        updatedVisitTasks[task] = visit;
      }
    });
    return visitTasks;
  }

  Map<Tasks, Visit> getAllCompletedVisitTasks() {
    Map<Tasks, Visit> visitTasks = getAllVisitTasks();
    Map<Tasks, Visit> updatedVisitTasks = {};

    visitTasks.forEach((task, visit) {
      if (task.status?.toUpperCase() == COMPLETED) {
        updatedVisitTasks[task] = visit;
      }
    });
    return updatedVisitTasks;
  }

  Map<Tasks, Visit> getTasksAsPerStatus(TaskType taskType) {
    switch (taskType) {
      case TaskType.COMPLETED:
        return getAllCompletedVisitTasks();
      case TaskType.PENDING:
        return getAllPendingVisitTasks();
      case TaskType.ANY:
        return getAllVisitTasks();
      default:
        return getAllVisitTasks();
    }
  }

// List<Photo> _photos = [];
//
// List<Photo> get photos => _photos;

// Future<void> fetchPhotosFromAPI() async{
//   // List<Photo> photos=[];
//   try {
//     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
//     final List<dynamic> responseData = json.decode(response.body);
//     final List<Photo> fetchedPhotos = responseData.map((post) => Photo.fromJson(post)).toList();
//
//     _photos = fetchedPhotos;
//     print('photos length ${photos.length}');
//
//     notifyListeners();
//   } catch (error) {
//     print(error);
//   }
// }
  Future<bool> completeVisitTask(
      String? taskId, String? visitId, String? note) async {
    debugPrint('completeVisitTask authtoken: ${authtoken}');
    bool isTaskCompleted = true;

    try {
      final dio = Dio();
      var response = await dio.post(
        COMPLETE_VISIT_TASK_URL,
        data: {
          'taskId': taskId,
          'visitId': visitId,
          'note': note,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $authtoken",
          },
          // validateStatus: (_) => true,
        ),
      );
      debugPrint('completeVisitTask response: ${response.toString()}');
    } catch (error) {
      print(error);
      isTaskCompleted = false;
    }
    await getVisits();
    return isTaskCompleted;
  }
}

DataProvider apiController = DataProvider();
