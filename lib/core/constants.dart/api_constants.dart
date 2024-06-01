import 'package:hive/hive.dart';

String? token = '';
String? id = '';
const kTokenBoxString = 'token';
var kidBoxString = 'id';
var kTokenBox = Hive.box(kTokenBoxString);
var kidBox = Hive.box(kidBoxString);
