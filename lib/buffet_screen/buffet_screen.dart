import 'package:flutter/material.dart';

import 'card_widget.dart';

class BuffetScreen extends StatefulWidget {
  const BuffetScreen({super.key});

  @override
  State<BuffetScreen> createState() => _BuffetScreenState();
}

class _BuffetScreenState extends State<BuffetScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int index=0;

  final List<Map<String, String>> chips = [
    {'name': 'بوشار منكه', 'price': 'SYP 3500', 'image': 'asset/images/Cornello.jpeg'},
    {'name': 'شيبس طبيعي', 'price': 'SYP 5000', 'image': 'asset/images/Arabica.jpeg'},
  ];

  final List<Map<String, String>> drinks = [
    {'name': 'كابتشينو', 'price': 'SYP 5000', 'image': 'asset/images/cappuccino.jpeg'},
    {'name': '1in3', 'price': 'SYP 4000', 'image': 'asset/images/3in1.jpeg'},
    {'name': 'شاي', 'price': 'SYP 4000', 'image': 'asset/images/tea.jpeg'},
    {'name': 'قهوة', 'price': 'SYP 4000', 'image': 'asset/images/coffe.jpeg'},
    {'name': 'اندومي', 'price': 'SYP 7000', 'image': 'asset/images/indmie.jpeg'},
    {'name': 'بيبسي', 'price': 'SYP 6500', 'image': 'asset/images/pepsi.jpeg'},
    {'name': 'سفن اب', 'price': 'SYP 6500', 'image': 'asset/images/7up.jpeg'},
    {'name': 'كولا تنك', 'price': 'SYP 8000', 'image': 'asset/images/sampiro.jpeg'},
    {'name': 'عصير طبيعي', 'price': 'SYP 6000', 'image': 'asset/images/pepsi1.jpeg'},
    {'name': 'عصير غازي منكه', 'price': 'SYP 6000', 'image': 'asset/images/sampiro.jpeg'},
  ];

  final List<Map<String, String>> hookahs = [
    {'name': 'اركيلة تفاحتين', 'price': 'SYP 11000', 'image': 'asset/images/apple.jpeg'},
    {'name': 'اركيلة بولو', 'price': 'SYP 11000', 'image': 'asset/images/polo.jpeg'},
  ];

  final List<Map<String,String>> biscuit=[
  {'name': 'شانكي بركات', 'price': 'SYP 4000', 'image': 'asset/images/chunky.jpeg'},
  {'name': 'فولت بركات', 'price': 'SYP 4000', 'image': 'asset/images/vault.jpeg'},
  {'name': 'معمول تمر', 'price': 'SYP 2500', 'image': 'asset/images/mamulTammer.jpeg'},
  {'name': 'معمول جوز', 'price': 'SYP 4000', 'image': 'asset/images/mamulGoaez.jpeg'},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Text(
              "Buffet",
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 40),
          TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            labelStyle: const TextStyle(
              fontSize: 16,
            ),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Drinks'),
              Tab(text: 'Biscuit'),
              Tab(text: 'Chips'),
              Tab(text: 'Hookahs'),
            ],
            onTap: (value) {
              setState(() {
                index=value;
              });
            },
          ),
          if(index==0)
            CardCustom(items: drinks),
          if(index==1)
            CardCustom(items: biscuit),
          if(index==2)
            CardCustom(items: chips),
          if(index==3)
            CardCustom(items: hookahs),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
