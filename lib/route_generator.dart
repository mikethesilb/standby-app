import 'package:bash_new/pages/action-page/actionPage.dart';
import 'package:bash_new/pages/listing-search/search_page.dart';
import 'package:bash_new/pages/map/map_page.dart';
import 'package:bash_new/pages/person-profile/person_page.dart';
import 'package:bash_new/pages/person-profile/widgets/Person.dart';
import 'package:bash_new/pages/sign-in/loginPage.dart';
import 'package:flutter/material.dart';

import 'pages/listing/listing_page.dart';
import 'pages/listing/widgets/Listing.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => new LoginPage());

      case '/ActionPage':
        return MaterialPageRoute(builder: (_) => new ActionPage());

      case '/LoginPage':
        return MaterialPageRoute(
            builder: (_) => new LoginPage(
                  key: UniqueKey(),
                  title: "Hey, let's log you in!",
                ));

      case '/SearchPage':
        return MaterialPageRoute(builder: (_) => new SearchPage());

      case '/MapPage':
        return MaterialPageRoute(builder: (_) => new MapPage());

      case '/ListingPage':
        // Validation of correct data type
        if (args is Listing) {
          return MaterialPageRoute(
              builder: (_) => new ListingPage(listing: args));
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      case '/PersonPage':
        // Validation of correct data type
        if (args is Person) {
          return MaterialPageRoute(
              builder: (_) => new PersonPage(person: args));
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
