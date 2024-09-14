import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../device_details_screen/device_details_screen.dart';
import '../widget/use_provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List newsImages = [
    Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text(
          'عمرو عدي افضل لاعب بيس في الصالة',
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text(
          'عمار عشي يخسر مرة ثانية من عمرو حيث لاجديد',
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text(
          """عرض خاص 
   سعر الساعة من ال 12 لل 5 ب خمسة الاف
          """,
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    "asset/images/logo.png",
    "asset/images/logo.png",
    "asset/images/logo.png",
    "asset/images/logo.png",
    Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text(
          "اطلب اركيلة والثانية عحساب مراد",
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ];

  // دالة لجلب وتحليل البيانات من ملف JSON
  Future<List<dynamic>> fetchDeviceData() async {
    final response = await http.get(Uri.parse(
        "https://amradi6.github.io/game-and-news-and-buffet/devices.json"));

    if (response.statusCode == 200) {
      // تحليل البيانات من JSON إلى List
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load device data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDeviceData(); // جلب البيانات عند بدء التطبيق
  }

  late Future<Map<String, dynamic>> devices;

  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<UserProvider>(context).userName;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "GOAL!-HOME",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                "مرحبا $userName",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ],
          leading: const Icon(
            Icons.gamepad,
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            CarouselSlider(
              items: newsImages.map((e) {
                return Builder(builder: (context) {
                  if (e.runtimeType == String) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage(e),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: e,
                  );
                });
              }).toList(),
              options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 3000),
                autoPlayCurve: Curves.linearToEaseOut,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: fetchDeviceData(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }

                  final devices = snapshot.data!;

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DeviceDetailsScreen(
                                    deviceName: devices[index]["name"],
                                    games: devices[index]["games"],
                                    imageGame: devices[index]["image"],
                                  ),
                                )),
                            child: Card(
                              color: Colors.grey[850],
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("asset/images/ps4_logo.png"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "PlayStation ${index + 1}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
