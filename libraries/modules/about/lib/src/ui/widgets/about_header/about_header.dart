import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutHeader extends StatelessWidget {
  const AboutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Sizes.dp20(context),
        right: Sizes.dp20(context),

        ///top: Sizes.width(context) / 4,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: Sizes.width(context) / 4.5,
                width: Sizes.width(context) / 4.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(ImagesAssets.profile),
                  ),
                ),
              ),
              SizedBox(width: Sizes.dp20(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Vilson Dauinheimer (Bwolf)',
                      style: TextStyle(
                        fontSize: Sizes.dp28(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: Sizes.dp5(context)),
                    GestureDetector(
                      onTap: () => launchUrl(Uri.parse(UrlConstant.urlInstagram)),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            ImagesAssets.instagram,
                            height: Sizes.dp13(context),
                            width: Sizes.dp13(context),
                          ),
                          SizedBox(width: Sizes.dp10(context)),
                          Text(
                            '@bwolf.dev',
                            style: TextStyle(
                              fontSize: Sizes.dp14(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Sizes.dp30(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '3K',
                    style: TextStyle(
                      fontSize: Sizes.dp26(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Follower',
                    style: TextStyle(
                      fontSize: Sizes.dp16(context),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '2.2k',
                    style: TextStyle(
                      fontSize: Sizes.dp26(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Following',
                    style: TextStyle(
                      fontSize: Sizes.dp16(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
