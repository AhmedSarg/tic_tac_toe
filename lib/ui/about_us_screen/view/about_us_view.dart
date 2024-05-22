import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        title: const Text("About US"),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        _buildCard(
            "Youssef Samy Youssef",
            "Embedded System Student at Amit Learning(Maadi 534)\n"
                " & Embedded Member at IEEE BUB SB\n\n"
                "Phone: 01030296141"),
        _buildCard("Ahmed", "Flutter Head at IEEE BUB SB"),
      ]..shuffle(),
    );
  }

  Widget _buildCard(String name, String bio) {
    return Builder(builder: (context) {
      return SizedBox(
        width: double.infinity,
        // height: 100,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.person,
                        size: 30,
                      )),
                  const VerticalDivider(
                    indent: 2,
                    endIndent: 2,
                  ),
                  // SizedBox(width: 8,),
                  Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context).iconTheme.color),
                          ),
                          Text(
                            bio,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Theme.of(context).iconTheme.color),
                          ),
                        ],
                      )),
                  // const Expanded(flex: 1, child: FlutterLogo()),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
