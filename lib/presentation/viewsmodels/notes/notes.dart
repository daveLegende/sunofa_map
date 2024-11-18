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
    title: "RDV Chez Nous",
    desc:
        "Mercredi : Conférence de presse\n Jeudi : Institut français \nVendredi : Parade + prestations ",
  ),
  const NoteModel(
    title: "RDV Chez Nous",
    desc:
        "Mercredi : Conférence de presse\n Jeudi : Institut français \nVendredi : Parade + prestations ",
  ),
];
