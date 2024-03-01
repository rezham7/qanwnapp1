// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qanwnapp1/courtDetail.dart';
import 'package:sizer/sizer.dart';

class court extends StatefulWidget {
  const court({super.key});

  @override
  State<court> createState() => _courtState();
}

class _courtState extends State<court> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 740.h,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 800,
            color: const Color.fromARGB(255, 122, 140, 143),
            padding: const EdgeInsets.only(bottom: 15, top: 10),
            child: const Center(
              child: Text(
                'دادگاکان',
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 22, 23, 26),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 68, 53, 53),
            height: 540,
            width: 800,
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('court').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If we got an error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    );

                    // if we got our data
                  } else if (snapshot.hasData) {
                    // Extracting data from snapshot object
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: snapshot.data?.size ?? 0,
                      itemBuilder: (context, index) {
                        final data = snapshot.data?.docs[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => courtDetail(
                                        name: data['name'],
                                        url: data['url'],
                                        address: data['address'],
                                        about: data['about'])));
                          },
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              width: 35.w,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 9, horizontal: 9),
                              margin: EdgeInsets.only(
                                  bottom: 20, right: 5.w, left: 5.w, top: 5.w),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 185, 166, 166),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 133, 113, 62),
                                  width: 5,
                                ),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 2.w),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                        // decoration: BoxDecoration(
                                        //     border: Border.all(
                                        //         width: 5,
                                        //         color: Colors.blueAccent)),
                                        height: 13.h,
                                        width: 120.w,
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
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${data['name']}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
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
