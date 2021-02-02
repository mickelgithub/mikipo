import 'dart:io';

import 'dart:typed_data';
import 'package:collection/collection.dart';

const int CHUNCK_SIZE= 1024;

extension FileExtensions on File {
  Future<bool> byteCompare(File other) async {
    //if the argument is null, then return false
    if (other== null) return false;
    //if length is not equal, so return false
    int myLength= await this.length();
    int otherLength= await other.length();
    print('longitudes son ${myLength} --> ${otherLength}');
    if (myLength!= otherLength) return false;
    RandomAccessFile myraf = await this.open(mode: FileMode.read);
    RandomAccessFile otherraf = await other.open(mode: FileMode.read);
    List<int> mybytes= List(CHUNCK_SIZE);
    List<int> otherbytes= List(CHUNCK_SIZE);
    int mybytesRead= myraf.readIntoSync(mybytes);
    int otherbytesRead= otherraf.readIntoSync(otherbytes);
    while (mybytesRead> 0 && otherbytesRead> 0 ) {
      if (mybytesRead!= otherbytesRead) {
        return false;
      }
      if (!ListEquality().equals(mybytes,otherbytes)) {
        return false;
      }
      mybytes= List(CHUNCK_SIZE);
      otherbytes= List(CHUNCK_SIZE);
      mybytesRead= myraf.readIntoSync(mybytes);
      otherbytesRead= otherraf.readIntoSync(otherbytes);
    }
    if (mybytesRead!= otherbytesRead) {
      return false;
    }
    await myraf.close();
    await otherraf.close();
    return true;
  }
}