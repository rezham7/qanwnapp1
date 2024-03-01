import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qanwnapp1/rule_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> rules = [

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('قانوونەکان'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 158, 181, 201),
        ),
        backgroundColor: const Color.fromARGB(255, 17, 17, 36),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(23)),
                      child: const TextField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(223, 255, 255, 255),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 10, color: Colors.amber),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 234, 234),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 460,
                child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection('qanun').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: const TextStyle(
                                fontSize: 18, color: Color.fromARGB(255, 126, 86, 86)),
                          ),
                        );

                        // if we got our data
                      } else if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        return ListView.builder(
                          itemCount: snapshot.data?.size ?? 0,
                          itemBuilder: (context, index) {
                            final data = snapshot.data?.docs[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Rules(
                                          text: 'name',
                                          info: 'rulename',
                                          rulesList: const [],
                                          reference: data.reference
                                              .collection('madakan')
                                              .get()),
                                    ));
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                margin: const EdgeInsets.only(bottom: 24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xffEABF4E),
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${data!['name']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              )
         
            ],
          ),
        ),
      ),
    );
  }
}

class RuleCard extends StatelessWidget {
  const RuleCard({super.key, required this.text, required this.onTab});
  final String text;
  final Function() onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xffEABF4E),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
