import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets_manager.dart';

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
            name: "Youssef Samy Youssef",
            bio: "Embedded System Student at Amit Learning(Maadi 534)\n"
                " & Embedded Member at IEEE BUB SB\n\n"
                "Phone: 01030296141",
            img: AssetsManager.profileYosef),
        _buildCard(
            name: "Ahmed",
            bio: "Flutter Head at IEEE BUB SB",
            img: AssetsManager.profileAhmed),
      ]..shuffle(),
    );
  }

  Widget _buildCard({String name = '', String bio = '', required String img}) {
    return Builder(builder: (context) {
      return SizedBox(
        width: double.infinity,
        // height: 100,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      contentPadding: EdgeInsets.zero,
                      content: SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Image.asset(
                                    img,
                                    width: double.infinity,
                                    // height: double.infinity,
                                    fit: BoxFit.cover,
                                    alignment: FractionalOffset.topCenter,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                              shadows: List.filled(
                                                5,
                                                Shadow(
                                                  color: AppColors
                                                      .darkBackgroundColor,
                                                  blurRadius: 10,
                                                ),
                                              )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                bio,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color:
                                            Theme.of(context).iconTheme.color),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(img),
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
                    Icon(
                      Icons.chevron_right,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
