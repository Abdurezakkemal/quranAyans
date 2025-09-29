import 'package:flutter/material.dart';
import 'services/quran_service.dart';
import 'models/ayah.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran Ayahs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          color: Colors.white,
        ),
      ),
      home: QuranAyahsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuranAyahsPage extends StatefulWidget {
  QuranAyahsPage({super.key});

  @override
  State<QuranAyahsPage> createState() => _QuranAyahsPageState();
}

class _QuranAyahsPageState extends State<QuranAyahsPage> {
  QuranService quranService = QuranService();

  Ayah? currentAyah;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getNewAyah();
  }

  // get new ayah from api
  void getNewAyah() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      ApiResponse response = await quranService.getRandomAyah();
      setState(() {
        currentAyah = response.data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load verse';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran Ayahs'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        shadowColor: Colors.black12,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Main Content
              Expanded(child: buildContent()),

              // Control Buttons
              SizedBox(height: 16),
              buildControlButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // build button
  Widget buildControlButtons() {
    return Container(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : getNewAyah,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.refresh_rounded),
            SizedBox(width: 8),
            Text('Get New Verse'),
          ],
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          side: BorderSide(color: Colors.black, width: 1),
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }

  // build main content
  Widget buildContent() {
    if (isLoading) {
      return buildLoadingWidget();
    }

    if (errorMessage != null && errorMessage!.isNotEmpty) {
      return buildErrorWidget();
    }

    if (currentAyah != null) {
      return buildAyahWidget();
    }

    return Center(child: Text('No data available'));
  }

  // show loading
  Widget buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black12, width: 1),
            ),
            child: Column(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  strokeWidth: 2,
                ),
                SizedBox(height: 16),
                Text(
                  'Loading verse...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // show error
  Widget buildErrorWidget() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(Icons.error_outline, color: Colors.black, size: 24),
            ),
            const SizedBox(height: 24),
            Text(
              'Error',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Unable to load verse',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: getNewAyah,
                icon: Icon(Icons.refresh_rounded),
                label: Text('Try Again'),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // show ayah
  Widget buildAyahWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Surah Information Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Text(
                    currentAyah!.surah.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'آية ' + currentAyah!.numberInSurah.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Arabic Text
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                currentAyah!.text,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 24,
                  height: 2.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildAdditionalInfo('Juz', currentAyah!.juz.toString()),
                      buildAdditionalInfo('Page', currentAyah!.page.toString()),
                      buildAdditionalInfo(
                        'Verse',
                        currentAyah!.number.toString(),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      currentAyah!.surah.revelationType + ' Period',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
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

  Widget buildAdditionalInfo(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
