import 'dart:async';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';

// void main() {
//   Directory dir = Directory("images");
//   final list = dir.listSync();
//   for (var i = 0; i < list.length; i++) {
//     print(list[i].path.split('images\\').last.split(".svg"));
//   }
// }

Future<dynamic> main(final context) async {
  final client = Client()
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'])
      .setKey(Platform.environment['APPWRITE_API_KEY']);

  final Databases db = Databases(client);
  final storage = Storage(client);
  final databaseId = Platform.environment["DATABASE_ID"] as String;
  final soundCollection = "sounds";
  final alphabetCollection = "alphabets";
  final exampleCollection = "examples";

  final file = File("word_db.csv");
  if (await file.exists()) {
    final List<String> lines = await file.readAsLines();
    late String soundDocumentId;
    late String alphabetDocumentId;
    final List<String> alphabetIds = [];
    final List<String> exampleIds = [];
    for (int i = 0; i < lines.length; i++) {
      final [soundType, description, alpha, exType, exName, alphaDesc] =
          lines[i].split(",");

      if (i == 0 || soundType != lines[i - 1].split(",").first) {
        if (i != 0) {
          await db.updateDocument(
              databaseId: databaseId,
              collectionId: soundCollection,
              documentId: soundDocumentId,
              data: {"alphabet_ids": alphabetIds});
          alphabetIds.clear();
        }

        soundDocumentId = await db.createDocument(
            databaseId: databaseId,
            collectionId: soundCollection,
            documentId: ID.unique(),
            data: {
              "sound_type": soundType,
              "description": description,
            }).then((value) => value.$id);
      }

      if (i == 0 || alpha != lines[i - 1].split(",")[2]) {
        if (i != 0) {
          await db.updateDocument(
              databaseId: databaseId,
              collectionId: soundCollection,
              documentId: soundDocumentId,
              data: {"example_ids": exampleIds});
          exampleIds.clear();
        }

        Directory alphaAudioDir = Directory("alphaAudios");
        String? alphaAudioId;
        if (await alphaAudioDir.exists()) {
          for (var data in alphaAudioDir.listSync()) {
            final fileName = data.path.split('alphaAudios\\').last;
            if (fileName.split(".mp3").first.contains(exName)) {
              alphaAudioId = await storage
                  .createFile(
                      bucketId: "alphabetsound",
                      fileId: ID.unique(),
                      file: InputFile.fromPath(
                          path: data.path,
                          filename: fileName))
                  .then((value) => value.$id);
            }
          }
        }

        alphabetDocumentId = await db.createDocument(
            databaseId: databaseId,
            collectionId: alphabetCollection,
            documentId: ID.unique(),
            data: {
              "name": alpha,
              "description": alphaDesc,
              "sound_id": alphaAudioId
            }).then((value) => value.$id);
        alphabetIds.add(alphabetDocumentId);

        Directory dir = Directory("images");
        String? imgId;
        if (await dir.exists()) {
          for (var data in dir.listSync()) {
            final fileName = data.path.split('images\\').last;
            if (fileName.split(".svg").first.contains(exName)) {
              imgId = await storage
                  .createFile(
                      bucketId: "exampleimage",
                      fileId: ID.unique(),
                      file: InputFile.fromPath(
                          path: data.path,
                          contentType: "image/svg",
                          filename: fileName))
                  .then((value) => value.$id);
            }
          }
        }

        Directory audioDir = Directory("audio");
        String? audioId;
        if (await audioDir.exists()) {
          for (var data in audioDir.listSync()) {
            final fileName = data.path.split('audio\\').last;
            if (fileName.split(".mp3").first.contains(exName)) {
              audioId = await storage
                  .createFile(
                      bucketId: "examplesound",
                      fileId: ID.unique(),
                      file: InputFile.fromPath(
                          path: data.path,
                          filename: fileName))
                  .then((value) => value.$id);
            }
          }
        }
        final examplesData = await db.createDocument(
            databaseId: databaseId,
            collectionId: exampleCollection,
            documentId: ID.unique(),
            data: {
              "name": exName,
              "type": exType.toUpperCase(),
              "img_id": imgId,
              "sound_id": audioId
            });
        exampleIds.add(examplesData.$id);
      }
      // You can log messages to the console
      context.log('Document Added');
    }

    // res.json() is a handy helper for sending JSON
    return context.res.json({
      'message': 'Task Completed Successfully',
      'Sounds': (await db.listDocuments(
              databaseId: databaseId, collectionId: soundCollection))
          .documents
          .length,
      'Examples': (await db.listDocuments(
              databaseId: databaseId, collectionId: exampleCollection))
          .documents
          .length,
      'Alphabets': (await db.listDocuments(
              databaseId: databaseId, collectionId: alphabetCollection))
          .documents
          .length,
    });
  } else {
    context.error("File Doesn't Exists");
  }
}