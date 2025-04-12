import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/common/widgets/shimmers/adresse_shimmer.dart';
import 'package:sunofa_map/common/widgets/text/notfound_text.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/addresses/widgets/show_delete.dart';
import 'package:sunofa_map/presentation/views/books/bloc/book_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/book_state.dart';
import 'package:sunofa_map/presentation/views/books/bloc/delete/delete_book_cubit.dart';
import 'package:sunofa_map/presentation/views/books/bloc/delete/delete_book_state.dart';
import 'package:sunofa_map/presentation/views/books/pages/add_adresse_book.dart';
import 'package:sunofa_map/presentation/views/books/pages/edit_book.dart';
import 'package:sunofa_map/presentation/views/editAdresse/pages/edit_adresse.dart';
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
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: mwhite,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppTheme.primaryColor,
            title: Text(
              "book.appbar".tr(),
              style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
            ),
            // actions: const [
            //   AppBarAddwidget(
            //     widget: AddAdresseBook(),
            //   ),
            // ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: FloatingActionButton(
              clipBehavior: Clip.hardEdge,
              backgroundColor: AppTheme.primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddAdresseBook(),
                  ),
                );
              },
              child: const HeroIcon(
                HeroIcons.plus,
                color: mwhite,
                size: 30,
                style: HeroIconStyle.micro,
              ),
            ),
          ),
          body: SizedBox(
            child: BlocListener<DeleteBookCubit, DeleteBookState>(
              listener: (context, stat) {
                if (stat is DeleteBookFailedState) {
                  Helpers().toast(message: stat.message);
                } else if (stat is DeleteBookSuccessState) {
                  context.read<BookCubit>().getBooks();
                }
              },
              child: BlocBuilder<BookCubit, BookState>(
                builder: (context, state) {
                  if (state is BookSuccessState) {
                    if (state.books.isEmpty) {
                      return NotFoundText(
                        text: "book.book_empty".tr(),
                      );
                    }
                    // final userAdresses = state.adresses.where(
                    //                 (ad) => ad.user.id == user!.id,
                    //               )
                    //               .toList();
                    return RefreshIndicator(
                      color: AppTheme.primaryColor,
                      backgroundColor: mwhite,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return EditBookScreen(
                                      book: adresse,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: EdgeInsets.only(
                                bottom: 20,
                                top: index == 0 ? 20 : 0,
                              ),
                              child: Container(
                                height: context.width / 3,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: mwhite,
                                  borderRadius: BorderRadius.circular(
                                      20), // Doit correspondre au shape de la Card
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            adresse.personName,
                                            style:
                                                AppTheme().stylish1(20, mblack),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            adresse.addressLabel,
                                            style:
                                                AppTheme().stylish1(16, mgrey),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            adresse.apartmentSuiteNote,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return EditBookScreen(
                                                    book: adresse,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: mgrey[200],
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.edit,
                                                color: AppTheme.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (_) {
                                                return DeleteAdresseWidget(
                                                  size: MediaQuery.of(context)
                                                      .size,
                                                  onDel: () async {
                                                    Navigator.pop(context);
                                                    // Afficher un indicateur de progression
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (context) =>
                                                          const LoadingCircle(),
                                                    );

                                                    try {
                                                      // Exécuter la suppression
                                                      await context
                                                          .read<
                                                              DeleteBookCubit>()
                                                          .deleteBook(
                                                            IdParms(
                                                              id: adresse.id!,
                                                            ),
                                                          );
                                                    } finally {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  onCancel: () {
                                                    Navigator.pop(_);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: mgrey[200],
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: const Center(
                                              child: HeroIcon(
                                                HeroIcons.trash,
                                                color: mred,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
          ),
        );
      },
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
        child: Row(
          children: [
            const HeroIcon(
              HeroIcons.plusCircle,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(width: 5),
            Text(
              "book.add".tr(),
              style: const TextStyle(
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
