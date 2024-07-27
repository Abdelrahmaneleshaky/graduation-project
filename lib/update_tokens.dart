import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateTokens({required String imageUrl, required int chosenTokens, required List<dynamic> products, required int index}) async {
  try
  {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products') // Replace with your collection name
        .where('imageURL', isEqualTo: imageUrl)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      String docId = documentSnapshot.id;

      int currentToken = documentSnapshot['token'];

      await FirebaseFirestore.instance
          .collection('products')
          .doc(docId)
          .update({'token': currentToken - chosenTokens});

      print('Document updated successfully');
    } else {
      print('No document found with the provided imageUrl');
    }
  } catch (e) {
    print('Error updating document: $e');
  }
}