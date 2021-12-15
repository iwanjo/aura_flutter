import 'package:aura_flutter/component/create_support_space.dart';
import 'package:aura_flutter/component/new_space.dart';
import 'package:aura_flutter/component/support_space_view.dart';
import 'package:aura_flutter/views/support_space_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SupportSpaces extends StatefulWidget {
  final String? uid;
  const SupportSpaces({Key? key, this.uid}) : super(key: key);

  @override
  _SupportSpacesState createState() => _SupportSpacesState();
}

class _SupportSpacesState extends State<SupportSpaces>
    with TickerProviderStateMixin {
  final box = Container(
    height: 44,
    width: 44,
    decoration: BoxDecoration(
      color: const Color(0xff9f2940),
      borderRadius: BorderRadius.all(
        Radius.circular(9),
      ),
    ),
    child: Icon(Icons.search, color: Colors.white),
  );
  @override
  Widget build(BuildContext context) {
    TabController _spaceTabBarController =
        TabController(length: 4, vsync: this);

    spaceCard(NewSpace attribute) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SupportSpaceInfo(
                      spaceName: attribute.spaceName,
                      spaceDescription: attribute.spaceDescription,
                      spaceImg: attribute.logo,
                      spaceCategory: attribute.spaceCategory)));
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                leading: Image.network(
                  attribute.logo,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  attribute.spaceName,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .3,
                  ),
                ),
                subtitle: Text(
                  attribute.spaceCategory,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 13.0,
                    letterSpacing: .1,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfff7f7f7),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset("assets/aura.png",
              fit: BoxFit.contain, height: 26.0, width: 26.0),
          centerTitle: true,
          actions: <Widget>[]),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Text(
              "Browse our community spaces",
              style: GoogleFonts.nunitoSans(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .3),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 44.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color(0xffebebeb),
              ),
              child: Stack(
                children: <Widget>[
                  TextField(
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    style: GoogleFonts.nunitoSans(
                        fontSize: 14.0, letterSpacing: .2),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: const Color(0xffebebeb),
                      filled: true,
                      hintText: 'Search for support spaces',
                      hintStyle: GoogleFonts.nunitoSans(
                          color: Colors.grey,
                          fontSize: 15.0,
                          letterSpacing: .3),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(width: 3, color: Colors.grey.shade200),
                      ),
                    ),
                  ),
                  Positioned(child: box, right: 0, top: 0),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 25.0,
              child: TabBar(
                controller: _spaceTabBarController,
                isScrollable: true,
                labelColor: Colors.white,
                labelStyle: GoogleFonts.nunitoSans(
                    fontSize: 13.0,
                    letterSpacing: .3,
                    fontWeight: FontWeight.w600),
                unselectedLabelColor: Colors.grey,
                indicator: RectangularIndicator(
                    color: const Color(0xff9f2940),
                    bottomLeftRadius: 5,
                    bottomRightRadius: 5,
                    paintingStyle: PaintingStyle.fill),
                tabs: [
                  Tab(text: "All"),
                  Tab(text: "Health"),
                  Tab(text: "Addiction"),
                  Tab(text: "Financial"),
                ],
              ),
            ),
            Container(
              height: 1300,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: TabBarView(
                controller: _spaceTabBarController,
                children: [
                  FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("supportSpaces")
                          .get(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> spaceMap =
                                    snapshot.data!.docs[index].data();

                                NewSpace attribute = NewSpace(
                                  spaceMap['logoUrl'],
                                  spaceMap['spaceName'],
                                  spaceMap['spaceCategory'],
                                  spaceMap['spaceDescription'],
                                );
                                return spaceCard(attribute);
                              });
                        } else if (snapshot.connectionState ==
                            ConnectionState.none) {
                          return Text("Sorry, there was an error");
                        }
                        return Text("Loading Information...");
                      }),
                  healthSpacesView(),
                  addictionSpacesView(),
                  financialSpacesView(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: const Color(0xff9f2940),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CreateSupportSpace()),
          );
        },
      ),
    );
  }

  allSpacesView() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          SupportSpaceView(
            spaceImg: "https://cdn-icons-png.flaticon.com/512/706/706164.png",
            spaceName: "Healthy Living",
            spaceCategory: "Health",
            spaceDescription:
                "We are an open community of all people who are keen on embracing healthy living habits and changing their perspective on diet and exercise.",
          ),
          SizedBox(
            height: 24,
          ),
          SupportSpaceView(
            spaceImg: "https://cdn-icons-png.flaticon.com/512/2933/2933116.png",
            spaceName: "Financial Growth",
            spaceCategory: "Financial",
            spaceDescription:
                "Welcome to Financial Growth. This support space exists to share stories of carefully managing one's finances, ethically growing one's money and great investment topics.",
          ),
          SizedBox(
            height: 24,
          ),
          SupportSpaceView(
            spaceImg: "https://cdn-icons-png.flaticon.com/512/2964/2964514.png",
            spaceName: "Fitness Faction",
            spaceDescription:
                "This is Fitness Faction. Feel free to join our community. We know how hard it is to maintain a consistent health and fitness regiment. That's why we created this support space, to help motivate all among us to keep going and surpass our limits.",
            spaceCategory: "Health",
          ),
          SizedBox(
            height: 24,
          ),
          SupportSpaceView(
            spaceName: "For Sobriety",
            spaceCategory: "Addiction",
            spaceDescription:
                "Beating an addiction is hard without support or guidance. For Sobriety is a group dedicated to ensuring we can all beat the odds and become sober with an extensive support unit.",
            spaceImg: "https://cdn-icons-png.flaticon.com/512/6397/6397250.png",
          ),
        ],
      ),
    );
  }

  financialSpacesView() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          SupportSpaceView(
            spaceImg: "https://cdn-icons-png.flaticon.com/512/2933/2933116.png",
            spaceName: "Financial Growth",
            spaceCategory: "Financial",
            spaceDescription:
                "Welcome to Financial Growth. This support space exists to share stories of carefully managing one's finances, ethically growing one's money and great investment topics.",
          ),
        ],
      ),
    );
  }

  healthSpacesView() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          SupportSpaceView(
            spaceImg: "https://cdn-icons-png.flaticon.com/512/706/706164.png",
            spaceName: "Healthy Living",
            spaceCategory: "Health",
            spaceDescription:
                "We are an open community of all people who are keen on embracing healthy living habits and changing their perspective on diet and exercise.",
          ),
          SizedBox(
            height: 24,
          ),
          SupportSpaceView(
            spaceImg: "https://cdn-icons-png.flaticon.com/512/2964/2964514.png",
            spaceName: "Fitness Faction",
            spaceDescription:
                "This is Fitness Faction. Feel free to join our community. We know how hard it is to maintain a consistent health and fitness regiment. That's why we created this support space, to help motivate all among us to keep going and surpass our limits.",
            spaceCategory: "Health",
          ),
        ],
      ),
    );
  }

  addictionSpacesView() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          SupportSpaceView(
            spaceName: "For Sobriety",
            spaceCategory: "Addiction",
            spaceDescription:
                "Beating an addiction is hard without support or guidance. For Sobriety is a group dedicated to ensuring we can all beat the odds and become sober with an extensive support unit.",
            spaceImg: "https://cdn-icons-png.flaticon.com/512/6397/6397250.png",
          ),
        ],
      ),
    );
  }
}
