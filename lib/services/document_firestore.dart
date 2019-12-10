import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_helper.dart';

class Document<T>  {
  final firestore = Firestore.instance;
  final String path;
  DocumentReference reference;

  Document({this.path}) {
    reference = firestore.document(path);
  }

  Future<T> getData() {
    return reference.get().then((v) => FireStoreHelper.models[T](v.data));
  }

  Stream<T> streamData() {
    return reference.snapshots().map((v) => FireStoreHelper.models[T](v.data));
  }
}