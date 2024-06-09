import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMEthods {
  addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  addFood(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("foods")
        .add(userInfoMap);
  }
}
