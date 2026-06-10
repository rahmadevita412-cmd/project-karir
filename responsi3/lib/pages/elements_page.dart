import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'message_page.dart';
import '../widgets/custom_drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ElementsPage extends StatefulWidget {
  const ElementsPage({super.key});

  @override
  State<ElementsPage> createState() => _ElementsPageState();
}

class _ElementsPageState extends State<ElementsPage> {
  bool showSearch = false;
  List elementsFromApi = [];
  Future<void> getElements() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/elements'),
  );

  if (response.statusCode == 200) {
    setState(() {
      elementsFromApi = jsonDecode(response.body);
    });
  }
}
@override
void initState() {
  super.initState();
  getElements();
}

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subContainerColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF7F7F7);
    final borderColor = isDark ? Colors.grey[800]! : const Color(0xFFE4E4E4);
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);

    return Scaffold(
      backgroundColor: bgColor, // Dinamis
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2C2C2C) : Colors.white, 
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: borderColor), 
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: isDark ? Colors.white70 : const Color.fromARGB(255, 114, 122, 148), 
                        size: 20,
                      ),
                    ),
                  ),
                  Text(
                    'Framework7',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor, 
                    ),
                  ),
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2C2C2C) : Colors.white, 
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: borderColor),
                        ),
                        child: Icon(
                          Icons.tune,
                          color: navyColor, // Dinamis
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (showSearch)
              Container(
                margin: const EdgeInsets.only(left: 75, right: 75, bottom: 18),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                height: 52,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 63, 72, 117),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 22,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Search components',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF8D8D8D),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  buildMenuTile(
                    context,
                    title: 'About Framework7',
                    page: const AboutPage(),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Components',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: navyColor, // Dinamis
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                      color: subContainerColor, 
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        buildMenuTile(
                          context,
                          title: 'Accordion',
                          page: const AccordionPage(),
                          insideGroup: true,
                        ),
                        buildMenuTile(
                          context,
                          title: 'Action Sheet',
                          page: const ActionSheetPage(),
                          insideGroup: true,
                        ),
                        buildMenuTile(
                          context,
                          title: 'Appbar',
                          page: const AppbarPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Autocomplete', insideGroup: true),
                        buildSimpleTile('Badge', insideGroup: true),
                        buildSimpleTile('Buttons', insideGroup: true),
                        buildSimpleTile('Calendar / Date Picker', insideGroup: true),
                        buildSimpleTile('Cards', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Cards Expandable',
                          page: const CardsExpandablePage(),
                          insideGroup: true,
                        ),
                        buildMenuTile(
                          context,
                          title: 'Checkbox',
                          page: const CheckboxPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Chips / Tags', insideGroup: true),
                        buildSimpleTile('Color Picker', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Contacts List',
                          page: const ContactsListPage(),
                          insideGroup: true,
                        ),
                        buildMenuTile(
                          context,
                          title: 'Content Block',
                          page: const ContentBlockPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Data Table', insideGroup: true),
                        buildSimpleTile('Dialog', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Elevation',
                          page: const AppbarElevationPage(),
                          insideGroup: true,
                        ),
                        buildMenuTile(
                          context,
                          title: 'FAB',
                          page: const FabPage(),
                          insideGroup: true,
                        ),
                        buildMenuTile(
                          context,
                          title: 'FAB Morph',
                          page: const FabMorphPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Form Storage', insideGroup: true),
                        buildSimpleTile('Gauge', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Grid / Layout Grid',
                          page: const GridLayoutPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Icons', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Infinite Scroll',
                          page: const InfiniteScrollPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Inputs', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Lazy Load',
                          page: const AppbarLazyLoadPage(), 
                          insideGroup: true,
                        ),
                        buildSimpleTile('List View', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'List Index',
                          page: const ListIndexPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Login Screen', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Menu',
                          page: const MenuPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Message', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Navbar',
                          page: const NavbarPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Notifications', insideGroup: true),
                        buildSimpleTile('Panel / Side Panels', insideGroup: true),
                        buildSimpleTile('Photo Browser', insideGroup: true),
                        buildSimpleTile('Picker', insideGroup: true),
                        buildSimpleTile('Popover', insideGroup: true),
                        buildSimpleTile('Popup', insideGroup: true),
                        buildSimpleTile('Preloader', insideGroup: true),
                        buildSimpleTile('Progress Bar', insideGroup: true),
                        buildSimpleTile('Pull To Refresh', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Radio',
                          page: const RadioPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Range Slider', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Searchbar',
                          page: const SearchbarPage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Searchbar Expandable', insideGroup: true),
                        buildSimpleTile('Sheet Modal', insideGroup: true),
                        buildSimpleTile('Skeleton (Ghost) Layouts', insideGroup: true),
                        buildSimpleTile('Smart Select', insideGroup: true),
                        buildSimpleTile('Sortable List', insideGroup: true),
                        buildSimpleTile('Stepper', insideGroup: true),
                        buildSimpleTile('Subnavbar', insideGroup: true),
                        buildSimpleTile('Swipeout (Swipe To Delete)', insideGroup: true),
                        buildSimpleTile('Swiper Slider', insideGroup: true),
                        buildSimpleTile('Tabs', insideGroup: true),
                        buildSimpleTile('Text Editor', insideGroup: true),
                        buildSimpleTile('Timeline', insideGroup: true),
                        buildSimpleTile('Toast', insideGroup: true),
                        buildMenuTile(
                          context,
                          title: 'Toggle',
                          page: const TogglePage(),
                          insideGroup: true,
                        ),
                        buildSimpleTile('Toolbar & Tabbar', insideGroup: true),
                        buildSimpleTile('Tooltip', insideGroup: true),
                        buildSimpleTile('Treeview', insideGroup: true),
                        buildSimpleTile('Virtual List', insideGroup: true),
                        buildSimpleTile(
                          'Vi - Mobile Video SSP',
                          insideGroup: true,
                          customIcon: SvgPicture.asset(
                            'assets/icons/vi.svg',
                            width: 28,
                            height: 28,
                          ),
                        ),
                        ...elementsFromApi.map(
  (element) => buildSimpleTile(
    element['title'],
    insideGroup: true,
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
      ),
    );
  }

  Widget buildMenuTile(
    BuildContext context, {
    required String title,
    required Widget page,
    bool insideGroup = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: insideGroup ? 0 : 14),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 56,
        decoration: BoxDecoration(
          color: insideGroup ? Colors.transparent : (isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF1F3FC)), // Dinamis
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFF1B3177),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  'assets/icons/logoo.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black, 
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFFC1C1C1),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSimpleTile(
    String title, {
    bool insideGroup = false,
    Widget? customIcon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(bottom: insideGroup ? 0 : 14),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      decoration: BoxDecoration(
        color: insideGroup ? Colors.transparent : (isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF7F7F7)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          customIcon ??
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B3177),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(
                    'assets/icons/logoo.svg',
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: isDark ? Colors.white : Colors.black, 
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFFC1C1C1),
            size: 24,
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// ABOUT PAGE
// ===================================================================

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
   
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final iconBgColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final borderColor = isDark ? Colors.grey[800]! : const Color(0xFFE4E4E4);
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);

    return Scaffold(
      backgroundColor: bgColor, 
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: iconBgColor, 
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: borderColor), 
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: isDark ? Colors.white : const Color.fromARGB(255, 114, 122, 148), 
                        size: 20,
                      ),
                    ),
                  ),
                  Text(
                    'About',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor, 
                    ),
                  ),
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: iconBgColor, 
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: borderColor), 
                        ),
                        child: Icon(
                          Icons.tune,
                          color: navyColor, 
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  'About',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                    color: textColor, 
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Welcome to Framework7',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: navyColor, 
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Framework7 - is a free and open source HTML mobile framework to develop hybrid mobile apps or web apps with iOS or Android (Material) native look and feel. It is also an indispensable prototyping apps tool to show working app prototype as soon as possible in case you need to. Framework7 is created by Vladimir Kharlampidi.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: textColor, 
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'The main approach of the Framework7 is to give you an opportunity to create iOS and Android (Material) apps with HTML, CSS and JavaScript easily and clear. Framework7 is full of freedom. It does not limit your imagination or offer ways of any solutions somehow. Framework7 gives you freedom!',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: textColor, 
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Framework7 is not compatible with all platforms. It is focused only on iOS and Android (Material) to bring the best experience and simplicity.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: textColor, 
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Framework7 is definitely for you if you decide to build iOS and Android hybrid app (Cordova or Capacitor) or web app that looks like and feels as great native iOS or Android (Material) apps.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: textColor,
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ===================================================================
// ACCORDION PAGE
// ===================================================================

class AccordionPage extends StatefulWidget {
  const AccordionPage({super.key});

  @override
  State<AccordionPage> createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {
  int openIndex = -1;
  int oppositeOpenIndex = -1;

  @override
  Widget build(BuildContext context) {
 
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subContainerColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF7F7F7);
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);

    return Scaffold(
      backgroundColor: bgColor, // Dinamis
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, size: 24, color: textColor), 
                  ),
                  const SizedBox(width: 18),
                  Text(
                    'Accordion',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor, 
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'List View Accordion',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: navyColor, 
              ),
            ),
            const SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: subContainerColor, 
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  buildAccordionItem(0, 'Lorem Ipsum'),
                  buildAccordionItem(1, 'Nested List'),
                  buildAccordionItem(2, 'Integer semper'),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Opposite Side',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: navyColor, 
              ),
            ),
            const SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: subContainerColor, // Dinamis
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  oppositeItem(0, 'Lorem Ipsum'),
                  oppositeItem(1, 'Nested List'),
                  oppositeItem(2, 'Integer semper'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccordionItem(int index, String title) {
    bool isOpen = openIndex == index;
  
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              openIndex = isOpen ? -1 : index;
            });
          },
          behavior: HitTestBehavior.opaque, 
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black, 
                        ),
                      ),
                    ),
                    Icon(
                      isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: const Color(0xFFC1C1C1),
                    ),
                  ],
                ),
                if (isOpen) ...[
                  const SizedBox(height: 18),
                  if (index == 0)
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean elementum id neque nec commodo. Sed vel justo at turpis laoreet pellentesque quis sed lorem. Integer semper arcu nibh, non mollis arcu tempor vel. Sed pharetra tortor vitae est rhoncus, vel congue dui sollicitudin. Donec eu arcu dignissim felis viverra blandit suscipit eget ipsum.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: isDark ? Colors.white70 : Colors.black, 
                        height: 1.8,
                      ),
                    ),
                  if (index == 1)
                    Column(
                      children: [
                        nestedItem('Item 1'),
                        nestedItem('Item 2'),
                        nestedItem('Item 3'),
                        nestedItem('Item 4'),
                      ],
                    ),
                  if (index == 2)
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean elementum id neque nec commodo. Sed vel justo at turpis laoreet pellentesque quis sed lorem. Integer semper arcu nibh, non mollis arcu tempor vel. Sed pharetra tortor vitae est rhoncus, vel congue dui sollicitudin. Donec eu arcu dignissim felis viverra blandit suscipit eget ipsum.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: isDark ? Colors.white70 : Colors.black, 
                        height: 1.8,
                      ),
                    ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget nestedItem(String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFF1B3177),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                'assets/icons/logoo.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: isDark ? Colors.white : Colors.black, 
            ),
          )
        ],
      ),
    );
  }

  Widget oppositeItem(int index, String title) {
    bool isOpen = oppositeOpenIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        setState(() {
          oppositeOpenIndex = isOpen ? -1 : index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFFC1C1C1),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black, 
                  ),
                ),
              ],
            ),
            if (isOpen) ...[
              const SizedBox(height: 18),
              if (index == 0)
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean elementum id neque nec commodo. Sed vel justo at turpis laoreet pellentesque quis sed lorem. Integer semper arcu nibh, non mollis arcu tempor vel. Sed pharetra tortor vitae est rhoncus, vel congue dui sollicitudin. Donec eu arcu dignissim felis viverra blandit suscipit eget ipsum.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black, 
                    height: 1.8,
                  ),
                ),
              if (index == 1)
                Column(
                  children: [
                    nestedItem('Item 1'),
                    nestedItem('Item 2'),
                    nestedItem('Item 3'),
                    nestedItem('Item 4'),
                  ],
                ),
              if (index == 2)
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean elementum id neque nec commodo. Sed vel justo at turpis laoreet pellentesque quis sed lorem. Integer semper arcu nibh, non mollis arcu tempor vel. Sed pharetra tortor vitae est rhoncus, vel congue dui sollicitudin. Donec eu arcu dignissim felis viverra blandit suscipit eget ipsum.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black, 
                    height: 1.8,
                  ),
                ),
            ]
          ],
        ),
      ),
    );
  }
}
// ===================================================================
// ACTION SHEET PAGE
// ===================================================================

class ActionSheetPage extends StatelessWidget {
  const ActionSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subContainerColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF1F3FC);
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);

    return Scaffold(
      backgroundColor: bgColor, // Ganti jadi dinamis
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back, size: 24, color: textColor), 
                  ),
                  const SizedBox(width: 18),
                  Text(
                    'Action Sheet',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: subContainerColor, 
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildActionButton('One group'),
                    const SizedBox(height: 12),
                    _buildActionButton('Two groups'),
                    const SizedBox(height: 12),
                    _buildActionButton('Action Grid'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Action Sheet To Popover',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: navyColor, 
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: subContainerColor, 
                  borderRadius: BorderRadius.circular(16),
                ),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: textColor, 
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Action Sheet can be automatically converted to Popover (for tablets). This button will open Popover on tablets and Action Sheet on phones: ',
                      ),
                      TextSpan(
                        text: 'Actions',
                        style: GoogleFonts.poppins(
                          color: isDark ? Colors.blueAccent : const Color(0xFF1B3177),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF142B6F), 
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
// ===================================================================
// CHECKBOX PAGE
// ===================================================================

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool inlineValue1 = false;
  bool inlineValue2 = false;

  Map<String, bool> groupValues = {
    'Books': true,
    'Movies': false,
    'Food': false,
    'Drinks': false,
  };

  bool? movieParent = null;
  bool movie1 = true;
  bool movie2 = false;

  List<bool> mediaListValues = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black87;
    final greyText = isDark ? Colors.grey[400] : Colors.grey;
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);

    return Scaffold(
      backgroundColor: bgColor, // Dinamis
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, size: 24, color: textColor), 
                ),
                const SizedBox(width: 18),
                Text(
                  'Checkbox',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textColor, // Dinamis
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _sectionTitle('Inline', navyColor),
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  color: textColor, // Dinamis
                  fontSize: 14, 
                  height: 1.6
                ),
                children: [
                  const TextSpan(text: 'Lorem '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Checkbox(
                        activeColor: const Color(0xFF142B6F),
                        checkColor: Colors.white,
                        side: BorderSide(color: isDark ? Colors.white54 : Colors.black45),
                        value: inlineValue1,
                        onChanged: (bool? value) {
                          setState(() {
                            inlineValue1 = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const TextSpan(text: ' ipsum dolor sit amet, consectetur adipisicing elit... '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Checkbox(
                        activeColor: const Color(0xFF142B6F),
                        checkColor: Colors.white,
                        side: BorderSide(color: isDark ? Colors.white54 : Colors.black45),
                        value: inlineValue2,
                        onChanged: (bool? value) {
                          setState(() {
                            inlineValue2 = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const TextSpan(text: ' ad delectus impedit.'),
                ],
              ),
            ),
            _sectionTitle('Checkbox Group', navyColor),
            ...groupValues.keys.map((key) {
              return CheckboxListTile(
                title: Text(key, style: GoogleFonts.poppins(fontSize: 15, color: textColor)),
                value: groupValues[key],
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFF142B6F),
                side: BorderSide(color: isDark ? Colors.white54 : Colors.black45),
                onChanged: (val) => setState(() => groupValues[key] = val!),
              );
            }).toList(),
            const SizedBox(height: 20),
            ...groupValues.keys.map((key) {
              return CheckboxListTile(
                title: Text(key, style: GoogleFonts.poppins(fontSize: 15, color: textColor)),
                value: groupValues[key],
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding: EdgeInsets.zero,
                activeColor: const Color(0xFF142B6F),
                side: BorderSide(color: isDark ? Colors.white54 : Colors.black45),
                onChanged: (val) => setState(() => groupValues[key] = val!),
              );
            }).toList(),
            const SizedBox(height: 30),
            _sectionTitle('Indeterminate State', navyColor),
            CheckboxListTile(
              title: Text('Movies', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: textColor)),
              value: movieParent,
              tristate: true,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              activeColor: const Color(0xFF142B6F),
              side: BorderSide(color: isDark ? Colors.white54 : Colors.black45),
              onChanged: (val) {
                setState(() {
                  movieParent = val;
                  movie1 = val ?? false;
                  movie2 = val ?? false;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Column(
                children: [
                  _subCheckbox('Movie 1', movie1, textColor, isDark, (v) {
                    setState(() {
                      movie1 = v!;
                      _updateMovieParent();
                    });
                  }),
                  Divider(indent: 16, color: isDark ? Colors.white10 : Colors.grey[300]),
                  _subCheckbox('Movie 2', movie2, textColor, isDark, (v) {
                    setState(() {
                      movie2 = v!;
                      _updateMovieParent();
                    });
                  }),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _sectionTitle('With Media Lists', navyColor),
            _mediaItem(0, 'Facebook', '17:14', 'New messages from John Doe', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', textColor, subTextColor, greyText, isDark),
            _mediaItem(1, 'John Doe (via Twitter)', '17:11', 'John Doe (@_johndoe) mentioned you!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', textColor, subTextColor, greyText, isDark),
            _mediaItem(2, 'Facebook', '16:48', 'New messages from John Doe', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', textColor, subTextColor, greyText, isDark),
            _mediaItem(3, 'John Doe (via Twitter)', '15:32', 'John Doe (@_johndoe) mentioned you!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', textColor, subTextColor, greyText, isDark),
          ],
        ),
      ),
    );
  }

  void _updateMovieParent() {
    if (movie1 && movie2) movieParent = true;
    else if (!movie1 && !movie2) movieParent = false;
    else movieParent = null;
  }

  Widget _sectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _subCheckbox(String title, bool value, Color tColor, bool isDark, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14, color: tColor)),
      value: value,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      activeColor: const Color(0xFF142B6F),
      side: BorderSide(color: isDark ? Colors.white54 : Colors.black45),
      onChanged: onChanged,
    );
  }

  Widget _mediaItem(int index, String name, String time, String subject, String body, Color tColor, Color sColor, Color? gColor, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: mediaListValues[index],
            onChanged: (v) => setState(() => mediaListValues[index] = v!),
            activeColor: const Color(0xFF142B6F),
            side: BorderSide(color: isDark ? Colors.white54 : Colors.black45),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: tColor)),
                    Text(time, style: GoogleFonts.poppins(fontSize: 12, color: gColor)),
                  ],
                ),
                Text(subject, style: GoogleFonts.poppins(fontSize: 13, color: sColor)),
                Text(
                  body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontSize: 12, color: gColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// ===================================================================
// CONTENT BLOCK PAGE
// ===================================================================

class ContentBlockPage extends StatelessWidget {
  const ContentBlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String dummyText =
        'Donec et nulla auctor massa pharetra adipiscing ut sit amet sem. Suspendisse molestie velit vitae mattis tincidunt. Ut sit amet quam mollis, vulputate turpis vel, sagittis felis.';
    const String loremText =
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptates itaque autem qui quaerat vero ducimus praesentium quibusdam veniam error ut alias, numquam iste ea quos maxime consequatur ullam at a.';

    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : const Color(0xFFF0F1F7);
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black87;
    final greyText = isDark ? Colors.grey[400] : Colors.grey[600];
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);
    final blockStrongColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEBEDF8);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Content Block',
          style: GoogleFonts.poppins(color: textColor, fontWeight: FontWeight.w600, fontSize: 18), 
        ),
        backgroundColor: appBarColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'This paragraph is outside of content block. Not cool, but useful for any custom elements with custom styling.',
              style: GoogleFonts.poppins(fontSize: 13, color: greyText), 
            ),
          ),
          _blockTitle('Block Title', navyColor),
          _contentBlock(dummyText, subTextColor, blockStrongColor),
          _blockTitle('Strong Block', navyColor),
          _contentBlock(
            'Here comes another text block with additional "block-strong" class. Praesent nec imperdiet diam. Maecenas vel lectus porttitor, consectetur magna nec, viverra sem. Aliquam sed risus dolor. Morbi tincidunt ut libero id sodales. Integer blandit varius nisi quis consectetur.',
            subTextColor,
            blockStrongColor,
            isStrong: true,
          ),
          _blockTitle('Strong Outline Block', navyColor),
          _contentBlock(loremText, subTextColor, blockStrongColor, isStrong: true, hasOutline: true),
          _blockTitle('Strong Inset Block', navyColor),
          _contentBlock(dummyText, subTextColor, blockStrongColor, isStrong: true, isInset: true),
          _blockTitle('Strong Inset Outline Block', navyColor),
          _contentBlock(dummyText, subTextColor, blockStrongColor, isStrong: true, isInset: true, hasOutline: true),
          _blockTitle('Tablet Inset', navyColor),
          _contentBlock(dummyText, subTextColor, blockStrongColor, isStrong: true, isInset: true),
          const SizedBox(height: 10),
          _blockTitle('With Header & Footer', navyColor),
          _blockHeader('Block Header', greyText),
          _contentBlock(dummyText, subTextColor, blockStrongColor, isStrong: false),
          _blockFooter('Block Footer', greyText),
          _blockHeader('Block Header', greyText),
          _contentBlock(dummyText, subTextColor, blockStrongColor, isStrong: true),
          _blockFooter('Block Footer', greyText),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Block Title Large', 
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: navyColor)),
          ),
          _contentBlock(dummyText, subTextColor, blockStrongColor, isStrong: true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Block Title Medium', 
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: navyColor)),
          ),
          _contentBlock(dummyText, subTextColor, blockStrongColor, isStrong: true),
        ],
      ),
    );
  }

  Widget _blockTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _blockHeader(String text, Color? color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(text, style: GoogleFonts.poppins(fontSize: 12, color: color)),
    );
  }

  Widget _blockFooter(String text, Color? color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(text, style: GoogleFonts.poppins(fontSize: 12, color: color)),
    );
  }

  Widget _contentBlock(String text, Color textColor, Color blockColor, {bool isStrong = false, bool isInset = false, bool hasOutline = false}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isInset ? 16 : 0,
        vertical: 4,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isStrong ? blockColor : Colors.transparent,
        borderRadius: isInset ? BorderRadius.circular(12) : null,
        border: hasOutline 
          ? Border.all(color: const Color(0xFF142B6F).withOpacity(0.5), width: 1)
          : (isStrong && !isInset 
              ? Border(
                  top: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                )
              : null),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: textColor,
          height: 1.5,
        ),
      ),
    );
  }
}

// ===================================================================
// INFINITE SCROLL PAGE
// ===================================================================

class InfiniteScrollPage extends StatefulWidget {
  const InfiniteScrollPage({super.key});

  @override
  State<InfiniteScrollPage> createState() => _InfiniteScrollPageState();
}

class _InfiniteScrollPageState extends State<InfiniteScrollPage> {
  final List<String> _items = List.generate(500, (index) => 'Item ${index + 1}');
  
  @override
  Widget build(BuildContext context) {
   
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final itemTextColor = isDark ? Colors.white70 : const Color(0xFF757575);
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);
    final dividerColor = isDark ? Colors.white10 : const Color(0x1F000000);

    return Scaffold(
      backgroundColor: bgColor, // Dinamis
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white, 
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Infinite Scroll',
          style: GoogleFonts.poppins(
            color: textColor, 
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Scroll bottom',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: navyColor, 
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 0.5,
                indent: 16,
                color: dividerColor, // Dinamis
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Colors.transparent,
                  selectedTileColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: Text(
                    _items[index],
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: itemTextColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// NAVBAR PAGE
// ===================================================================

class NavbarPage extends StatelessWidget {
  const NavbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.grey;
    final itemTextColor = isDark ? Colors.white60 : const Color(0xFF757575);
    final dividerColor = isDark ? Colors.white10 : const Color(0x1F000000);

    return Scaffold(
      backgroundColor: bgColor, 
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white, 
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Navbar',
              style: GoogleFonts.poppins(
                color: textColor, 
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Subtitle',
              style: GoogleFonts.poppins(
                color: subTextColor, 
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Right',
                style: GoogleFonts.poppins(color: textColor, fontSize: 16), 
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Navbar is a fixed (with Fixed and Through layout types) area at the top of a screen that contains Page title and navigation elements.',
                    style: GoogleFonts.poppins(fontSize: 14, height: 1.5, color: textColor), 
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Navbar has 3 main parts: Left, Title and Right. Each part may contain any HTML content.',
                    style: GoogleFonts.poppins(fontSize: 14, height: 1.5, color: textColor), 
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white, 
              ),
              child: ListTile(
                tileColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  'Hide Navbar On Scroll',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: itemTextColor, 
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: Color(0xFFD1D1D6)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HideNavbarOnScrollPage()),
                  );
                },
              ),
            ),
            Divider(height: 1, thickness: 0.5, indent: 26, color: dividerColor), 
          ],
        ),
      ),
    );
  }
}

// ===================================================================
// HIDE NAVBAR ON SCROLL PAGE
// ===================================================================

class HideNavbarOnScrollPage extends StatefulWidget {
  const HideNavbarOnScrollPage({super.key});

  @override
  State<HideNavbarOnScrollPage> createState() => _HideNavbarOnScrollPageState();
}

class _HideNavbarOnScrollPageState extends State<HideNavbarOnScrollPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showNavbar = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 50 && _showNavbar) {
        setState(() => _showNavbar = false);
      } else if (_scrollController.position.pixels <= 50 && !_showNavbar) {
        setState(() => _showNavbar = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final bannerColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF1F1F8);

    return Scaffold(
      backgroundColor: bgColor, 
      appBar: _showNavbar 
        ? AppBar(
            backgroundColor: appBarColor, 
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: textColor), 
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Hide Navbar On Scroll',
              style: GoogleFonts.poppins(
                color: textColor, 
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )
        : PreferredSize(
            preferredSize: Size.zero, 
            child: const SizedBox.shrink()
          ),
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bannerColor, 
            ),
            child: Text(
              'Navbar will be hidden if you scroll bottom',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: isDark ? Colors.white70 : Colors.black, 
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " * 30,
              style: GoogleFonts.poppins(
                fontSize: 14, 
                height: 1.8,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ===================================================================
// CONTACTS LIST PAGE
// ===================================================================

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> contacts = {
      'A': ['Aaron', 'Abbie', 'Adam', 'Adele', 'Agatha', 'Agnes', 'Albert', 'Alexander'],
      'B': ['Bailey', 'Barclay', 'Bartolo', 'Bellamy', 'Belle', 'Benjamin'],
      'C': ['Caiden', 'Calvin', 'Candy', 'Carl', 'Cherilyn', 'Chester', 'Chloe'],
      'V': ['Vladimir'],
    };

    final sortedKeys = contacts.keys.toList()..sort();

    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final itemTextColor = isDark ? Colors.white70 : Colors.black87;
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);
    final dividerColor = isDark ? Colors.white10 : const Color(0x1F000000);

    return Scaffold(
      backgroundColor: bgColor, 
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white, 
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Contacts List',
          style: GoogleFonts.poppins(
            color: textColor, 
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: sortedKeys.length,
        itemBuilder: (context, index) {
          String key = sortedKeys[index];
          List<String> userList = contacts[key]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
                child: Text(
                  key,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: navyColor, 
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userList.length,
                separatorBuilder: (context, i) => Divider(
                  height: 1,
                  thickness: 0.5,
                  indent: 50,
                  color: dividerColor, // Dinamis
                ),
                itemBuilder: (context, i) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                    title: Text(
                      userList[i],
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: itemTextColor, 
                      ),
                    ),
                    onTap: () {},
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

// ===================================================================
// CARDS EXPANDABLE PAGE
// ===================================================================

class CardData {
  final String title;
  final String subtitle;
  final String content;
  final Color? color;
  final String? imageUrl;
  final bool isDarkText;

  CardData({
    required this.title,
    required this.subtitle,
    required this.content,
    this.color,
    this.imageUrl,
    this.isDarkText = false,
  });
}

class CardsExpandablePage extends StatelessWidget {
  const CardsExpandablePage({super.key});

  @override
  Widget build(BuildContext context) {
 
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black87;

    final List<CardData> cards = [
      CardData(
        title: 'Framework7',
        subtitle: 'Build Mobile Apps',
        color: const Color(0xFFFF3B30),
        content: 'Framework7 - is a free and open source HTML mobile framework to develop hybrid mobile apps or web apps with iOS or Android (Material) native look and feel...',
      ),
      CardData(
        title: 'Framework7',
        subtitle: 'Build Mobile Apps',
        color: const Color(0xFFFFCC00),
        isDarkText: true,
        content: 'The main approach of the Framework7 is to give you an opportunity to create iOS and Android (Material) apps with HTML, CSS and JavaScript easily and clear...',
      ),
      CardData(
        title: 'Beach, Goa',
        subtitle: '',
        imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
        content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam cursus rhoncus cursus. Etiam lorem est, consectetur vitae tempor a, volutpat eget purus...',
      ),
      CardData(
        title: 'Monkeys',
        subtitle: '',
        imageUrl: 'https://images.unsplash.com/photo-1540573133985-87b6da6d54a9',
        content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam cursus rhoncus cursus. Etiam lorem est, consectetur vitae tempor a, volutpat eget purus...',
      ),
    ];

    return Scaffold(
      backgroundColor: bgColor, 
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white, 
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cards Expandable',
          style: GoogleFonts.poppins(color: textColor, fontWeight: FontWeight.bold), 
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'In addition to usual Cards there are also Expandable Cards that allow to store more information and illustrations about particular subject.',
              style: GoogleFonts.poppins(fontSize: 14, color: subTextColor), 
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) => ExpandableCardItem(data: cards[index]),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpandableCardItem extends StatelessWidget {
  final CardData data;
  const ExpandableCardItem({super.key, required this.data});

  void _openDetail(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (context, _, __) => CardDetailPage(data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetail(context),
      child: Hero(
        tag: 'card_${data.title}_${data.imageUrl}',
        child: Container(
          decoration: BoxDecoration(
            color: data.color ?? Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
            image: data.imageUrl != null 
              ? DecorationImage(image: NetworkImage(data.imageUrl!), fit: BoxFit.cover)
              : null,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: data.isDarkText ? Colors.black : Colors.white,
                ),
              ),
              if (data.subtitle.isNotEmpty)
                Text(
                  data.subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: data.isDarkText ? Colors.black54 : Colors.white70,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardDetailPage extends StatelessWidget {
  final CardData data;
  const CardDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Hero(
          tag: 'card_${data.title}_${data.imageUrl}',
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white, 
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: data.color,
                          image: data.imageUrl != null 
                            ? DecorationImage(
                                image: NetworkImage(data.imageUrl!), 
                                fit: BoxFit.cover
                              )
                            : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title,
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: data.isDarkText ? Colors.black : Colors.white,
                              ),
                            ),
                            if (data.subtitle.isNotEmpty)
                              Text(
                                data.subtitle,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: data.isDarkText ? Colors.black54 : Colors.white70,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 15,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.black26, 
                              shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.close, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      data.content + ("\n\n" + data.content) * 3,
                      style: GoogleFonts.poppins(
                        fontSize: 14, 
                        height: 1.6, 
                        color: isDark ? Colors.white70 : Colors.black87 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===================================================================
// FAB MORPH PAGE
// ===================================================================

class FabMorphPage extends StatelessWidget {
  const FabMorphPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final fabBgColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE3EAFF);
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);

    return Scaffold(
      backgroundColor: bgColor, 
      appBar: AppBar(
        backgroundColor: appBarColor, 
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'FAB Morph',
          style: GoogleFonts.poppins(
            color: textColor, // Dinamis
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "FAB Morphing is a technique where the Floating Action Button transforms into another UI element like a menu or a toolbar upon interaction.\n\n" +
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quia, quo rem beatae, delectus eligendi est saepe molestias perferendis suscipit." *
                      8,
              style: GoogleFonts.poppins(fontSize: 14, height: 1.8, color: textColor), 
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFAB(context, Icons.add, type: 1, isDark: isDark),
            _buildFAB(context, Icons.add, type: 2, isDark: isDark),
            _buildFAB(context, Icons.add, type: 3, isDark: isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context, IconData icon, {required int type, required bool isDark}) {
    final fabColor = isDark ? const Color(0xFF3A3A3A) : const Color(0xFFE3EAFF);
    final iconColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: fabColor, 
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: isDark ? Colors.black54 : Colors.black12, blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showMorphContent(context, type),
          child: Icon(icon, color: iconColor, size: 28), 
        ),
      ),
    );
  }

  void _showMorphContent(BuildContext context, int type) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: ScaleTransition(
            scale: anim1,
            alignment: type == 1
                ? Alignment.bottomLeft
                : (type == 2 ? Alignment.bottomCenter : Alignment.bottomRight),
            child: _buildDetailContent(context, type),
          ),
        );
      },
    );
  }

  Widget _buildDetailContent(BuildContext context, int type) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final contentBg = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE3EAFF);
    final titleColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);
    final textColor = isDark ? Colors.white : Colors.black;

    switch (type) {
      case 1:
        return Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.all(16),
            width: 180,
            child: Material(
              color: contentBg, 
              borderRadius: BorderRadius.circular(16),
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLinkItem(context, 'Link 1'),
                  _buildLinkItem(context, 'Link 2'),
                  _buildLinkItem(context, 'Link 3'),
                ],
              ),
            ),
          ),
        );
      case 2:
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Material(
              color: contentBg, 
              borderRadius: BorderRadius.circular(24),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Something',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: titleColor, 
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildLinkItem(context, 'Link 1'),
                    _buildLinkItem(context, 'Link 2'),
                    _buildLinkItem(context, 'Link 3'),
                    _buildLinkItem(context, 'Link 4'),
                  ],
                ),
              ),
            ),
          ),
        );
      case 3:
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: contentBg, 
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            elevation: 10,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomItem(context, Icons.mail, 'Inbox', true),
                  _buildBottomItem(context, Icons.event, 'Calender'),
                  _buildBottomItem(context, Icons.cloud_upload, 'Upload'),
                ],
              ),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildLinkItem(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14, color: isDark ? Colors.white : Colors.black)),
      trailing: Icon(Icons.chevron_right, size: 18, color: isDark ? Colors.white54 : Colors.black54),
      onTap: () {},
    );
  }

  Widget _buildBottomItem(BuildContext context, IconData icon, String label, [bool selected = false]) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = selected 
        ? (isDark ? Colors.blueAccent : const Color(0xFF142B6F)) 
        : (isDark ? Colors.white54 : Colors.black54);
        
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: color,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
// ===================================================================
// LIST INDEX PAGE
// ===================================================================

class ListIndexPage extends StatefulWidget {
  const ListIndexPage({super.key});

  @override
  State<ListIndexPage> createState() => _ListIndexPageState();
}

class _ListIndexPageState extends State<ListIndexPage> {
  final Map<String, List<String>> contacts = {
    'A': ['Aaron', 'Adam', 'Adele', 'Agnes', 'Albert', 'Alexander'],
    'B': ['Bailey', 'Barclay', 'Bartolo', 'Bellamy', 'Belle', 'Benjamin'],
    'C': ['Caiden', 'Calvin', 'Candy', 'Carl', 'Cherilyn', 'Chester', 'Chloe'],
    'D': ['Dakota', 'Daniel', 'Dante', 'Darius', 'David', 'Dominic'],
    'E': ['Edward', 'Eleanor', 'Elijah', 'Elizabeth', 'Ella', 'Emma'],
    'F': ['Fabian', 'Faith', 'Felicity', 'Felix', 'Fiona', 'Francis'],
    'G': ['Gabriel', 'Gavin', 'Gemma', 'George', 'Grace', 'Gregory'],
    'H': ['Hailey', 'Hannah', 'Harold', 'Harper', 'Harry', 'Hazel'],
    'I': ['Ian', 'Ida', 'Imogen', 'Isaac', 'Isabel', 'Isla'],
    'V': ['Vladimir'],
  };

  final ScrollController _scrollController = ScrollController();
  final List<String> _alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
  String? _selectedLetter;
  bool _showIndicator = false;

  void _scrollToSection(String letter) {
    if (!contacts.containsKey(letter)) return;

    setState(() {
      _selectedLetter = letter;
      _showIndicator = true;
    });

    double offset = 0;
    final keys = contacts.keys.toList()..sort();
    for (var key in keys) {
      if (key == letter) break;
      offset += 40;
      offset += (contacts[key]!.length * 56.0);
    }

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _showIndicator = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortedKeys = contacts.keys.toList()..sort();

    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final headerColor = isDark ? const Color(0xFF2C2C2C) : Colors.grey[100];
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);

    return Scaffold(
      backgroundColor: bgColor, 
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white, 
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'List Index',
          style: GoogleFonts.poppins(color: textColor, fontWeight: FontWeight.bold, fontSize: 18), 
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: sortedKeys.length,
            itemBuilder: (context, index) {
              String key = sortedKeys[index];
              List<String> items = contacts[key]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: headerColor, 
                    child: Text(
                      key,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: textColor),
                    ),
                  ),
                  ...items.map((name) => ListTile(
                        title: Text(name, style: GoogleFonts.poppins(fontSize: 16, color: textColor)), 
                        onTap: () {},
                      )),
                ],
              );
            },
          ),

          if (_showIndicator && _selectedLetter != null)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _selectedLetter!,
                  style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ),

          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _alphabet.map((letter) {
                    bool hasData = contacts.containsKey(letter);
                    return GestureDetector(
                      onVerticalDragUpdate: (_) => _scrollToSection(letter),
                      onTap: () => _scrollToSection(letter),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          letter,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: hasData ? navyColor : (isDark ? Colors.white24 : Colors.grey[400]), 
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ===================================================================
// SEARCHBAR PAGE
// ===================================================================

class SearchbarPage extends StatefulWidget {
  const SearchbarPage({super.key});

  @override
  State<SearchbarPage> createState() => _SearchbarPageState();
}

class _SearchbarPageState extends State<SearchbarPage> {

  final List<String> _allCars = [
    'Acura',
    'Audi',
    'BMW',
    'Cadillac',
    'Chevrolet',
    'Chrysler',
    'Dodge',
    'Ferrari',
    'Ford',
    'GMC',
    'Honda',
    'Hummer',
    'Hyundai',
    'Infiniti',
    'Isuzu',
    'Jaguar',
    'Jeep',
    'Kia',
    'Lamborghini',
    'Land Rover',
    'Lexus',
    'Lincoln',
    'Lotus',
    'Mazda',
    'Mercedes-Benz'
  ];

  List<String> filteredCars = [];

  @override
  void initState() {
    super.initState();
    filteredCars = _allCars;
  }

  void searchCars(String keyword) {
    setState(() {
      filteredCars = _allCars
          .where((car) =>
              car.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final searchBoxColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE9ECFB);

    return Scaffold(
      backgroundColor: bgColor, 

      appBar: AppBar(
        backgroundColor: appBarColor, 
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: textColor, 
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          "Searchbar",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textColor, 
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10, 
              right: 10,
              bottom: 8,
              top: 6,
            ),
            child: Container(
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 0),

              decoration: BoxDecoration(
                color: searchBoxColor, 
                borderRadius: BorderRadius.circular(14),
              ),

              child: TextField(
                onChanged: searchCars,
                style: GoogleFonts.poppins(color: textColor), 

                decoration: InputDecoration(
                  hintText: "Search",

                  hintStyle: GoogleFonts.poppins(
                    color: isDark ? Colors.white54 : Colors.grey, 
                    fontSize: 16,
                  ),

                  prefixIcon: Icon(
                    Icons.search,
                    color: isDark ? Colors.white70 : Colors.black, 
                    size: 22,
                  ),

                  border: InputBorder.none,

                  contentPadding: const EdgeInsets.only(
                    top: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.only(
          top: 18,
          left: 10,
          right: 10,
        ),

        itemCount: filteredCars.length,

        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 24,
            ),

            child: Text(
              filteredCars[index],

              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: textColor, 
              ),
            ),
          );
        },
      ),
    );
  }
}

// ===================================================================
// APPBAR PAGE
// ===================================================================

class AppbarPage extends StatelessWidget {
  const AppbarPage({super.key});

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor, 

      appBar: AppBar(
        backgroundColor: appBarColor, 
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          'Not found',
          style: GoogleFonts.poppins(
            color: textColor, 
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sorry\nRequested content not found.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.6,
                color: subTextColor, 
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ===================================================================
// APPBAR ELEVATION PAGE
// ===================================================================

class AppbarElevationPage extends StatelessWidget {
  const AppbarElevationPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor, 

      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          'Not found',
          style: GoogleFonts.poppins(
            color: textColor, 
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sorry\nRequested content not found.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.6,
                color: subTextColor, 
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
// ===================================================================
// GRID / LAYOUT PAGE
// ===================================================================

class GridLayoutPage extends StatelessWidget {
  const GridLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black87;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);
    final cellBgColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final borderColor = isDark ? Colors.white12 : const Color(0xFFE4E4E4);

    return Scaffold(
      backgroundColor: bgColor, 
      appBar: AppBar(
        backgroundColor: appBarColor, 
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Grid / Layout',
          style: GoogleFonts.poppins(
            color: textColor, 
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Columns within a row are automatically set to have equal width. Otherwise you can define your column with pourcentage of screen you want.',
              style: GoogleFonts.poppins(
                fontSize: 13,
                height: 1.6,
                color: subTextColor, 
              ),
            ),
            const SizedBox(height: 28),
            
            
            Text(
              'Columns with gap',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: navyColor, 
              ),
            ),
            const SizedBox(height: 16),
            _buildGridWithGap(cellBgColor, borderColor, isDark),
            const SizedBox(height: 32),
            
          
            Text(
              'No gap between columns',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: navyColor, 
              ),
            ),
            const SizedBox(height: 16),
            _buildGridNoGap(cellBgColor, borderColor, isDark),
            const SizedBox(height: 32),
            
            Text(
              'Responsive Grid',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: navyColor, 
              ),
            ),
            Text(
              'Grid cells have different size on Phone/Tablet',
              style: GoogleFonts.poppins(
                fontSize: 12,
                height: 1.5,
                color: subTextColor, 
              ),
            ),
            const SizedBox(height: 16),
            _buildResponsiveGrid(cellBgColor, borderColor, isDark),
          ],
        ),
      ),
    );
  }

  // Grid dengan gap
  Widget _buildGridWithGap(Color cellBg, Color border, bool isDark) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildGridCell('2 cols', cellBg, border, isDark)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('2 cols', cellBg, border, isDark)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildGridCell('4 cols', cellBg, border, isDark)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('4 cols', cellBg, border, isDark)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('4 cols', cellBg, border, isDark)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('4 cols', cellBg, border, isDark)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildGridCell('3 cols', cellBg, border, isDark)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('3 cols', cellBg, border, isDark)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('3 cols', cellBg, border, isDark)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildGridCell('5 cols', cellBg, border, isDark, fontSize: 11)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('5 cols', cellBg, border, isDark, fontSize: 11)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('5 cols', cellBg, border, isDark, fontSize: 11)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('5 cols', cellBg, border, isDark, fontSize: 11)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('5 cols', cellBg, border, isDark, fontSize: 11)),
          ],
        ),
      ],
    );
  }


  Widget _buildGridNoGap(Color cellBg, Color border, bool isDark) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 2, child: _buildGridCellNoGap('2 cols', cellBg, border, isDark)),
            Expanded(flex: 2, child: _buildGridCellNoGap('2 cols', cellBg, border, isDark)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildGridCellNoGap('4 cols', cellBg, border, isDark)),
            Expanded(child: _buildGridCellNoGap('4 cols', cellBg, border, isDark)),
            Expanded(child: _buildGridCellNoGap('4 cols', cellBg, border, isDark)),
            Expanded(child: _buildGridCellNoGap('4 cols', cellBg, border, isDark)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildGridCellNoGap('3 cols', cellBg, border, isDark)),
            Expanded(child: _buildGridCellNoGap('3 cols', cellBg, border, isDark)),
            Expanded(child: _buildGridCellNoGap('3 cols', cellBg, border, isDark)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildGridCellNoGap('5 cols', cellBg, border, isDark, fontSize: 10)),
            Expanded(child: _buildGridCellNoGap('5 cols', cellBg, border, isDark, fontSize: 10)),
            Expanded(child: _buildGridCellNoGap('5 cols', cellBg, border, isDark, fontSize: 10)),
            Expanded(child: _buildGridCellNoGap('5 cols', cellBg, border, isDark, fontSize: 10)),
            Expanded(child: _buildGridCellNoGap('5 cols', cellBg, border, isDark, fontSize: 10)),
          ],
        ),
      ],
    );
  }

  
  Widget _buildResponsiveGrid(Color cellBg, Color border, bool isDark) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildGridCell('1 col / medium\n2 cols', cellBg, border, isDark, fontSize: 11)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('1 col / medium\n2 cols', cellBg, border, isDark, fontSize: 11)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildGridCell('2 col / medium\n4 cols', cellBg, border, isDark, fontSize: 10)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('2 col / medium\n4 cols', cellBg, border, isDark, fontSize: 10)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('2 col / medium\n4 cols', cellBg, border, isDark, fontSize: 10)),
            const SizedBox(width: 12),
            Expanded(child: _buildGridCell('2 col / medium\n4 cols', cellBg, border, isDark, fontSize: 10)),
          ],
        ),
      ],
    );
  }

 
  Widget _buildGridCell(String text, Color cellBg, Color border, bool isDark, {double fontSize = 13}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: border, width: 1),
        color: cellBg, 
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            color: isDark ? Colors.white60 : const Color(0xFF757575), 
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  
  Widget _buildGridCellNoGap(String text, Color cellBg, Color border, bool isDark, {double fontSize = 13}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: cellBg, 
        border: Border.all(color: border, width: 0.5), 
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            color: isDark ? Colors.white60 : const Color(0xFF757575), 
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// ===================================================================
// APPBAR LAZY LOAD PAGE 
// ===================================================================

class AppbarLazyLoadPage extends StatelessWidget {
  const AppbarLazyLoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor, 

      appBar: AppBar(
        backgroundColor: appBarColor, 
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          'Not found',
          style: GoogleFonts.poppins(
            color: textColor, 
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sorry\nRequested content not found.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.6,
                color: subTextColor, 
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
// ===================================================================
// MENU 
// ===================================================================
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});
  
  @override
  Widget build(BuildContext context) {
   
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor, 

      appBar: AppBar(
        backgroundColor: appBarColor, 
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          'Not found',
          style: GoogleFonts.poppins(
            color: textColor, 
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sorry\nRequested content not found.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.6,
                color: subTextColor, 
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
// ===================================================================
// TOGGLE PAGE 
// ===================================================================

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  final Map<String, bool> _toggleStates = {
    'Batman': true,
    'Aquaman': true,
    'Superman': true,
    'Hulk': false,
    'Spiderman': false,
    'Ironman': true,
    'Thor': true,
    'Wonder': false,
  };

  
  Color _getToggleColor(String name) {
    switch (name) {
      case 'Batman': return Colors.black;
      case 'Aquaman': return Colors.blue;
      case 'Superman': return Colors.red;
      case 'Hulk': return Colors.green;
      case 'Spiderman': return Colors.orange;
      case 'Ironman': return Colors.redAccent;
      case 'Thor': return Colors.blueAccent;
      case 'Wonder': return Colors.purple;
      default: return const Color(0xFF4CD964);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final sectionBgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F7);
    final itemBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);
    final borderColor = isDark ? Colors.white10 : const Color(0xFFE4E4E4);

    return Scaffold(
      backgroundColor: bgColor, 

      appBar: AppBar(
        backgroundColor: appBarColor, 
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          'Toggle',
          style: GoogleFonts.poppins(
            color: textColor, 
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Super Heroes',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: navyColor, 
                ),
              ),
            ),

            
            Container(
              color: sectionBgColor, 
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _toggleStates.length,

                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 0.5,
                  indent: 16,
                  endIndent: 16,
                  color: borderColor, 
                ),

                itemBuilder: (context, index) {
                  String heroName = _toggleStates.keys.toList()[index];
                  bool isEnabled = _toggleStates[heroName]!;

                  return Container(
                    color: itemBgColor, 
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          heroName,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: textColor,
                          ),
                        ),

                        // Toggle
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _toggleStates[heroName] =
                                  !_toggleStates[heroName]!;
                            });
                          },

                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 52,
                            height: 32,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: isEnabled
                                  ? _getToggleColor(heroName)
                                  : (isDark ? Colors.white12 : const Color(0xFFD1D1D6)), 
                            ),

                            child: Stack(
                              children: [
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  left: isEnabled ? 22 : 2,
                                  top: 2,

                                  child: Container(
                                    width: 28,
                                    height: 28,

                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  // ===================================================================
  // WARNA TOGGLE 
  // ===================================================================

  Color _getToggleColor(String heroName) {
    switch (heroName) {
      case 'Batman':
        return const Color(0xFF142B6F);
      case 'Aquaman':
        return const Color(0xFF0099FF);
      case 'Superman':
        return const Color(0xFFFF0000);
      case 'Hulk':
        return const Color(0xFF4CAF50); 
      case 'Spiderman':
        return const Color(0xFFBDBDBD); 
      case 'Ironman':
        return const Color(0xFF142B6F);
      case 'Thor':
        return const Color(0xFF8B5A00);
      case 'Wonder':
        return const Color(0xFFFF0000); 
      default:
        return const Color(0xFF142B6F);
    }
  }


/// ===================================================================
// RADIO PAGE 
// ===================================================================

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  String selectedGroup = 'Books';
  String selectedRight = 'Books';
  int selectedMedia = 0;
  int inlineValue = 0;

  @override
  Widget build(BuildContext context) {
 
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;
    final sectionBgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF2F2F7);
    final itemBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF142B6F);
    final dividerColor = isDark ? Colors.white10 : Colors.black12;

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: appBarColor, 
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Radio',
          style: GoogleFonts.poppins(
            color: textColor, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Inline',
              style: GoogleFonts.poppins(
                color: navyColor, 
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('Lorem ', style: GoogleFonts.poppins(fontSize: 13, color: textColor)),

                Radio<int>(
                  value: 1,
                  groupValue: inlineValue,
                  onChanged: (v) => setState(() => inlineValue = v!),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: navyColor,
                ),

                Text(
                  ' ipsum dolor sit amet, consectetur adipisicing elit. Alias beatae illo nihil aut eius commodi sint eveniet aliquid eligendi ',
                  style: GoogleFonts.poppins(fontSize: 13, color: textColor),
                ),

                Radio<int>(
                  value: 2,
                  groupValue: inlineValue,
                  onChanged: (v) => setState(() => inlineValue = v!),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  activeColor: navyColor,
                ),

                Text(
                  ' ad delectus impedit tempore nemo, enim vel praesentium consequatur nulla mollitia!',
                  style: GoogleFonts.poppins(fontSize: 13, color: textColor),
                ),
              ],
            ),

            const SizedBox(height: 28),

            Text(
              'Radio Group',
              style: GoogleFonts.poppins(
                color: navyColor, 
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            Column(
              children: ['Books', 'Movies', 'Food', 'Drinks']
                  .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: item,
                              groupValue: selectedGroup,
                              onChanged: (value) {
                                setState(() => selectedGroup = value!);
                              },
                              activeColor: navyColor, 
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            Text(
                              item,
                              style: GoogleFonts.poppins(fontSize: 14, color: textColor),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 28),

            Container(
              color: sectionBgColor, 
              child: Column(
                children: ['Books', 'Movies', 'Food', 'Drinks']
                    .map((item) => Column(
                          children: [
                            Container(
                              color: itemBgColor, 
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item,
                                    style: GoogleFonts.poppins(fontSize: 14, color: textColor),
                                  ),
                                  Radio<String>(
                                    value: item,
                                    groupValue: selectedRight,
                                    onChanged: (value) {
                                      setState(() =>
                                          selectedRight = value!);
                                    },
                                    activeColor: navyColor, 
                                  ),
                                ],
                              ),
                            ),
                            Divider(height: 1, color: dividerColor),
                          ],
                        ))
                    .toList(),
              ),
            ),

            const SizedBox(height: 28),

            
            Text(
              'With Media Lists',
              style: GoogleFonts.poppins(
                color: navyColor, 
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            Column(
              children: List.generate(4, (index) {
                bool isFacebook = index % 2 == 0;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Radio(
                        value: index,
                        groupValue: selectedMedia,
                        onChanged: (value) {
                          setState(() => selectedMedia = value!);
                        },
                        activeColor: navyColor, 
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                           
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isFacebook
                                      ? 'Facebook'
                                      : 'John Doe (via Twitter)',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                ),
                                Text(
                                  ['17:14', '17:11', '16:48', '15:32']
                                      [index],
                                  style: GoogleFonts.poppins(fontSize: 12, color: subTextColor),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            // SUBTITLE 
                            Text(
                              isFacebook
                                  ? 'New messages from John Doe'
                                  : 'John Doe (@_johndoe) mentioned you on Twitter!',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: textColor, 
                              ),
                            ),

                            const SizedBox(height: 4),

                            // DESCRIPTION
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sagittis tellus ut turpis condimentum, ut dignissim lacus tincidunt. Cras dolor metus, ultrices condimentum sodales sit amet.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: subTextColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// HALAMAN FLOATING ACTION BUTTON 
// =============================================================

class FabPage extends StatefulWidget {
  const FabPage({super.key});

  @override
  State<FabPage> createState() => _FabPageState();
}

class _FabPageState extends State<FabPage> {
  int _activeType = 0; 
  bool _isOpen = false;

  final Color _biruSoftOriginal = const Color(0xFFE3EAFF); 
  final Color _biruTuaOriginal = const Color(0xFF142B6F);

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final appBarColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    
    
    final dynamicFabBg = isDark ? const Color(0xFF2C2C2C) : _biruSoftOriginal;
    final dynamicFabIcon = isDark ? Colors.blueAccent : _biruTuaOriginal;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: appBarColor, 
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), 
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Floating Action Button',
          style: GoogleFonts.poppins(
            color: textColor, 
            fontWeight: FontWeight.bold, 
            fontSize: 18
          ),
        ),
      ),
      body: Stack(
        children: [
         
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(15, (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sape, quo rem beatae, delectus eligendi est saepe molestias perferendis suscipit, commodi labore ipsa non quasi eum magnam neque ducimus!",
                  style: GoogleFonts.poppins(
                    fontSize: 14, 
                    height: 1.6, 
                    color: isDark ? Colors.white70 : Colors.black87 
                  ),
                  textAlign: TextAlign.justify,
                ),
              )),
            ),
          ),

      
          if (_isOpen)
            GestureDetector(
              onTap: () => setState(() => _isOpen = false),
              child: Container(color: Colors.transparent),
            ),

        
          if (_isOpen) _buildNumberMenu(dynamicFabBg, dynamicFabIcon, isDark),

          Positioned(left: 16, top: 16, child: _buildMainFAB(1, dynamicFabBg, dynamicFabIcon)),
          Positioned(right: 16, top: 16, child: _buildMainFAB(2, dynamicFabBg, dynamicFabIcon)),
          Positioned(left: 16, bottom: 16, child: _buildMainFAB(3, dynamicFabBg, dynamicFabIcon)),
          Positioned(right: 16, bottom: 16, child: _buildMainFAB(4, dynamicFabBg, dynamicFabIcon)),

      
          Center(child: _buildMainFAB(6, dynamicFabBg, dynamicFabIcon)),

         
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: FloatingActionButton.extended(
                heroTag: 'fab_create',
                backgroundColor: dynamicFabBg, 
                onPressed: () => setState(() => _isOpen = false),
                icon: Icon(Icons.add, color: dynamicFabIcon), 
                label: Text(
                  'Create', 
                  style: GoogleFonts.poppins(
                    color: dynamicFabIcon, 
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainFAB(int type, Color bgColor, Color iconColor) {
    bool isCurrentOpen = _isOpen && _activeType == type;

    return FloatingActionButton(
      heroTag: 'fab_type_$type',
      backgroundColor: bgColor, 
      mini: true,
      elevation: 2,
      onPressed: () => setState(() { 
        if (_activeType == type && _isOpen) {
          _isOpen = false;
        } else {
          _activeType = type; 
          _isOpen = true;
        }
      }),
      child: Icon(
        isCurrentOpen ? Icons.close : Icons.add, 
        color: iconColor 
      ),
    );
  }

  Widget _buildNumberMenu(Color bgColor, Color iconColor, bool isDark) {
    switch (_activeType) {
      case 1:
        return Positioned(left: 16, top: 65, child: Column(children: [_buildNumCircle("1", bgColor, iconColor), const SizedBox(height: 8), _buildNumCircle("2", bgColor, iconColor), const SizedBox(height: 8), _buildNumCircle("3", bgColor, iconColor)]));
      case 2:
        return Positioned(right: 65, top: 16, child: Row(children: [_buildNumCircle("3", bgColor, iconColor), const SizedBox(width: 8), _buildNumCircle("2", bgColor, iconColor), const SizedBox(width: 8), _buildNumCircle("1", bgColor, iconColor)]));
      case 3:
        return Positioned(left: 16, bottom: 65, child: Column(verticalDirection: VerticalDirection.up, children: [_buildNumCircle("1", bgColor, iconColor), const SizedBox(height: 8), _buildNumCircle("2", bgColor, iconColor), const SizedBox(height: 8), _buildNumCircle("3", bgColor, iconColor)]));
      
      case 4: 
        return Positioned(
          right: 16, 
          bottom: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end, 
            verticalDirection: VerticalDirection.up,
            children: [
              _buildNumWithLabel("1", "Action 1", bgColor, iconColor, isDark),
              const SizedBox(height: 12),
              _buildNumWithLabel("2", "Action 2", bgColor, iconColor, isDark),
              const SizedBox(height: 12),
              _buildNumWithLabel("3", "Third Action", bgColor, iconColor, isDark),
            ],
          ),
        );

      case 6: 
        return Center(child: SizedBox(width: 140, height: 140, child: Stack(children: [
          Align(alignment: Alignment.topCenter, child: _buildNumCircle("1", bgColor, iconColor)),
          Align(alignment: Alignment.centerRight, child: _buildNumCircle("2", bgColor, iconColor)),
          Align(alignment: Alignment.bottomCenter, child: _buildNumCircle("3", bgColor, iconColor)),
          Align(alignment: Alignment.centerLeft, child: _buildNumCircle("4", bgColor, iconColor)),
        ])));
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildNumCircle(String text, Color bgColor, Color iconColor) {
    return Container(
      width: 35, height: 35,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1))]),
      child: Center(child: Text(text, style: TextStyle(color: iconColor, fontWeight: FontWeight.bold, fontSize: 14))),
    );
  }

  Widget _buildNumWithLabel(String num, String label, Color bgColor, Color iconColor, bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1))]
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: isDark ? Colors.white : Colors.black, 
              fontSize: 12, 
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        const SizedBox(width: 12),
        _buildNumCircle(num, bgColor, iconColor),
      ],
    );
  }
}