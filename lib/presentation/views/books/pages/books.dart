import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/shimmers/adresse_shimmer.dart';
import 'package:sunofa_map/common/widgets/text/notfound_text.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/books/bloc/book_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/book_state.dart';
import 'package:sunofa_map/presentation/views/books/pages/add_adresse_book.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({
    super.key,
    this.user,
  });
  final UserEntity? user;

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          "Mes Adresses Book",
          style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
        ),
        actions: const [
          AppBarAddwidget(
            widget: AddAdresseBook(),
          ),
        ],
      ),
      body: SizedBox(
        child: BlocBuilder<BookCubit, BookState>(
          builder: (context, state) {
            if (state is BookSuccessState) {
              if (state.books.isEmpty) {
                return const NotFoundText(
                  text: "Aucune adresse disponible",
                );
              }
              // final userAdresses = state.adresses.where(
              //                 (ad) => ad.user.id == user!.id,
              //               )
              //               .toList();
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<BookCubit>().getBooks();
                  setState(() {});
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 0,
                  ),
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    final adresse = state.books[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) {
                        //       return EditAdresseScreen(
                        //         adresse: adresse,
                        //       );
                        //     },
                        //   ),
                        // );
                      },
                      child: Container(
                        height: context.width / 3,
                        margin: EdgeInsets.only(
                          bottom: 20,
                          top: index == 0 ? 20 : 0,
                        ),
                        decoration: BoxDecoration(
                          color: mgrey[100],
                          border: Border.all(color: AppTheme.primaryColor),
                          borderRadius: BorderRadiusDirectional.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    index == 0
                                        ? "assets/villa.jpg"
                                        : index == 1
                                            ? "assets/villa4.jpg"
                                            : "assets/villa5.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      adresse.addressLabel,
                                      style: AppTheme().stylish1(20, mblack),
                                    ),
                                    Text(
                                      adresse.personName,
                                      style: AppTheme().stylish1(16, mgrey),
                                    ),
                                    Text(
                                      adresse.apartmentSuiteNote,
                                      style: AppTheme().stylish1(
                                        13,
                                        mgrey,
                                      ),
                                    ),
                                    Text(
                                      Helpers().timeAgo(
                                        DateTime.parse(
                                          adresse.createdAt!.datetime,
                                        ),
                                      ),
                                      style: AppTheme().stylish1(
                                        13,
                                        mgrey,
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
                  },
                ),
              );
            } else {
              return const AdresseShimmer();
            }
          },
        ),
      ),
    );
  }
}

class AppBarAddwidget extends StatelessWidget {
  const AppBarAddwidget({
    super.key,
    required this.widget,
  });
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return widget;
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 10,
        ),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: mwhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            HeroIcon(
              HeroIcons.plusCircle,
              color: AppTheme.primaryColor,
            ),
            SizedBox(width: 5),
            Text(
              "Add",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
