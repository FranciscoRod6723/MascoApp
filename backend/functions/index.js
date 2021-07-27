const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

exports.addLike = functions.firestore.document("/post/{postId}/likes/{userId}")
    .onCreate((snap, context) => {
      return db
          .collection("post")
          .doc(context.params.postId)
          .update(
              {
                likesCount: admin.firestore.FieldValue.increment(1),
              });
    });

exports.delLike = functions.firestore.document("/post/{postId}/likes/{userId}")
    .onDelete((snap, context) => {
      return db
          .collection("post")
          .doc(context.params.postId)
          .update(
              {
                likesCount: admin.firestore.FieldValue.increment(-1),
              });
    });

exports.addSh = functions.firestore.document("/post/{postId}/sharring/{userId}")
    .onCreate((snap, context) => {
      return db
          .collection("post")
          .doc(context.params.postId)
          .update(
              {
                sharringCount: admin.firestore.FieldValue.increment(1),
              });
    });

exports.delSh = functions.firestore.document("/post/{postId}/sharring/{userId}")
    .onDelete((snap, context) => {
      return db
          .collection("post")
          .doc(context.params.postId)
          .update(
              {
                sharringCount: admin.firestore.FieldValue.increment(-1),
              });
    });

