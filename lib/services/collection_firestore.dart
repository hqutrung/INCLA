import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_helper.dart';

class Collection<T> {
  final Firestore firestore = Firestore.instance;
  final String path;
  CollectionReference reference;

  Collection({this.path}) {
    reference = firestore.collection(path);
  }

  Future<List<T>> getDocuments() async {
    var documents = await reference.getDocuments();
    return documents.documents
        .map((v) => FireStoreHelper.models[T](v.data) as T)
        .toList();
  }

  Stream<List<T>> streamData() {
    var x = reference.snapshots().map((query) => query.documents
        .map((doc) => FireStoreHelper.models[T](doc.data) as T)
        .toList());
    print(x.first);
    return x;
  }
}
