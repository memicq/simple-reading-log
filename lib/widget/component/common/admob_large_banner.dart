import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobLargeBanner extends StatelessWidget {
  AdmobLargeBanner({Key? key}) : super(key: key);

  final BannerAd bannerAd = BannerAd(
    size: AdSize.fullBanner,
    adUnitId: "ca-app-pub-3940256099942544/2934735716",
    listener: const BannerAdListener(),
    request: const AdRequest(),
  );

  @override
  Widget build(BuildContext context) {
    bannerAd.load();

    return Container(
      alignment: Alignment.center,
      child: AdWidget(ad: bannerAd),
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
    );
  }
}
