import 'package:guide/middleware/auth_middleware.dart';
import 'package:guide/screens/about_screen.dart';
import 'package:guide/screens/emergencyscreen.dart';
import 'package:guide/screens/filterscreen.dart';
import 'package:guide/screens/loginscreen.dart';
import 'package:guide/screens/placecat_screen.dart';
import 'package:guide/screens/review_screen.dart';
import 'package:guide/screens/scaffold.dart';
import 'package:guide/screens/countrypage.dart';
import 'package:get/get.dart';
import 'package:guide/screens/showplace.dart';

import 'package:guide/screens/places_screen.dart';
import 'package:guide/screens/registerscreen.dart';
import 'package:guide/screens/terms_screen.dart';
import 'package:guide/screens/widgets/company/city_companies.dart';
import 'package:guide/screens/widgets/company/company_page.dart';
import 'package:guide/screens/widgets/company/trip_screen.dart';
import 'package:guide/screens/widgets/homescreen/more_advice.dart';
import 'package:guide/screens/widgets/homescreen/more_offers.dart';
import 'package:guide/screens/widgets/profile/change_password.dart';
import 'package:guide/screens/widgets/profile/edit_profile.dart';
import 'package:guide/screens/widgets/profile/merchant/add_images.dart';
import 'package:guide/screens/widgets/profile/merchant/addplace_screen.dart';
import 'package:guide/screens/widgets/profile/merchant/editplace_screen.dart';
import 'package:guide/screens/widgets/profile/merchant/map_picker.dart';
import 'package:guide/screens/widgets/profile/user_bookmark.dart';
import 'package:guide/screens/widgets/profile/user_reviews.dart';

List<GetPage> appRoutes = [
  GetPage(
    name: '/home',
    page: () => const AppScaffold(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/country',
    page: () => const CountryPage(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/login',
    middlewares: [AuthMiddleware()],
    page: () => const LoginPage(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/register',
    middlewares: [AuthMiddleware()],
    page: () => const RegisterPage(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/placecate',
    page: () => const PlaceCatePage(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/places',
    page: () => const PlacesScreen(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/filter',
    page: () => const FilterScreen(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/showplace',
    page: () => const ShowPlace(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/reviewscreen',
    page: () => const ReviewScreen(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/emergency',
    page: () => const EmergencyScreen(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/userreview',
    page: () => const UserReviews(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/userbookmarks',
    page: () => const UserBookmark(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/about',
    page: () => const AboutScreen(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/terms',
    page: () => const TermsScreen(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/editprofile',
    page: () => const EditProfile(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/changepassword',
    page: () => const ChangePassword(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/showadvices',
    page: () => const AdvicePage(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/showoffers',
    page: () => const OffersPage(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/citycompany',
    page: () => const CityCompanyPage(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/companypage',
    page: () => const CompanyPage(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/merchantaddplace',
    page: () => const MerchantAddPlace(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/merchanteditplace',
    page: () => const MerchantEditPlace(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/mappicker',
    page: () => const MapPickerPage(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/addimages',
    page: () => const AddImages(),
    transition: Transition.native,
  ),
  GetPage(
    name: '/tripscreen',
    page: () => const TripScreen(),
    transition: Transition.native,
  ),
];
