import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject("dhwani");
});
