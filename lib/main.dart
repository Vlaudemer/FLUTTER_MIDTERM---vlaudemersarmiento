import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;

  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Vlaudemer Sarmiento', 'Basista, Pangasinan', 'March 21, 2002',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t39.30808-6/316662549_3388334698110105_8882816377013829642_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=174925&_nc_eui2=AeG7pu4R-igmiFrlpq8gr-cUntuJ65Ad7yqe24nrkB3vKoVV8TRMBVrUo_IiI5-fU3x9ms66xdeZ1lV9GnQJeCZF&_nc_ohc=DlJwQS2j8ogAX9nGA33&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfAcMsOO6w8LB1RkZoyo09AD2P748EX3Rwprs35psk61jw&oe=645157F2'),
    Person('Giffy Sarmiento', 'Basista, Pangasinan', 'february 11, 2006',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-1/331421158_516221980596592_6824003371705025678_n.jpg?stp=cp6_dst-jpg_p320x320&_nc_cat=105&ccb=1-7&_nc_sid=f67be1&_nc_eui2=AeFMsbvnZVbRIAe4BrwR6o-psjmJ4THnRu2yOYnhMedG7WrudSJBR-OIhAwGx4W8kip3DsxQNaum4rpNIzMvte3n&_nc_ohc=h66keykwVZAAX_ZTDFi&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfA62BtwKka7U7N-vraVNsdaBpmkmYrBAA_hcCTAQUC6wA&oe=6450DA59'),
    Person('Ekong  Sarmiento ', 'Basista, Pangasinan', 'June 7, 2000',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/337160719_1245172816377575_8918027838237155243_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=174925&_nc_eui2=AeG_5hl1es6eUm5HbL4_g_u2l6Pxw2DEJyOXo_HDYMQnIwxA5ZJ5EJNR9lJvQLtOY0SZJktJIH034yNi60Z4NXsh&_nc_ohc=zgGUdueUUjwAX9QElTm&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfB4zyIcNrQIq-XghBx8DN5EXCrKuU-XEfaT5U-Y3NJ2HA&oe=644F944C'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sarmiento_Vlaudemer_MidtermExam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tit.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 5, 5),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 21, 12, 12),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Color.fromARGB(255, 22, 21, 21),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
