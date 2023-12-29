// ignore_for_file: camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class courtDetail extends StatefulWidget {
  final String name;
  final String url;
  final String address;
  final String about;
  const courtDetail({super.key, required this.name, required this.url, required this.address, required this.about});

  @override
  State<courtDetail> createState() => _courtDetailState();
}

class _courtDetailState extends State<courtDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("name"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_circle_right_outlined))
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              // decoration: BoxDecoration(
              //     border: Border.all(
              //         width: 5,
              //         color: Colors.blueAccent)),
              height: 100,
              width: 100,
              // child: Image.network(
              //   data!['url'],
              //   fit: BoxFit.cover,
              // ),
              child: CachedNetworkImage(
                imageUrl: widget.url,
                imageBuilder: (context, imageProvider) => Container(
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
          
            Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.only(top: 30, right: 20),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    color: Colors.blue,
                    child: const Icon(
                      Icons.person,
                      size: 30,
                    ),
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.only(top: 30, right: 20),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    color: Colors.blue,
                    child: const Icon(
                      Icons.location_on_outlined,
                      size: 30,
                    ),
                  ),
                  Text(
                    widget.address,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
