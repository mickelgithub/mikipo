import 'dart:io';

import 'package:dartz/dartz.dart';

abstract class IAvatarRemoteDatasource {

  Future<String> saveAvatar(String userId, File avatar);
  Future<Tuple2<bool,String>> downloadAvatar(String userId, File fileDestination);


}