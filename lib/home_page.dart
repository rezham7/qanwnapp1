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
    //{
      //'text': 'دەستوور',
      //'info': 'Rule 1 jshdjsds',
      //'rules': [
        //{
          //'title': 'ماددەی١',
         // 'content': "پیک هاتوە لەمشتانە قادگهفژگژزفههگکنکفگدگفهفگدسفسدگ"
       // },
        //{'title': 'title2', 'content': "content2"},
        //{'title': 'title3', 'content': "content3"}
      //]
    //},
    // {
    //   'text': 'قانون',
    //   'info': 'Rule 2 jshdjsds',
    // },
    // {
    //   'text': 'اagwh',
    //   'info': 'Rule 3 jshdjsds',
    // },
    // {
    //   'text': 'Rule 5',
    //   'info': 'Rule 5 jshdjsds',
    // },
    // {
    //   'text': 'Rule 6',
    //   'info': 'Rule 6 jshdjsds',
    // },
    // {
    //   'text': 'Rule 7',
    //   'info': 'Rule 5 jshdjsds',
    // },
    // {
    //   'text': 'Rule 8',
    //   'info': 'Rule 5 jshdjsds',
    // },
    // {
    //   'text': 'Rule ',
    //   'info': 'Rule 5 jshdjsds',
    // },
    // {
    //   'text': 'Rule 5',
    //   'info': 'Rule 5 jshdjsds',
    // },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('قانوونەکان'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: const Color.fromARGB(255, 15, 15, 29),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
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
                          color: Color.fromARGB(255, 148, 143, 143),
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
                height: 400,
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
                                fontSize: 18, color: Colors.white),
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
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: rules.length, //9
              //     itemBuilder: (context, index) {
              //       print('index: $index, text: ${rules[index]['text']}');
              //       return RuleCard(
              //         text: rules[index]['text'],
              //         // text: 'AAA',

              //         onTab: () {
              //           print('onTap');
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => Rules(
              //                 // text: rules[index]['text'],
              //                 // info: rules[index]['info'],
              //                 text: rules[index]['text'],
              //                 info: rules[index]['info'],
              //                 rulesList: rules[index]['rules'],
              //               ),
              //             ),
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
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
