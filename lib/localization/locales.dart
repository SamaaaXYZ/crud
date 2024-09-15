import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

ValueNotifier<String> isEnglishNotifier = ValueNotifier<String>("en");

const List<MapLocale> LOCALES = [
  MapLocale("en", LocaleData.EN),
  MapLocale("de", LocaleData.DE),
];

mixin LocaleData {
  static const String moreHere = 'moreHere';
  static const String searchBar = 'searchBar';
  static const String mealPlan = 'mealPlan';
  static const String mealList = 'mealList';
  static const String homePage = 'homePage';
  static const String dayOfWeek1 = 'dayOfWeek1';
  static const String dayOfWeek2 = 'dayOfWeek2';
  static const String dayOfWeek3 = 'dayOfWeek3';
  static const String dayOfWeek4 = 'dayOfWeek4';
  static const String dayOfWeek5 = 'dayOfWeek5';
  static const String weekText = 'weekText';
  static const String price = 'price';
  static const String type = 'type';
  static const String noMealPlanned = 'noMealPlanned';
  static const String login = 'login';
  static const String password = 'password';
  static const String back = 'back';
  static const String reviewLabel = 'reviewLabel';
  static const String noReviewsYet = 'noReviewsYet';
  static const String addReview = 'addReview';
  static const String addAReview = 'addAReview';
  static const String review = 'Review';
  static const String loginToAddReview = 'loginToAddReview';
  static const String takePhoto = 'takePhoto';
  static const String cancel = 'cancel';
  static const String submit = 'submit';
  static const String editMeal = 'editMeal';
  static const String nameEnglish = 'nameEnglish';
  static const String nameGerman = 'nameGerman';
  static const String typeEnglish = 'typeEnglish';
  static const String typeGerman = 'typeGerman';
  static const String changePicture = 'changePicture';
  static const String save = 'save';
  static const String addMealToWeek = 'addMealToWeek';
  static const String add = 'add';
  static const String news1 = 'lüneburgerHeath';
  static const String news1undertext = 'startingonSaturday';
  static const String news2 = 'policeTicker';
  static const String news2undertext = 'whetherItsTraffic';
  static const String news3 = 'worldCatDay';
  static const String news3undertext = 'doYouLikeTakingSnapshots';
  static const String news4 = 'metronomTrainCollides';
  static const String news4undertext = 'onTheMetronom';
  static const String readMoreHere = 'readMoreHere';
  static const String job1 = 'productManagement';
  static const String jobPlace1 = 'Lüneburg,part-time(working student)';
  static const String jobPlace2 = 'Hamburg,part-time(working student)';
  static const String job1text = 'theUvexGroup';
  static const String workingStudent = 'workingStudent';
  static const String internship = 'internship';
  static const String job2text = 'whatWeAre';
  static const String graphicAndDesign = 'graphicAndDesign';
  static const String job3text = 'hamburgerTowers';
  static const String marketing = 'marketing';
  static const String job4text = 'welcomeToAudi';
  static const String inCustomerservce = 'inCustomerservce';
  static const String job5text = 'atCheck24';
  static const String itConsultant = 'itConsultant';
  static const String job6text = 'joinUs';
  static const String job7text = 'jobDescribtion';
  static const String financialSector = 'financialSector';
  static const String job8text = 'atOurHamburg';
  static const String summerParty = 'theSummerStudentParty';
  static const String free = 'free';
  static const String shots = 'shots';
  static const String partyText = 'partytext';
  static const String where = 'where';
  static const String centralbuilding = 'centralbuilding';
  static const String university = 'university';
  static const String when = 'when';
  static const String date = 'date';
  static const String prices = 'prices';
  static const String incl = 'incl';
  static const String perPerson = 'perPerson';
  static const String tickets = 'tickets';
  //static const String title = 'title';
  //static const String body = 'body';
  static const String topNews = 'topNews';
  static const String jobOffers = 'jobOffers';
  static const String advertisement = 'advertisement';
  //static const String welcomeMessage = 'welcomeMessage';
  static const String impressum = 'impressum';
  static const String moreJobs = 'moreJobs';
  static const String hungry = 'hungry';
  static const String menu = 'menu';
  static const String infoandservice = 'infoandservice';
  static const String impressumText = 'impressumText'; //Zeile 562
  static const String close = 'close'; //Zeile 565
  static const String contact = 'contact'; //Zeile 599
  static const String contactText = 'contactText'; //Zeile 604-606
  static const String dataProtection = 'dataProtection'; //Zeile 647
  static const String dataProtectionText = 'dataProtectionText'; //Zeile 649
  static const String openingHours = 'openingHours'; //Zeile 686
  static const String openingHoursText = 'openingHoursText'; //Zeile 688
  static const String newsletter = 'newsletter'; // 733
  static const String newslettertext = 'newsletterText'; //740
  static const String email = 'email'; // 746
  static const String emailText = 'emailText'; // 751
  static const String emailText2 = 'emailText2'; // 756
  static const String newsletterText2 = 'newsletterText2'; // 775
  static const String faqQ1 = 'faqQ1'; // ab Zeile 827
  static const String faqA1 = 'faqA1';
  static const String faqQ2 = 'faqQ2';
  static const String faqA2 = 'faqA2';
  static const String faqQ3 = 'faqQ3';
  static const String faqA3 = 'faqA3';
  static const String faqQ4 = 'faqQ4';
  static const String faqA4 = 'faqA4';
  static const String faqQ5 = 'faqQ5';
  static const String faqA5 = 'faqA5';
  static const String faqQ6 = 'faqQ6';
  static const String faqA6 = 'faqA6';
  static const String faqQ7 = 'faqQ7';
  static const String faqA7 = 'faqA7';
  static const String faqMore = 'faqMore';
  static const String formular = 'formular'; // 925
  static const String name = 'name'; // 937
  static const String nameText = 'nameText'; // 942
  static const String nameEmail = 'nameEmail'; // 958
  static const String subject = 'subject'; // 967
  static const String message = 'message'; // 976
  static const String messageText = 'messageText'; // 982
  static const String messageText2 = 'messageText2'; // 1005
  static const String applynow = 'applyNow';
  static const String moreJobs2 = 'moreJobs2';

  static const Map<String, dynamic> EN = {
    moreHere: 'More here',
    searchBar: 'Search...',
    mealPlan: 'Meal plan',
    mealList: 'Meal list',
    homePage: 'Homepage',
    dayOfWeek1: 'Monday',
    dayOfWeek2: 'Tuesday',
    dayOfWeek3: 'Wednesday',
    dayOfWeek4: 'Thursday',
    dayOfWeek5: 'Friday',
    weekText: 'Week',
    price: 'Price',
    type: 'Type',
    noMealPlanned: 'No meal planned',
    login: 'Login',
    password: 'Password',
    back: 'Back',
    reviewLabel: 'Reviews',
    noReviewsYet: 'No reviews yet',
    addReview: 'Add Review',
    addAReview: 'Add a review',
    review: 'Review',
    loginToAddReview: 'Login to add review',
    takePhoto: 'Take photo',
    cancel: 'Cancel',
    editMeal: 'Edit meal',
    nameEnglish: 'Name (English)',
    nameGerman: 'Name (German)',
    typeEnglish: 'Type (English)',
    typeGerman: 'Type (German)',
    changePicture: 'Change picture',
    save: 'Save',
    addMealToWeek: 'Add meal to week',
    add: 'Add',
    topNews: 'Top News',
    jobOffers: 'Job Offers',
    advertisement: 'Advertisement',
    //title: 'title',
    //body: 'body',
    //welcomeMessage: '',
    impressum: 'Impressum',
    moreJobs: 'More Joboffers',
    news1:
        'Lüneburger Heather: Heather Blossom Festival starts in Amelinghausen',
    news1undertext:
        'Starting on Saturday, the traditional heather blossom festival will be celebrated in Amelinghausen for nine days. The election of a new heather queen will also take place. The organizers are expecting several thousnd visitors.',
    news2:
        'Police ticker Lüneburg: Current police reports in and around Lüneburg',
    news2undertext:
        'Whether it`s traffic accidents, road closures, missing persons reports, violent crimes or other crimes. You can now find the latest police and traffic reports from Lüneburg and the region around the clock in our live ticker.',
    news3: 'World Cat Day 2024: These are the cutest cats from Lüneburg',
    news3undertext:
        'Do you like taking snapshots of your cat? You`re not alone! Numerous LZ readers took part in the photo campaign on the occasion of World Cat Day.',
    news4:
        'Metronom train collides with concrete slab – unknown persons place obstacles in the track',
    news4undertext:
        'On the Metronom line between Hanover and Uelzen, unknown persons placed a concrete slab in the track. A train collided with it in the city of Celle. No one was injured.',
    readMoreHere: 'Read more here',
    jobPlace1: 'Lüneburg, part-time (working student)',
    jobPlace2: 'Hamburg, part-time (working student)',
    job1: 'Working student in product management | UVEX',
    job1text:
        'The uvex group as an employer. Our mission is protecting. The uvex group has been protecting people at work, in sport and in their free time with innovative products for 95 years.',
    workingStudent: 'Working student',
    internship: 'Internship',
    job2text:
        'WHAT WE ARE LOOKING FOR? Support of projects for the optimal alignment of (digital) processes in the production area.',
    graphicAndDesign: 'Graphics and Design',
    job3text:
        'Hamburg Towers Betreibergesellschaft mbH is now looking for a working student (m/f/d) in graphics and design. The position is designed to last at least 12 months.',
    marketing: 'Marketing & Communication',
    job4text:
        'Welcome to Audi in Hamburg You. Us. Audi. Audi Hamburg GmbH is part of Volkswagen Group Retail Germany and is therefore a subsidiary of Volkswagen AG. Today we employ people at numerous locations in...',
    inCustomerservce: 'in customer service',
    job5text:
        'at CHECK24 Start as a working student in customer service (m/f/d) at CHECK24 in Hamburg and become the first point of contact for solving customer concerns. What you do...',
    itConsultant: 'IT-Consultant',
    job6text:
        'Join us on our mission to free Germany from technology frustration! Apply now as a technology consultant (m/f/d)!',
    job7text:
        'Job description For VE SALES GMBH we are now looking for a working student in the area of ​​Sales Administration for deployment at the location 20457 Hamburg, Amerigo-Vespucci-Platz 2. In our team we shape the sales...',
    financialSector: 'in the financial sector',
    job8text:
        'At our Hamburg location, we are looking for a working student (m/f/d) in the finance department (10-20 hours per week) to start immediately. GARBE Industrial Real Estate GmbH develops, buys, manages, rents, finances and sells...',
    summerParty:
        'The Summer Student Party 2024 at Lunophara University is the perfect place to end the semester! Look forward to a cool atmosphere,',
    free: 'free',
    shots: ' Shots for the ladies and a rousing performance by special guest ',
    partyText: '. Let’s experience an unforgettable night together!',
    where: 'Where',
    centralbuilding: 'Central building',
    university: 'University',
    when: 'When',
    date: 'Friday, October 18, 2024, entry from 10 p.m.!',
    prices: 'Prices',
    incl: 'incl.',
    perPerson: 'per person',
    tickets:
        'For tickets or party lounges send a message to: +49 171 12345678 or studiparty@lunophara.de !',
    applynow: 'Apply Now',
    moreJobs2: 'More Jobs',

    hungry: 'hungry?🤔 then its time for...',
    menu: '...more about this in our menu. Enjoy your meal!',
    infoandservice: 'Informations & Services',
    impressumText:
        'LüneFood e.V.\nLünestraße 2a, 21337 Lüneburg\n\nrepresented by:\nEbu Bekir Yel\nGianluca Politano\nRujahl Hakami\nDzenita Redzic\n\nregistered in the association register:\nregister court: Amtsgericht Lüneburg\nRegistration number: VR 12345',
    close: 'Close',
    contact: 'Contact',
    contactText:
        'phone: +49 (0)123 456789\nemail: info@luenefood.de\nfax: +49 (0)123 456780\n\n',
    dataProtection: 'Data Protection',
    dataProtectionText:
        'This website uses cookies to provide you with the best possible user experience. Cookie information is stored in your browser and performs functions such as recognizing you when you return to our website and helping our team understand which sections of the website are most interesting and useful to you.',
    openingHours: 'Opening Hours',
    openingHoursText:
        'monday - friday:\n11:00 AM - 2:00 PM\n4:00 PM - 7:00 PM\n\nsaturday:\nclosed\n\nsunday and non-lecture periods:\nclosed',
    newsletter: 'Newsletter',
    newslettertext:
        'Feel free to subscribe to our newsletter to stay up to date with the latest news!',
    email: 'your email:',
    emailText: 'Please enter an email address.',
    emailText2: 'Please enter a valid email address.',
    submit: 'Submit',
    newsletterText2:
        'Thank you for signing up! You will receive a confirmation email shortly.',
    faqQ1: 'What are the opening hours of the cafeteria?\n',
    faqA1:
        'The cafeteria is open Monday to Friday from 11:00 AM to 2:00 PM and from 4:00 PM to 7:00 PM. We are closed on Saturdays, Sundays, and during non-lecture periods.\n\n',
    faqQ2: 'Where can I find your cafeteria?\n',
    faqA2:
        'You can find our cafeteria on the campus of Lunophara University Lüneburg. The exact location is Lünestraße 2a, 21337 Lüneburg.\n\n',
    faqQ3: 'What payment methods are accepted in the cafeteria?\n',
    faqA3:
        'We accept cash, debit cards, and all major credit cards. You can also pay with your student card.\n\n',
    faqQ4: 'Are there vegan or vegetarian dishes in the cafeteria?\n',
    faqA4:
        'Yes, we offer vegetarian, vegan, and meat dishes. These are indicated on our menu.\n\n',
    faqQ5: 'Can I provide feedback about the cafeteria?\n',
    faqA5:
        'Yes, you can by using our online feedback form on the website. Select your dish, and there you can give a star rating and write a comment. We look forward to your feedback!\n\n',
    faqQ6: 'Can outsiders also eat in the cafeteria?\n',
    faqA6:
        'Yes, outsiders can also eat in our cafeteria. This includes both guests and staff. Please refer to our menu for the respective prices.\n\n',
    faqQ7:
        'Does your cafeteria also offer dishes suitable for people with allergies?\n',
    faqA7:
        'Our menu provides detailed information about the ingredients of each dish. We recommend that people with allergies review this information carefully before purchasing.\n\n',
    faqMore:
        'If you have any further questions, please feel free to contact our support team. You can reach them at ',
    formular: 'support form',
    name: 'name',
    nameText: 'Please enter a name.',
    nameEmail: 'email address',
    subject: 'subject (optional)',
    message: 'message',
    messageText: 'Please enter a message.',
    messageText2:
        'Thank you! Your request has been successfully submitted. Our support team will get in touch with you shortly.',
  };

  static const Map<String, dynamic> DE = {
    moreHere: 'Mehr dazu hier',
    searchBar: 'Suche...',
    mealPlan: 'Essensplan',
    mealList: 'Essensliste',
    homePage: 'Startseite',
    dayOfWeek1: 'Montag',
    dayOfWeek2: 'Dienstag',
    dayOfWeek3: 'Mittwoch',
    dayOfWeek4: 'Donnerstag',
    dayOfWeek5: 'Freitag',
    weekText: 'Woche',
    price: 'Preis',
    type: 'Typ',
    noMealPlanned: 'Keine Mahlzeit geplant',
    login: 'Anmelden',
    password: 'Passwort',
    back: 'Zurück',
    reviewLabel: 'Bewertungen',
    noReviewsYet: 'Noch keine Bewertungen',
    addReview: 'Bewertung hinzufügen',
    addAReview: 'Bewertung hinzufügen',
    review: 'Bewertung',
    loginToAddReview: 'Anmelden, um eine Bewertung hinzuzufügen',
    takePhoto: 'Foto aufnehmen',
    cancel: 'Abbrechen',
    editMeal: 'Essen bearbeiten',
    nameEnglish: 'Name (Englisch)',
    nameGerman: 'Name (Deutsch)',
    typeEnglish: 'Typ (Englisch)',
    typeGerman: 'Typ (Deutsch)',
    changePicture: 'Bild ändern',
    save: 'Speichern',
    addMealToWeek: 'Essen zur Woche hinzufügen',
    add: 'Hinzufügen',
    topNews: 'Top-Nachrichten',
    jobOffers: 'Stellenangebote',
    advertisement: 'Werbung',
    //title: 'Titel',
    //body: 'Textkörper',
    //welcomeMessage: '',
    impressum: 'Impressum',
    moreJobs: 'Mehr Stellenangebote',
    news1: 'Lüneburger Heide: Heideblütenfest in Amelinghausen startet',
    news1undertext:
        'Ab Samstag wird in Amelinghausen neun Tage das traditionelle Heideblütenfest gefeiert. Dabei steht auch die Wahl einer neuen Heidekönigin an. Die Veranstalter erwarten mehrere Tausend Besucher.',
    news2:
        'Polizeiticker Lüneburg: Aktuelle Polizeimeldungen in und um Lüneburg',
    news2undertext:
        'Ob Verkehrsunfälle, Sperrungen, Vermisstenmeldungen, Gewaltdelikte oder anderweitige Verbrechen. Aktuelle Polizei- und Verkehrsmeldungen aus Lüneburg und der Region finden Sie ab sofort rund um die Uhr auch in unserem Liveticker.',
    news3:
        'Weltkatzentag 2024: Das sind die knuffigsten Samtpfoten aus Lüneburg',
    news3undertext:
        'Sie machen gerne Schnappschüsse Ihrer Katze? Damit sind Sie nicht allein! Zahlreiche LZ-Leser haben sich an der Fotoaktion anlässlich des Weltkatzentags beteiligt.',
    news4:
        'Metronom-Zug kollidiert mit Betonplatte – Unbekannte legen Hindernisse ins Gleis',
    news4undertext:
        'Auf der Metronom-Strecke zwischen Hannover und Uelzen haben noch Unbekannte eine Betonplatte im Gleis platziert. Ein Zug kollidierte mit dieser im Stadtgebiet Celle. Verletzt wurde niemand.',
    readMoreHere: 'Mehr dazu hier',
    jobPlace1: 'Lüneburg, Teilzeit (Werkstudent:in)',
    jobPlace2: 'Hamburg, Teilzeit (Werkstudent:in)',
    job1: 'Werkstudent:in Produktmanagement | UVEX',
    job1text:
        'Die uvex group als Arbeitgeber. Unsere Mission lautet protecting. Mit innovativen Produkten schützt die uvex group seit 95 Jahren Menschen in Beruf, Sport und Freizeit.',
    workingStudent: 'Werkstudent:in',
    internship: 'Praktikum',
    job2text:
        'WOFÜR WIR SIE SUCHEN? Unterstützung von Projekten zur optimalen Ausrichtung von (digitalen) Prozessen im Produktionsbereich.',
    graphicAndDesign: ' Grafik und Design',
    job3text:
        'Die Hamburg Towers Betreibergesellschaft mbH sucht ab sofort eine/n Werkstudent:in (m/w/d) Grafik und Design Die Tätigkeit ist auf eine Dauer von mindestens 12 Monaten ausgelegt.',
    marketing: 'Marketing & Kommunikation',
    job4text:
        'Willkommen bei Audi in Hamburg Du. Wir. Audi. Die Audi Hamburg GmbH ist Teil der Volkswagen Group Retail Deutschland und damit eine Konzerngesellschaft der Volkswagen AG. Heute beschäftigen wir an zahlreichen Standorten im...',
    inCustomerservce: 'im Kundenservice',
    job5text:
        'bei CHECK24 Starte als Werkstudent im Kundenservice (m/w/d) bei CHECK24 in Hamburg und werde die erste Anlaufstelle für die Lösungen von Anliegen der Kund:innen. Was du machen...',
    itConsultant: 'IT-Berater',
    job6text:
        'Join us on our mission to free Germany from technology frustration! Apply now as a technology consultant (m/f/d)!',
    job7text:
        'Stellenbeschreibung Für die VE SALES GMBH suchen wir ab sofort eine/n Werkstudent:in im Bereich Sales Administration für den Einsatz am Standort 20457 Hamburg, Amerigo-Vespucci-Platz 2. Im unserem Team gestalten wir den Vertrieb...',
    financialSector: 'im Finanzbereich',
    job8text:
        'An unserem Standort Hamburg suchen wir für den sofortigen Einstieg eine Werkstudent/in (m/w/d) im Finanzbereich (10-20 Stunden pro Woche) Die GARBE Industrial Real Estate GmbH entwickelt, kauft, betreut, vermietet, finanziert und verkauft...',
    summerParty:
        'Die Sommer-Studi-Party 2024 an der Lunophara Universität ist der perfekte Ort, um das Semester ausklingen zu lassen! Freut euch auf coole Stimmung,',
    free: 'gratis',
    shots:
        'Shots für die Ladies und eine mitreißende Performance von Special Guest',
    partyText: 'Lasst uns gemeinsam eine unvergessliche Nacht erleben !',
    where: 'Wo',
    centralbuilding: 'Zentralgebäude',
    university: 'Universität',
    when: 'Wann',
    date: 'Freitag, 18.10.2024, Einlass ab 22 Uhr !',
    prices: 'Preise',
    incl: 'inkl.',
    perPerson: 'pro Person',
    tickets:
        'Für Tickets oder Partylounges eine Nachricht an: +49 171 12345678 oder studiparty@lunophara.de !',
    applynow: 'Jetzt Bewerben',
    moreJobs2: 'Weitere Stellenangebote',

    hungry: 'Hunger?🤔 Dann ist es Zeit für...',
    menu: '...mehr dazu in unserem Essensplan. Guten Appetit!',
    infoandservice: 'Informationen & Service',
    impressumText:
        'LüneFood e.V.\nLünestraße 2a, 21337 Lüneburg\n\nVertreten durch:\nEbu Bekir Yel\nGianluca Politano\nRujahl Hakami\nDzenita Redzic\n\nEingetragen im Vereinsregister:\nRegistergericht: Amtsgericht Lüneburg\nRegisternummer: VR 12345',
    close: 'Schließen',
    contact: 'Kontakt',
    contactText:
        'Telefon: +49 (0)123 456789\nE-Mail: info@luenefood.de\nFax: +49 (0)123 456780\n\n',
    dataProtection: 'Datenschutz',
    dataProtectionText:
        'Diese Website verwendet Cookies, damit wir Ihnen die bestmögliche Benutzererfahrung bieten können. Cookie-Informationen werden in Ihrem Browser gespeichert und führen Funktionen aus, wie das Wiedererkennen von Ihnen, wenn Sie auf unsere Website zurückkehren, und helfen unserem Team zu verstehen, welche Abschnitte der Website für Sie am interessantesten und nützlichsten sind.',
    openingHours: 'Öffnungszeiten',
    openingHoursText:
        'Montag - Freitag:\n11:00 - 14:00 Uhr\n16:00 - 19:00 Uhr\n\nSamstag:\nGeschlossen\n\nSonntag und vorlesungsfreie Zeit:\nGeschlossen',
    newsletter: 'Newsletter',
    newslettertext:
        'Abonnieren Sie gerne unseren Newsletter, um keine Neuigkeiten mehr zu verpassen!',
    email: 'Ihre E-Mail:',
    emailText: 'Bitte geben Sie eine E-Mail-Adresse ein.',
    emailText2: 'Bitte geben Sie eine gültige E-Mail-Adresse ein.',
    submit: 'Abschicken',
    newsletterText2:
        'Vielen Dank für Ihre Anmeldung! Sie erhalten in Kürze eine Bestätigungs-E-Mail.',
    faqQ1: 'Wie sind die Öffnungszeiten der Mensa?\n',
    faqA1:
        'Die Mensa ist Montags bis Freitags von 11:00 bis 14:00 Uhr sowie von 16:00 bis 19:00 Uhr geöffnet. Samstags sowie an Sonntagen und vorlesungsfreien Tagen haben wir geschlossen.\n\n',
    faqQ2: 'Wo finde ich eure Mensa?\n',
    faqA2:
        'Sie finden unsere Mensa auf dem Campusgelände der Lunophara Universität Lüneburg. Der genaue Standort ist die Lünestraße 2a, 21337 Lüneburg.\n\n',
    faqQ3: 'Welche Zahlungsmittelmethoden werden in der Mensa akzeptiert?\n',
    faqA3:
        'Wir akzeptieren Bargeld, EC-Karten und alle gängigen Kreditkarten. Außerdem können Sie mit Ihrer Studierendenkarte bezahlen.\n\n',
    faqQ4: 'Gibt es in der Mensa vegane oder vegetarische Gerichte?\n',
    faqA4:
        'Ja, wir bieten sowohl vegetarische, vegane als auch Gerichte mit Fleisch an. Diese sind auf unserem Essensplan gekennzeichnet.\n\n',
    faqQ5: 'Kann ich Feedback zur Mensa geben?\n',
    faqA5:
        'Ja, können Sie, indem Sie unser Online-Feedbackformular auf der Website nutzen. Dafür wählen Sie Ihr Gericht aus und dort können Sie Sterne vergeben sowie ein Kommentar schreiben. Wir freuen uns auf Ihr Feedback!\n\n',
    faqQ6: 'Können auch Außenstehende in der Mensa essen?\n',
    faqA6:
        'Ja, auch Außenstehende können in unserer Mensa essen. Dazu zählen sowohl Gäste als auch Bedienstete. Die jeweiligen Preise entnehmen Sie bitte aus unserem Essensplan.\n\n',
    faqQ7:
        'Bietet eure Mensa auch Gerichte an, die für Allergiker geeignet sind?\n',
    faqA7:
        'Unser Essensplan enthält detaillierte Informationen zu den Inhaltsstoffen der einzelnen Gerichte. Wir empfehlen Allergikern, diese Angaben vor dem Kauf sorgfältig zu prüfen.\n\n',
    faqMore:
        'Falls Sie noch weitere Fragen haben, nutzen Sie gerne unseren Support. Diesen erreichen Sie unter ',
    formular: 'Support Formular',
    name: 'Name',
    nameText: 'Bitte geben Sie einen Namen ein.',
    nameEmail: 'E-Mail-Adresse',
    subject: 'Betreff (optional)',
    message: 'Nachricht',
    messageText: 'Bitte geben Sie eine Nachricht ein.',
    messageText2:
        'Vielen Dank! Ihre Anfrage wurde erfolgreich gesendet. Unser Support-Team wird sich in Kürze bei Ihnen melden.',
  };
}
