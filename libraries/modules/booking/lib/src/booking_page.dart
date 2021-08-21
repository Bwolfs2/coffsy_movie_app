import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookingPage extends StatelessWidget {
  final ScreenArguments arguments;

  const BookingPage({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var _isDarkTheme = themeData.appBarTheme.color == null;

    return Scaffold(
      backgroundColor: !_isDarkTheme ? ColorPalettes.darkPrimary : ColorPalettes.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        // title: Text(args.movies.title ?? args.movies.tvName),
        title: Text(arguments.screenData.title),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(
            Sizes.dp20(context),
          ),
          child: Column(
            children: <Widget>[
              DateWidget(),
              TimeWidget(),
              CinemaWidget(movieBackground: arguments.screenData.backdropPath),
              Padding(
                padding: EdgeInsets.only(
                  top: Sizes.dp20(context),
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
