import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookingPage extends StatelessWidget {
  final ScreenArguments arguments;

  const BookingPage({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final _isDarkTheme = themeData.appBarTheme.backgroundColor == null;

    return Scaffold(
      backgroundColor: !_isDarkTheme ? ColorPalettes.darkPrimary : ColorPalettes.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(arguments.screenData.title),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(
            20,
          ),
          child: Column(
            children: <Widget>[
              const DateWidget(),
              const TimeWidget(),
              CinemaWidget(movieBackground: arguments.screenData.backdropPath),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: CustomButton(
                  text: 'Pay',
                  onPressed: () {
                    SmoothDialog(
                      context: context,
                      path: ImagesAssets.successful,
                      mode: SmoothMode.lottie,
                      content: 'Thanks for your movie ticket order',
                      title: 'Payment Successful!',
                      submit: logEventOnClick(
                        'payment_success',
                        () => Modular.to.navigate('/dashboard/movie_module/'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
