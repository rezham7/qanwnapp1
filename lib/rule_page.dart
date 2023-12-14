import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  const Rules(
      {super.key,
      required this.text,
      required this.info,
      required this.rulesList,
      required this.reference});
  final String text;
  final String info;
  final Future reference;
  final List rulesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مادەکان'),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Container(
        color: Color.fromARGB(255, 5, 6, 17),
        child: Column(
          children: [
            Container(
              height: 400,
              child: FutureBuilder(
                future: reference,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      return ListView.builder(
                        itemCount: snapshot.data?.size ?? 0,
                        itemBuilder: (context, index) {
                          final data = snapshot.data?.docs[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 0, 0, 0),
                              border:
                                  Border.all(color: Colors.white, width: 0.7),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${data['title']}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                Text(
                                  data['content']!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  textAlign: TextAlign.right,
                                ),
                              ],
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
            //     itemCount: rulesList.length,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         margin: const EdgeInsets.symmetric(
            //             horizontal: 20, vertical: 10),
            //         padding: const EdgeInsets.all(20),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color: Color.fromARGB(255, 0, 0, 0),
            //           border: Border.all(color: Colors.white, width: 0.7),
            //         ),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Text(
            //               '${rulesList[index]['title']}',
            //               style: const TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 24),
            //             ),
            //             Text(
            //               rulesList[index]['content']!,
            //               style: const TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 20),
            //               textAlign: TextAlign.right,
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // )
          ],
        ),
      )),
    );
  }
}
