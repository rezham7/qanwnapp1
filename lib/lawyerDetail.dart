// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LawyerDetail extends StatefulWidget {
  final String name;
  final String url;
  final String address;
  final String about;
  final String phonenumber;
  const LawyerDetail(
      {super.key,
      required this.name,
      required this.url,
      required this.address,
      required this.about,
      required this.phonenumber});

  @override
  State<LawyerDetail> createState() => _LawyerDetailState();
}

class _LawyerDetailState extends State<LawyerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 120),
                child: const Text('title'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_circle_right_outlined))
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 200,
              width: 70,
              margin: const EdgeInsets.only(top: 30),
              child: CachedNetworkImage(
                imageUrl: widget.url,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover , 
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
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.only(top: 30, right: 20),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    color: Colors.blue,
                    child: const Icon(Icons.phone),
                  ),
                  Text(
                    widget.phonenumber,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 0, 0, 0),
              border: Border.all(color: Colors.white, width: 0.7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.about,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse('tel:${widget.phonenumber}');

              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              color: Colors.blue[700],
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    size: 30,
                  ),
                  Text('Call')
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final Uri url =
                  Uri.parse('whatsapp://send?phone=${widget.phonenumber}');

              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
              color: Colors.green[700],
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    size: 30,
                  ),
                  Text('whatsapp')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
