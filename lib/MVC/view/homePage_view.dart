import 'package:crud/MVC/controller/authh.dart';
import 'package:crud/MVC/view/NavigationBar/appbar.dart';
import 'package:crud/MVC/view/NavigationBar/drawer.dart';
import 'package:crud/localization/locales.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlutterLocalization _flutterLocalization;
  // ignore: unused_field
  late String _currentLocale;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Provider.of<UserController>(context).currentUser != null;

    return Scaffold(
      appBar: AppBarr(isLoggedIn: isLoggedIn),
      drawer: const Drawerr(
        selectedIndex: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout(context);
          } else {
            return _buildDesktopLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildCarouselSlider(),
          const SizedBox(height: 20),
          _buildSectionHeader(context, LocaleData.topNews.getString(context)),
          _buildNewsCarousel(),
          const SizedBox(height: 20),
          _buildSectionHeader(context, LocaleData.jobOffers.getString(context)),
          _buildJobListings(context),
          const SizedBox(height: 20),
          _buildSectionHeader(
              context, LocaleData.advertisement.getString(context)),
          _buildAdvertisementSection(),
          const SizedBox(height: 20),
          _buildImpressumSection(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildCarouselSlider(),
                const SizedBox(height: 20),
                _buildSectionHeader(
                    context, LocaleData.topNews.getString(context)),
                _buildNewsCarousel(),
                const SizedBox(height: 20),
                _buildSectionHeader(
                    context, LocaleData.jobOffers.getString(context)),
                _buildJobListings(context),
                const SizedBox(height: 20),
                _buildSectionHeader(
                    context, LocaleData.advertisement.getString(context)),
                _buildAdvertisementSection(),
                const SizedBox(height: 20),
                _buildImpressumSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider() {
    List<Map<String, String>> foodItems = [
      {'image': 'lib/assets/images/BeefSteak.png', 'name': 'Beef Steak'},
      {'image': 'lib/assets/images/ChickenCurry.png', 'name': 'Chicken Curry'},
      {
        'image': 'lib/assets/images/ChickpeaCurry.png',
        'name': 'Chickpea Curry'
      },
      {'image': 'lib/assets/images/FalafelWrap.png', 'name': 'Falafel Wrap'},
      {
        'image': 'lib/assets/images/MargheritaPizza.png',
        'name': 'Pizza Margherita'
      },
      {'image': 'lib/assets/images/QuinoaSalad.png', 'name': 'Quinoa Salat'},
      {
        'image': 'lib/assets/images/Schweinebraten.png',
        'name': 'Schweinebraten'
      },
      {
        'image': 'lib/assets/images/SpaghettiBolognese.png',
        'name': 'Spaghetti Bolognese'
      },
      {'image': 'lib/assets/images/TofuStir.png', 'name': 'Tofu Stir'},
      {
        'image': 'lib/assets/images/VegetableLasagna.png',
        'name': 'Vegetarische Lasagne'
      },
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Für die Ausrichtung des Textes
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), // Abstand um den Text herum
            child: Text(
              LocaleData.hungry
                  .getString(context), //'Hunger?🤔 Dann ist es Zeit für...',
              style: GoogleFonts.amaticSc(
                textStyle: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(height: 400.0, autoPlay: true),
            items: foodItems.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Column(
                      children: [
                        Image.asset(item['image']!, width: 350, height: 350),
                        Text(
                          item['name']!,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0), // Abstand um den Text herum
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Inhalt am rechten Rand ausrichten
              children: [
                Expanded(
                  child: Text(
                    LocaleData.menu.getString(
                        context), // '...mehr dazu in unserem Essensplan. Guten Appetit!',
                    style: GoogleFonts.amaticSc(
                      textStyle: const TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildNewsCarousel() {
    List<Map<String, String>> newsItems = [
      {
        'title': LocaleData.news1.getString(context),
        'details': LocaleData.news1undertext.getString(context),
        'link':
            'https://www.ndr.de/nachrichten/niedersachsen/lueneburg_heide_unterelbe/Lueneburger-Heide-Heidebluetenfest-in-Amelinghausen-startet,heidebluetenfest188.html',
      },
      {
        'title': LocaleData.news2.getString(context),
        'details': LocaleData.news2undertext.getString(context),
        'link':
            'https://www.landeszeitung.de/lokales/lueneburg-lk/polizei-lueneburg-unfaelle-verbrechen-vermisstenmeldungen-aktuelle-meldungen-aus-der-region-09-08-PKIAOUDPHFHN7HHTIBXQB4MUD4.html',
      },
      {
        'title': LocaleData.news3.getString(context),
        'details': LocaleData.news3undertext.getString(context),
        'link':
            'https://www.landeszeitung.de/lokales/lueneburg-lk/weltkatzentag-2024-das-sind-die-knuffigen-vierbeiner-der-lueneburger-VSCLGQVLKNCQDEDTQ6NCKQGAGE.html',
      },
      {
        'title': LocaleData.news4.getString(context),
        'details': LocaleData.news4undertext.getString(context),
        'link':
            'https://www.landeszeitung.de/panorama/regional/metronom-zug-kollidiert-mit-betonplatte-unbekannte-legen-hindernisse-ins-gleis-LFYZYTHSPJH5XGFROKDJ7IREJU.html',
      },
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 8),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: newsItems.map((news) {
        return Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      news['title']!,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      news['details']!,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      child: Text(
                        LocaleData.readMoreHere.getString(context),
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      onTap: () {
                        launch(news['link']!);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildJobListings(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          JobCard(
            title: LocaleData.job1.getString(context),
            details: LocaleData.jobPlace1.getString(context),
            onTap: () => showJobDialog(
              context,
              LocaleData.job1.getString(context),
              LocaleData.job1text.getString(context),
              'https://uvex3.hr4you.org/application/applicantRegisterCvAnalyzerGenerator/upload/1701?page_lang=de',
            ),
          ),
          JobCard(
            title: LocaleData.workingStudent.getString(context) +
                '/' +
                LocaleData.internship.getString(context) +
                ' - Business Excellence | Rheinmetall Waffe Munition GmbH',
            details: LocaleData.jobPlace1.getString(context),
            onTap: () => showJobDialog(
              context,
              LocaleData.workingStudent.getString(context) +
                  '/' +
                  LocaleData.internship.getString(context) +
                  ' - Business Excellence | Rheinmetall Waffe Munition GmbH',
              LocaleData.job2text.getString(context),
              'https://www.rheinmetall.com/de/job/werkstudent__praktikant_business_excellence__m_w_d_/598147',
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () => showMoreJobsDialog(context),
            child: Text(LocaleData.moreJobs.getString(context)),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildAdvertisementSection() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: 500,
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: 500,
                height: 500,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/Party.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleData.summerParty.getString(context),
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: LocaleData.free.getString(context),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 22,
                            ),
                          ),
                          TextSpan(
                            text: LocaleData.shots.getString(context),
                            style: TextStyle(fontSize: 22),
                          ),
                          TextSpan(
                            text: 'DJ KATCH',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                              fontSize: 22,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch('https://www.instagram.com/djkatch/');
                              },
                          ),
                          TextSpan(
                            text: LocaleData.partyText.getString(context),
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 70),
                    Table(
                      children: [
                        TableRow(children: [
                          Text(
                            LocaleData.where.getString(context),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            LocaleData.centralbuilding.getString(context) +
                                ', Lunophara ' +
                                LocaleData.university.getString(context) +
                                ', Lünestraße 2a, 21337 Lüneburg',
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                        TableRow(children: [
                          Text(
                            LocaleData.when.getString(context),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            LocaleData.date.getString(context),
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      LocaleData.prices.getString(context),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Table(
                      children: [
                        TableRow(children: [
                          Text(
                            "Boys",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            '10€ ' + LocaleData.perPerson.getString(context),
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                        TableRow(children: [
                          Text(
                            "Girls",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            '10€ ' +
                                LocaleData.perPerson.getString(context) +
                                ' ' +
                                LocaleData.incl.getString(context) +
                                ' Shot',
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      LocaleData.tickets.getString(context),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpressumSection(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color.fromARGB(255, 60, 95, 123),
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              LocaleData.infoandservice
                  .getString(context), //Informationen&Service
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // Impressum usw Section
            Container(
              color: Color.fromARGB(255, 60, 95, 123),
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(LocaleData.impressum
                            .getString(context)), //Impressum
                        content: Text(LocaleData.impressumText
                            .getString(context)), //Inhalt vom Impressum
                        actions: <Widget>[
                          TextButton(
                            child: Text(LocaleData.close
                                .getString(context)), //schließen
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  LocaleData.impressum.getString(context), //Impressum
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black, // Hyperlink-Farbe
                      decoration: TextDecoration.underline, // unterstrichen
                    ),
                  ),
                ),
              ),
            ),
            // Kontakt Section
            Container(
              color: Color.fromARGB(255, 60, 95, 123),
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            LocaleData.contact.getString(context)), //Kontakt
                        content: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: LocaleData.contactText
                                    .getString(context), // Inhalt vom Kontakt
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(LocaleData.close
                                .getString(context)), //Schließen
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  LocaleData.contact.getString(context), //Kontakt
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black, // Hyperlink-Farbe
                      decoration: TextDecoration.underline, // unterstrichen
                    ),
                  ),
                ),
              ),
            ),
            // Datenschutz Section
            Container(
              color: Color.fromARGB(255, 60, 95, 123),
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(LocaleData.dataProtection
                            .getString(context)), //Datenschutz
                        content: Text(LocaleData.dataProtectionText
                            .getString(context)), //Inhalt vom Datenschutz
                        actions: <Widget>[
                          TextButton(
                            child: Text(LocaleData.close
                                .getString(context)), //Schließen
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  LocaleData.dataProtection.getString(context), //Datenschutz
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black, // Hyperlink-Farbe
                      decoration: TextDecoration.underline, // unterstrichen
                    ),
                  ),
                ),
              ),
            ),
            // Öffnungszeiten Section
            Container(
              color: Color.fromARGB(255, 60, 95, 123),
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(LocaleData.openingHours
                            .getString(context)), //Öffnungszeiten
                        content: Text(LocaleData.openingHoursText
                            .getString(context)), //Inhalt Öffnungszeiten
                        actions: <Widget>[
                          TextButton(
                            child: Text(LocaleData.close
                                .getString(context)), //schließen
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  LocaleData.openingHours.getString(context), //Öffnungszeiten
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black, // Hyperlink-Farbe
                      decoration: TextDecoration.underline,

                      /// unterstrichen
                    ),
                  ),
                ),
              ),
            ),

            // Newsletter Section
            Container(
              color: Color.fromARGB(255, 60, 95, 123),
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController _emailController =
                          TextEditingController();
                      final GlobalKey<FormState> _formKey =
                          GlobalKey<FormState>();

                      return AlertDialog(
                        title: Text(LocaleData.newsletter
                            .getString(context)), //Newsletter
                        content: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                LocaleData.newslettertext
                                    .getString(context), //Inhalt Newsletter
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: LocaleData.email
                                      .getString(context), //Email
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return LocaleData.emailText
                                        .getString(context); //Inhalt Email
                                  }
                                  final emailRegex =
                                      RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                  if (!emailRegex.hasMatch(value)) {
                                    return LocaleData.emailText2.getString(
                                        context); //Email Fehlermeldung
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(LocaleData.submit
                                .getString(context)), //Abschicken
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(LocaleData.newsletterText2
                                          .getString(
                                              context)), //Text nach Abschicken der Email
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          TextButton(
                            child: Text(LocaleData.close
                                .getString(context)), //schließen
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  LocaleData.newsletter.getString(context), //Newsletter
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black, // Hyperlink-Farbe
                      decoration: TextDecoration.underline, // unterstrichen
                    ),
                  ),
                ),
              ),
            ),

            // FAQs Section
            Container(
              color: Color.fromARGB(255, 60, 95, 123),
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('FAQs'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: LocaleData.faqQ1.getString(
                                          context), //'Wie sind die Öffnungszeiten der Mensa?\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqA1.getString(
                                          context), //'Die Mensa ist Montags bis Freitags von 11:00 bis 14:00 Uhr sowie von 16:00 bis 19:00 Uhr geöffnet. Samstags sowie an Sonntagen und vorlesungsfreien Tagen haben wir geschlossen.\n\n',
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqQ2.getString(
                                          context), //'Wo finde ich eure Mensa?\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqA2.getString(
                                          context), //'Sie finden unsere Mensa auf dem Campusgelände der Lunophara Universität Lüneburg. Der genaue Standort ist die Lünestraße 2a, 21337 Lüneburg.\n\n',
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqQ3.getString(
                                          context), //'Welche Zahlungsmittelmethoden werden in der Mensa akzeptiert?\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqA3.getString(
                                          context), //'Wir akzeptieren Bargeld, EC-Karten und alle gängigen Kreditkarten. Außerdem können Sie mit Ihrer Studierendenkarte bezahlen.\n\n',
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqQ4.getString(
                                          context), //'Gibt es in der Mensa vegane oder vegetarische Gerichte?\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqA4.getString(
                                          context), //'Ja, wir bieten sowohl vegetarische, vegane als auch Gerichte mit Fleisch an. Diese sind auf unserem Essensplan gekennzeichnet.\n\n',
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqQ5.getString(
                                          context), //'Kann ich Feedback zur Mensa geben?\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqA5.getString(
                                          context), //'Ja, können Sie, indem Sie unser Online-Feedbackformular auf der Website nutzen. Dafür wählen Sie Ihr Gericht aus und dort können Sie Sterne vergeben sowie ein Kommentar schreiben. Wir freuen uns auf Ihr Feedback!\n\n',
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqQ6.getString(
                                          context), //'Können auch Außenstehende in der Mensa essen?\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqA6.getString(
                                          context), //'Ja, auch Außenstehende können in unserer Mensa essen. Dazu zählen sowohl Gäste als auch Bedienstete. Die jeweiligen Preise entnehmen Sie bitte aus unserem Essensplan.\n\n',
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqQ7.getString(
                                          context), //'Bietet eure Mensa auch Gerichte an, die für Allergiker geeignet sind?\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqA7.getString(
                                          context), //'Unser Essensplan enthält detaillierte Informationen zu den Inhaltsstoffen der einzelnen Gerichte. Wir empfehlen Allergikern, diese Angaben vor dem Kauf sorgfältig zu prüfen.\n\n',
                                    ),
                                    TextSpan(
                                      text: LocaleData.faqMore.getString(
                                          context), //'Falls Sie noch weitere Fragen haben, nutzen Sie gerne unseren Support. Diesen erreichen Sie unter ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: 'support@luenefood.de.\n',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              final TextEditingController
                                                  _emailController =
                                                  TextEditingController();
                                              final TextEditingController
                                                  _messageController =
                                                  TextEditingController();
                                              final TextEditingController
                                                  _usernameController =
                                                  TextEditingController();
                                              final GlobalKey<FormState>
                                                  _formKey =
                                                  GlobalKey<FormState>();

                                              return AlertDialog(
                                                title: Text(LocaleData.formular
                                                    .getString(
                                                        context)), //Formular
                                                content: Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextFormField(
                                                        controller:
                                                            _usernameController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: LocaleData
                                                              .name
                                                              .getString(
                                                                  context), //Name
                                                        ),
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return LocaleData
                                                                .nameText
                                                                .getString(
                                                                    context); // Bitte geben Sie einen Namen ein.
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            _emailController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: LocaleData
                                                              .nameEmail
                                                              .getString(
                                                                  context), //Email
                                                        ),
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return LocaleData
                                                                .emailText
                                                                .getString(
                                                                    context); //'Bitte geben Sie eine E-Mail-Adresse ein.';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: LocaleData
                                                              .subject
                                                              .getString(
                                                                  context), //Betreff
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            _messageController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: LocaleData
                                                              .message
                                                              .getString(
                                                                  context), //Nachricht
                                                        ),
                                                        maxLines: 3,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return LocaleData
                                                                .messageText
                                                                .getString(
                                                                    context); //'Bitte geben Sie eine Nachricht ein.';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                        'Abschicken'),
                                                    onPressed: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        Navigator.of(context)
                                                            .pop();
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              content: Text(LocaleData
                                                                  .messageText2
                                                                  .getString(
                                                                      context)), //'Vielen Dank! Ihre Anfrage wurde erfolgreich gesendet. Unser Support-Team wird sich in Kürze bei Ihnen melden.'),
                                                              actions: <Widget>[],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text(LocaleData.close
                                                        .getString(
                                                            context)), //Schließen
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(LocaleData.close
                                .getString(context)), //Schließen
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'FAQs',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black, // Hyperlink-Farbe
                      decoration: TextDecoration.underline, // unterstrichen
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: const HomePage(),
    theme: ThemeData(
      primarySwatch: Colors.teal,
      textTheme: GoogleFonts.latoTextTheme(),
    ),
  ));
}

class JobCard extends StatelessWidget {
  final String title;
  final String details;
  final VoidCallback onTap;

  const JobCard({
    Key? key,
    required this.title,
    required this.details,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.grey[200],
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              details,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showJobDialog(
    BuildContext context, String title, String details, String link) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(details),
        actions: <Widget>[
          TextButton(
            child: Text(LocaleData.close.getString(context),
                style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(LocaleData.applynow.getString(context)),
            onPressed: () {
              launch(link);
            },
          ),
        ],
      );
    },
  );
}

void showMoreJobsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(LocaleData.moreJobs2.getString(context)),
      content: Container(
        width: double.maxFinite,
        height: 400,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    ListTile(
                      title: Text(LocaleData.job1.getString(context)),
                      subtitle: Text(LocaleData.jobPlace1.getString(context)),
                      onTap: () => showJobDialog(
                        context,
                        LocaleData.job1.getString(context),
                        LocaleData.job1text.getString(context),
                        "https://uvex3.hr4you.org/application/applicantRegisterCvAnalyzerGenerator/upload/1701?page_lang=de",
                      ),
                    ),
                    ListTile(
                      title: Text(
                        LocaleData.workingStudent.getString(context) +
                            '/' +
                            LocaleData.internship.getString(context) +
                            ' Business Excellence | Rheinmetall',
                      ),
                      subtitle: Text(LocaleData.jobPlace1.getString(context)),
                      onTap: () => showJobDialog(
                        context,
                        LocaleData.workingStudent.getString(context) +
                            '/' +
                            LocaleData.internship.getString(context) +
                            ' Business Excellence | Rheinmetall',
                        LocaleData.job2text.getString(context),
                        "https://www.rheinmetall.com/de/job/werkstudent__praktikant_business_excellence__m_w_d_/598147",
                      ),
                    ),
                    ListTile(
                      title: Text(
                        LocaleData.workingStudent.getString(context) +
                            ' (m/w/d) ' +
                            LocaleData.graphicAndDesign.getString(context) +
                            ' | Veolia Towers Hamburg',
                      ),
                      subtitle: Text(LocaleData.jobPlace1.getString(context)),
                      onTap: () => showJobDialog(
                        context,
                        LocaleData.workingStudent.getString(context) +
                            ' (m/w/d) ' +
                            LocaleData.graphicAndDesign.getString(context) +
                            ' | Veolia Towers Hamburg',
                        LocaleData.job3text.getString(context),
                        "https://www.hamburgtowers.de/uber-uns/jobs/",
                      ),
                    ),
                    ListTile(
                      title: Text(
                        LocaleData.workingStudent.getString(context) +
                            ' ' +
                            LocaleData.marketing.getString(context) +
                            ' (m/w/d) ' +
                            ' | Audi Hamburg GmbH',
                      ),
                      subtitle: Text(LocaleData.jobPlace2.getString(context)),
                      onTap: () => showJobDialog(
                        context,
                        LocaleData.workingStudent.getString(context) +
                            ' ' +
                            LocaleData.marketing.getString(context) +
                            ' (m/w/d) ' +
                            ' | Audi Hamburg GmbH',
                        LocaleData.job4text.getString(context),
                        "https://karriere.vgrd-gruppe.de/offer/werkstudent-in-marketing-kommunikat/f6e46e43-74d3-445c-9f16-0a25e9ceeb0f?utm_campaign=google_jobs_apply&utm_source=google_jobs_apply&utm_medium=organic",
                      ),
                    ),
                    ListTile(
                      title: Text(
                        LocaleData.workingStudent.getString(context) +
                            ' ' +
                            LocaleData.inCustomerservce.getString(context) +
                            ' (m/w/d)  | Young Capital',
                      ),
                      subtitle: Text(LocaleData.jobPlace2.getString(context)),
                      onTap: () => showJobDialog(
                        context,
                        LocaleData.workingStudent.getString(context) +
                            ' ' +
                            LocaleData.inCustomerservce.getString(context) +
                            ' (m/w/d)  | Young Capital',
                        LocaleData.job5text.getString(context),
                        "https://www.youngcapital.de/stellenangebote/2950163-werkstudent-im-kundenservice-m-w-d-in-hamburg-bei-check24?utm_campaign=google_jobs_apply&utm_source=google_jobs_apply&utm_medium=organic",
                      ),
                    ),
                    ListTile(
                      title: Text(
                        LocaleData.itConsultant.getString(context) +
                            ' (m/w/d) Customer Support | Workwise',
                      ),
                      subtitle: Text(LocaleData.jobPlace1.getString(context)),
                      onTap: () => showJobDialog(
                        context,
                        LocaleData.itConsultant.getString(context) +
                            ' (m/w/d) Customer Support | Workwise',
                        LocaleData.job6text.getString(context),
                        "https://www.studentjob.de/stellenangebote/3471015-it-berater-m-w-d-customer-support-in-luneburg?utm_campaign=nonpaid&utm_content=&utm_source=job24SJde&utm_medium=feed-nonpaid&utm_term=IT-Trainee",
                      ),
                    ),
                    ListTile(
                      title: Text(
                        LocaleData.workingStudent.getString(context) +
                            ' Sales Administration | Vattenfall',
                      ),
                      subtitle: Text(LocaleData.jobPlace2.getString(context)),
                      onTap: () => showJobDialog(
                        context,
                        LocaleData.workingStudent.getString(context) +
                            ' Sales Administration | Vattenfall',
                        LocaleData.job7text.getString(context),
                        "https://careers.vattenfall.com/global/en/job/REF7320G/Werkstudent-in-Sales-Administration?utm_campaign=google_jobs_apply&utm_source=google_jobs_apply&utm_medium=organic",
                      ),
                    ),
                    ListTile(
                      title: Text(
                        LocaleData.workingStudent.getString(context) +
                            ' (m/w/d) ' +
                            LocaleData.financialSector.getString(context) +
                            ' | GARBE Industrial Real Estate GmbH',
                      ),
                      subtitle: Text(LocaleData.jobPlace2.getString(context)),
                      onTap: () => showJobDialog(
                        context,
                        LocaleData.workingStudent.getString(context) +
                            ' (m/w/d) ' +
                            LocaleData.financialSector.getString(context) +
                            ' | GARBE Industrial Real Estate GmbH',
                        LocaleData.job8text.getString(context),
                        "https://www.xing.com/jobs/hamburg-werkstudent-finanzbereich-123269249?clickid=1e13448607d&ucid=1e13448607d",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(LocaleData.close.getString(context),
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
