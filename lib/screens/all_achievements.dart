import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frincle_v2/widgets/postcard.dart';

class Allachievements extends StatefulWidget {
  const Allachievements({super.key});

  @override
  State<Allachievements> createState() => _AllachievementsState();
}

class _AllachievementsState extends State<Allachievements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Container(
                child: PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
