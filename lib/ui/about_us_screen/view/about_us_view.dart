import 'package:flutter/material.dart';
import 'package:tic_tac_toe/ui/resources/audio_manager.dart';

import '../../resources/app_colors.dart';
import '../../resources/assets_manager.dart';

class TeamMember {
  final String name;

  final String bio;

  final String img;
  final String bioMp3;

  const TeamMember({
    required this.name,
    required this.bio,
    required this.img,
    required this.bioMp3,
  });
}

List<TeamMember> teamList = [
  const TeamMember(
    name: "Youssef Samy Youssef",
    bio: "Embedded System Student at Amit Learning (Group El-Maadi 534)\n"
        "Embedded System member at IEEE BUB SB\n"
        "\nPhone: 01030296141\n"
        "Email: yosefsamy019@gmail.com",
    img: AssetsManager.profileYosef,
    bioMp3: yosefProfileMp3,
  ),
  const TeamMember(
    name: "Ahmed Mamdouh Sarg",
    bio: "Flutter Developer\n"
        "Flutter Head at IEEE BUB SB\n"
        "Computer Science Student at Benha Faculty of Computer Science and Artificial Intelligence\n"
        "\nPhone: 01003557878\n"
        "Email: ahmedmamdouhsarg@gmail.com\n",
    img: AssetsManager.profileAhmed,
    bioMp3: ahmedProfileMp3,
  ),
];

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
      children: teamList.map((item) => _buildCard(item)).toList()..shuffle(),
    );
  }

  Widget _buildCard(TeamMember member) {
    return Builder(builder: (context) {
      return SizedBox(
        width: double.infinity,
// height: 100,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
            onTap: () => _showDialog(context, member),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(member.img),
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
                              member.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context).iconTheme.color),
                            ),
                            Text(
                              member.bio,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Theme.of(context).iconTheme.color),
                            ),
                          ],
                        )),
// const Expanded(flex: 1, child: FlutterLogo()),
                    const Icon(
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

  void _showDialog(BuildContext context, TeamMember member) {
    AudioManager.instance.playProfile(member.bioMp3);

    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: PopScope(
              canPop: true,
              onPopInvoked: (flag) {
                AudioManager.instance.stop();
              },
              child: AlertDialog(
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
                              member.img,
                              width: double.infinity,
                              // height: double.infinity,
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.topCenter,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                member.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        shadows: List.filled(
                                          5,
                                          const Shadow(
                                            color:
                                                AppColors.darkBackgroundColor,
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
                          member.bio,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Theme.of(context).iconTheme.color),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
