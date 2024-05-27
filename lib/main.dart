import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // permission audio
            ListTile(
              title: const Text('Mic Permission'),
              subtitle: const Text('Status of permission'),
              leading: const CircleAvatar(
                child: Icon(Icons.mic),
              ),
              onTap: () async {
                final status = await Permission.microphone.request();

                if (status.isGranted) {
                  print('Permission granted');
                }

                if (status.isDenied) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('This permission is recommended'),
                    ),
                  );
                }

                if (status.isPermanentlyDenied) {
                  openAppSettings();
                }
              },
            ),
            // permssion camera
            ListTile(
              title: const Text('Camera Permission'),
              subtitle: const Text('Status of permission'),
              leading: const CircleAvatar(
                child: Icon(Icons.camera),
              ),
              onTap: () async {
                final cameraStatus = await Permission.camera.request();

                if (cameraStatus == PermissionStatus.granted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Permission camera granted'),
                    ),
                  );
                }

                if (cameraStatus == PermissionStatus.denied) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('You need provide permission to access camera'),
                    ),
                  );
                }

                if (cameraStatus == PermissionStatus.permanentlyDenied) {
                  openAppSettings();
                }
              },
            ),
            // permission storage external
            ListTile(
              title: const Text('Storage Permission'),
              subtitle: const Text('Status of permission'),
              leading: const CircleAvatar(
                child: Icon(Icons.storage),
              ),
              onTap: () async {
                final storageStatus = await Permission.storage.request();

                if (storageStatus == PermissionStatus.granted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Permission storage granted'),
                    ),
                  );
                }

                if (storageStatus == PermissionStatus.denied) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('You need provide permission to access storage'),
                    ),
                  );
                }

                if (storageStatus == PermissionStatus.permanentlyDenied) {
                  openAppSettings();
                }
              },
            ),
            // permission all permission
            ListTile(
              title: const Text('All Permission'),
              subtitle: const Text('Status of All permission'),
              leading: const CircleAvatar(
                child: Icon(Icons.apps),
              ),
              onTap: () async {
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.camera,
                  Permission.microphone,
                  Permission.storage,
                ].request();

                debugPrint(statuses.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
