import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mascot_app/ExtraComponents/UserServices.dart';
import 'package:mascot_app/objects/post.dart';
import 'package:quiver/iterables.dart';

class PostService{

  List<PostModel> _postListFromSnapshots(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return PostModel(
        id: doc.id,
        text: doc['text'] != null  ? doc['text'] : '',
        creator: doc['creator'] != null ? doc['creator'] : '',
        timestamp: doc['timestamp'] != null ? doc['timestamp'] : Timestamp.now(),
        likesCount: doc['likesCount'] != null ? doc['likesCount'] : 0,
        sharringCount: doc['sharringCount'] != null ? doc['sharringCount'] :0,
        sharring: doc['sharring'] != null ? doc['sharring'] : false,
        originalId: doc['originalId'] != null ? doc['originalId'] : '',
        ref: doc.reference
      );
    }).toList();
  }

  PostModel _postFromSnapshot(DocumentSnapshot snapshot) {
    return snapshot.exists
        ? PostModel(
            id: snapshot.id,
            text: snapshot['text'] != null ? snapshot['text'] : '',
            creator: snapshot['creator'] != null ? snapshot['creator'] : '',
            timestamp: snapshot['timestamp'] != null ? snapshot['timestamp'] : 0,
            likesCount: snapshot['likesCount'] != null ? snapshot['likesCount'] : 0,
            sharringCount: snapshot['sharringCount'] != null ? snapshot['sharringCount'] :0,
            sharring:  snapshot['sharring'] != null ? snapshot['sharring'] : false,
            originalId: snapshot['originalId'] != null ? snapshot['originalId'] : '',
            ref: snapshot.reference
          )
        : null;
  }

  Future savePost(text) async {
    await FirebaseFirestore.instance.collection("post").add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'sharring': false,
      'likesCount': 0,
      'sharringCount': 0,
      'originalId': '',
    });   
  }

  Future likePost(PostModel post, bool current) async {
    if (current) {
      post.likesCount = post.likesCount - 1;
      await FirebaseFirestore.instance
          .collection("post")
          .doc(post.id)
          .collection("likes")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .delete();
    }
    if (!current) {
      post.likesCount = post.likesCount + 1;
      await FirebaseFirestore.instance
          .collection("post")
          .doc(post.id)
          .collection("likes")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({});
    }
  }

  Stream<List<PostModel>> getPostsByUser(uid){
    return FirebaseFirestore.instance.collection("post")
    .where('creator', isEqualTo: uid)
    .snapshots()
    .map(_postListFromSnapshots);
  }

  Future<List<PostModel>> getFeed() async {
    List<String> usersFollowing = await UserServices() //['uid1', 'uid2']
        .getUserFollowing(FirebaseAuth.instance.currentUser.uid);

    var splitUsersFollowing = partition<dynamic>(usersFollowing, 10);

    List<PostModel> feedList = [];

    for (int i = 0; i < splitUsersFollowing.length; i++) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('post')
          .where('creator', whereIn: splitUsersFollowing.elementAt(i))
          .orderBy('timestamp', descending: true)
          .get();

      feedList.addAll(_postListFromSnapshots(querySnapshot));
    }

    feedList.sort((a, b) {
      var adate = a.timestamp;
      var bdate = b.timestamp;
      return bdate.compareTo(adate);
    });

    return feedList;
  }

  Stream<bool> getCurrentUserLike(PostModel post) {
    return FirebaseFirestore.instance
        .collection("post")
        .doc(post.id)
        .collection("likes")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists;
    });
  }

  Future sharerring(PostModel post, bool current) async {
    if (current) {
      post.sharringCount = post.sharringCount  - 1;
      await FirebaseFirestore.instance
          .collection("post")
          .doc(post.id)
          .collection("sharring")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .delete();

      await FirebaseFirestore.instance
          .collection("post")
          .where("originalId", isEqualTo: post.id)
          .where("creator", isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        if (value.docs.length == 0) {
          return;
        }
        FirebaseFirestore.instance
            .collection("post")
            .doc(value.docs[0].id)
            .delete();
      });
      // Todo remove the retweet
      return;
    }
    post.sharringCount = post.sharringCount  + 1;
    await FirebaseFirestore.instance
        .collection("post")
        .doc(post.id)
        .collection("sharring")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({});

    await FirebaseFirestore.instance.collection("post").add({
      'text': '',
      'creator': FirebaseAuth.instance.currentUser.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'sharring': true,
      'originalId': post.id,
      'likesCount': 0,
      'sharringCount': 0,
    });
  }

  Future<PostModel> getPostById(String id) async {
    DocumentSnapshot postSnap =
        await FirebaseFirestore.instance.collection("post").doc(id).get();

    return _postFromSnapshot(postSnap);
  }

   Stream<bool> getCurrentUserSharring(PostModel post) {
    return FirebaseFirestore.instance
        .collection("post")
        .doc(post.id)
        .collection("sharring")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.exists;
    });
  }

  Future<List<PostModel>> getReplies(PostModel post) async {
    QuerySnapshot querySnapshot = await post.ref
        .collection("replies")
        .orderBy('timestamp', descending: true)
        .get();

    return _postListFromSnapshots(querySnapshot);
  }

  Future reply(PostModel post, String text) async {
    if (text == '') {
      return;
    }
    await post.ref.collection("replies").add({
      'text': text,
      'creator': FirebaseAuth.instance.currentUser.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'sharring': false,
      'likesCount': 0,
      'sharringCount': 0,
      'originalId': '',
    });
  }
}