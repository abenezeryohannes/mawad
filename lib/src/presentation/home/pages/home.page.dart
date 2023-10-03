import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/presentation/home/cards/home.tab.cards.dart';
import 'package:mawad/src/presentation/home/cards/product.card.dart';
import 'package:mawad/src/presentation/home/pages/change.country.bottom.sheet.dart';

import '../../../appcore/widgets/text.input.form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    floating: true,
                    iconTheme: const IconThemeData(size: 0),
                    leadingWidth: 0,
                    leading: null,
                    collapsedHeight: 164,
                    expandedHeight: 228,
                    forceElevated: innerBoxIsScrolled,
                    flexibleSpace: FlexibleSpaceBar(
                      title: _appBarBackground(),
                      titlePadding: EdgeInsets.zero,
                      expandedTitleScale: 1,
                      background: _appBar(),
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                child: _body(context),
              )),
        ));
  }

  Widget _appBarBackground() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextInputForm(
                controller: searchController,
                placeholder: 'This is the placeholder',
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).highlightColor,
                    fontWeight: FontWeight.bold),
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).highlightColor,
                ),
                contentPadding: const EdgeInsets.only(top: 10),
                elevation: 0.5,
                onChanged: (val) {
                  setState(() {
                    search = val;
                  });
                }),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView.builder(
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return const HomeTabCards();
                }),
          )
        ],
      ),
    );
  }

  Widget _appBar() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'This is the title',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () => context
                        .pushTransparentRoute(const ChangeCountryBottomSheet()),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          'assets/icon/flag.png',
                          width: 32,
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.asset(
              'assets/icon/banner.png',
              fit: BoxFit.cover,
              height: 150,
              width: MediaQuery.of(context).size.width * (11 / 12),
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 0.68,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: const ProductCard(),
              );
            }),
          ),
        )
      ],
    );
  }
}
