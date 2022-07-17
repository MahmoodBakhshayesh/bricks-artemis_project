import 'dart:convert';
import 'dart:io';

String exampleJson(String name) => File('lib/core/examples/$name.json').readAsStringSync();

Map<String,dynamic> example(String name)=> jsonDecode(exampleJson(name));