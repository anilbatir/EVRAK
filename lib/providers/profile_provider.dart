import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/teacher_profile.dart';

class ProfileProvider extends ChangeNotifier {
  static const _keyTeacher = 'teacherProfile';
  static const _keySchool = 'schoolProfile';

  TeacherProfile teacher = const TeacherProfile();
  SchoolProfile school = const SchoolProfile();
  bool isReady = false;

  Map<String, String> get variableMap => {
        ...teacher.toVariableMap(),
        ...school.toVariableMap(),
      };

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final teacherJson = prefs.getString(_keyTeacher);
    final schoolJson = prefs.getString(_keySchool);
    if (teacherJson != null) {
      teacher = TeacherProfile.fromJson(jsonDecode(teacherJson) as Map<String, dynamic>);
    }
    if (schoolJson != null) {
      school = SchoolProfile.fromJson(jsonDecode(schoolJson) as Map<String, dynamic>);
    }
    isReady = true;
    notifyListeners();
  }

  Future<void> save({TeacherProfile? teacher, SchoolProfile? school}) async {
    if (teacher != null) this.teacher = teacher;
    if (school != null) this.school = school;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyTeacher, jsonEncode(this.teacher.toJson()));
    await prefs.setString(_keySchool, jsonEncode(this.school.toJson()));
  }
}
