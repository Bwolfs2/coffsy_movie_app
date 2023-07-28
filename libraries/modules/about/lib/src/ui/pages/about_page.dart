import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';

import '../widgets/about_header/about_header.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          const AboutHeader(),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: PhysicalModel(
              elevation: 8,
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                      bottom: 20,
                    ),
                    child: Text(
                      'My Portfolio',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  CardPortfolio(
                    imageAsset: ImagesAssets.linkedIn,
                    title: 'LinkedIn',
                    url: UrlConstant.urlLinkedIn,
                  ),
                  CardPortfolio(
                    imageAsset: ImagesAssets.github,
                    title: 'GitHub',
                    url: UrlConstant.urlGitHub,
                  ),
                  CardPortfolio(
                    imageAsset: ImagesAssets.resume,
                    title: 'Resume',
                    url: UrlConstant.urlResume,
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
