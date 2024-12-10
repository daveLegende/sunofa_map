class NoteModel {
  final String title;
  final String desc;

  const NoteModel({
    required this.title,
    required this.desc,
  });

  // factory NoteModel.fromJson(Map)
}

List<NoteModel> noteList = [
  const NoteModel(
    title: "RDV Chez Nous",
    desc:
        "Mercredi : Conférence de presse\n Jeudi : Institut français \nVendredi : Parade + prestations ",
  ),
  const NoteModel(
    title: "PROGRAMME DE CE LUNDI",
    desc:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ",
  ),
  const NoteModel(
    title: "LOREM IPSUM",
    desc:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  ),
];
