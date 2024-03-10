import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<CachedNetworkImageProvider> profileImageProvider = Provider((ref) {
  return CachedNetworkImageProvider(
      FirebaseAuth.instance.currentUser!.photoURL!);
});
