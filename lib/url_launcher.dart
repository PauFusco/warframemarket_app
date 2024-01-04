import 'package:url_launcher/url_launcher.dart';

openUrl(url) async {
   final Uri urlToOpen = Uri.parse(url);
   if (!await launchUrl(urlToOpen)) {
        throw Exception('Could not launch $urlToOpen');
    }
}