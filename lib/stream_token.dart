import 'package:cloud_firestore/cloud_firestore.dart';

String docId = '';

Future<void> streamTokens({required String imageUrl}) async
{
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('products') // Replace with your collection name
      .where('imageURL', isEqualTo: imageUrl)
      .get();

  DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
  docId = documentSnapshot.id;
}