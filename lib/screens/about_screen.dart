import 'package:chatgptapp/constants/constants.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xEBEAEFD0),
      appBar: AppBar(
        backgroundColor: scaffoldBgColor,
        elevation: 0,
        title: const Text('Programmer Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 125.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 120.0,
                backgroundImage: NetworkImage(
                    'https://png.pngtree.com/png-vector/20190321/ourlarge/pngtree-vector-users-icon-png-image_856952.jpg'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Ahmed Hammad',
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Mobile Developer',
              style: TextStyle(fontSize: 20.0, color: Colors.green),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
                title: Text(
                  '+972 599 742 821',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                title: Text(
                  'eng.ahammad@gmail.com',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
