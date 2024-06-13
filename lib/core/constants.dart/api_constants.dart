import 'package:hive/hive.dart';

String? token = '';
String? id = '';
String? role = '';
List<dynamic>? touristApplications = [];
const kTokenBoxString = 'token';
const kRoleBoxString = 'role';
var kidBoxString = 'id';
var kTouristApplicationsBoxString = 'touristApplications';
var kTokenBox = Hive.box(kTokenBoxString);
var kRoleBox = Hive.box(kRoleBoxString);
var kidBox = Hive.box(kidBoxString);
var kTouristApplicationsBox = Hive.box(kTouristApplicationsBoxString);
