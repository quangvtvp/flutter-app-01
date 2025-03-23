import 'package:flutter/material.dart';

class MyLeaderBoard extends StatelessWidget {
  const MyLeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color.fromARGB(255, 100, 142, 140),
          height: 320,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.indigo,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTVWjggD1lgYIqrSl1ZcsX3MoP3u28PQSwxYJ12SG427O7v9hi-3NVHwPvbo49MfcTofjrnOj7xPwkN_uo6O9QC53jZ5Sum6uLmhbM8kQ'),
                        ),
                      ),
                    ),
                    const Text(
                      "David James",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const Text(
                      "9/10",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.yellow,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTVWjggD1lgYIqrSl1ZcsX3MoP3u28PQSwxYJ12SG427O7v9hi-3NVHwPvbo49MfcTofjrnOj7xPwkN_uo6O9QC53jZ5Sum6uLmhbM8kQ'),
                      ),
                    ),
                    const Text(
                      "David James",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const Text(
                      "9/10",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.indigo,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTVWjggD1lgYIqrSl1ZcsX3MoP3u28PQSwxYJ12SG427O7v9hi-3NVHwPvbo49MfcTofjrnOj7xPwkN_uo6O9QC53jZ5Sum6uLmhbM8kQ'),
                        ),
                      ),
                    ),
                    const Text(
                      "Michael",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const Text(
                      "7/10",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        _buildListView()
      ],
    );
  }

  Expanded _buildListView() {
    return Expanded(
      child: Container(
        color: Colors.grey[200],
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTVWjggD1lgYIqrSl1ZcsX3MoP3u28PQSwxYJ12SG427O7v9hi-3NVHwPvbo49MfcTofjrnOj7xPwkN_uo6O9QC53jZ5Sum6uLmhbM8kQ'),
                  ),
                  title: Text("David James"),
                  trailing: Text("9/10"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTVWjggD1lgYIqrSl1ZcsX3MoP3u28PQSwxYJ12SG427O7v9hi-3NVHwPvbo49MfcTofjrnOj7xPwkN_uo6O9QC53jZ5Sum6uLmhbM8kQ'),
                  ),
                  title: Text("David James"),
                  trailing: Text("9/10"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                          ),
                          child: Text(
                            "3",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTVWjggD1lgYIqrSl1ZcsX3MoP3u28PQSwxYJ12SG427O7v9hi-3NVHwPvbo49MfcTofjrnOj7xPwkN_uo6O9QC53jZ5Sum6uLmhbM8kQ'),
                        ),
                      ],
                    ),
                    title: Text(
                      "David James",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text("9/10"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
