import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qanwnapp/lawyerDetail.dart';

class Lawyer extends StatefulWidget {
  const Lawyer({super.key});

  @override
  State<Lawyer> createState() => _LawyerState();
}

class _LawyerState extends State<Lawyer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 740,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 800,
            color: Colors.cyan,
            padding: EdgeInsets.only(bottom: 15, top: 10),
            child: Center(
              child: Text(
                'lawyers',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            height: 540,
            width: 800,
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('lawyer').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If we got an error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
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
                                    builder: (context) => LawyerDetail(
                                        name: data['name'],
                                        url: data['url'],
                                        address: data['address'],
                                        about: data['about'],
                                        phonenumber: data['phonenumber'])));
                          },
                          child: Directionality(
                            textDirection: TextDirection.rtl,
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
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SizedBox(
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(
                                      //         width: 5,
                                      //         color: Colors.blueAccent)),
                                      height: 70,
                                      width: 70,
                                      // child: Image.network(
                                      //   data!['url'],
                                      //   fit: BoxFit.cover,
                                      // ),
                                      child: CachedNetworkImage(
                                        imageUrl: data!['url'],
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.gavel_outlined),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${data['name']}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${data['address']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }
}
