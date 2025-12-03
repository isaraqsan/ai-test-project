

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;











class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDNUEbc9KiT-IeVs9IKwVgHA4Qgtc1Bcw',
    appId: '1:356431257956:android:06f713ede4fb048a7cda71',
    messagingSenderId: '356431257956',
    projectId: 'ai-test-project-b4416',
    storageBucket: 'ai-test-project-b4416.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIy8lzoDSrtyxeu6gqkOzvJLwLOkM7nec',
    appId: '1:356431257956:ios:f2a2c4118e8f2b337cda71',
    messagingSenderId: '356431257956',
    projectId: 'ai-test-project-b4416',
    storageBucket: 'ai-test-project-b4416.firebasestorage.app',
    iosBundleId: 'id.act.dapvmc',
  );
}
