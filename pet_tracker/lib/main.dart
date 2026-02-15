import 'package:flutter_localizations/flutter_localizations.dart';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class T {

static String chooseFromGallery(BuildContext context) =>
    isID(context) ? 'Pilih dari galeri' : 'Choose from Gallery';

static String cancel(BuildContext context) =>
    isID(context) ? 'Batal' : 'Cancel';

static String type(BuildContext context) =>
    isID(context) ? 'Tipe' : 'Type';

static String startTime(BuildContext context) =>
    isID(context) ? 'Waktu mulai' : 'Start time';

static String endTime(BuildContext context) =>
    isID(context) ? 'Waktu selesai' : 'End time';

static String delete(BuildContext context) =>
    isID(context) ? 'Hapus' : 'Delete';

static String takePhoto(BuildContext context) =>
    isID(context) ? 'Ambil foto' : 'Take photo';

static String chooseGallery(BuildContext context) =>
    isID(context) ? 'Pilih dari galeri' : 'Choose from gallery';

static String proTitle(BuildContext context) =>
    'Pet Tracker Pro';

static String proDescription(BuildContext context) =>
    isID(context)
        ? 'Buka banyak hewan dan fitur lanjutan.'
        : 'Unlock multiple pets and advanced features.';

static String later(BuildContext context) =>
    isID(context) ? 'Nanti' : 'Later';

static String unlockPro(BuildContext context) =>
    isID(context) ? 'Buka Pro' : 'Unlock Pro';

static String notSet(BuildContext context) =>
  isID(context) ? 'Belum diatur' : 'Not set';

static String speciesDog(BuildContext context) =>
  isID(context) ? 'Anjing' : 'Dog';

static String speciesCat(BuildContext context) =>
  isID(context) ? 'Kucing' : 'Cat';

static String speciesOther(BuildContext context) =>
  isID(context) ? 'Lainnya' : 'Other';

static String sexMale(BuildContext context) =>
  isID(context) ? 'Jantan' : 'Male';

static String sexFemale(BuildContext context) =>
  isID(context) ? 'Betina' : 'Female';

static String dateOfBirth(BuildContext context) =>
  isID(context) ? 'Tanggal lahir' : 'Date of Birth';

static String notes(BuildContext context) =>
    isID(context) ? 'Catatan' : 'Notes';

static String weight(BuildContext context) =>
    isID(context) ? 'Berat' : 'Weight';

static String breed(BuildContext context) =>
    isID(context) ? 'Ras' : 'Breed';

static String sex(BuildContext context) =>
    isID(context) ? 'Jenis kelamin' : 'Sex';

static String species(BuildContext context) =>
    isID(context) ? 'Spesies' : 'Species';

  static String profile(BuildContext context) =>
    isID(context) ? 'Profil' : 'Profile';

static String petName(BuildContext context) =>
    isID(context) ? 'Nama hewan' : 'Pet Name';

static String deletePet(BuildContext context) =>
    isID(context) ? 'Hapus hewan' : 'Delete Pet';

static String save(BuildContext context) =>
    isID(context) ? 'Simpan' : 'Save';



static String settings(BuildContext context) =>
    isID(context) ? 'Pengaturan' : 'Settings';

  static bool isID(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'id';

  static String feed(BuildContext context) =>
      isID(context) ? 'Beri makan' : 'Feed';

  static String startWalk(BuildContext context) =>
      isID(context) ? 'Mulai jalan' : 'Start walk';

  static String endWalk(BuildContext context) =>
      isID(context) ? 'Selesai jalan' : 'End walk';

  static String meds(BuildContext context) =>
      isID(context) ? 'Obat' : 'Meds';

  static String vet(BuildContext context) =>
      isID(context) ? 'Dokter hewan' : 'Vet';

  static String newPet(BuildContext context) =>
      isID(context) ? 'Hewan baru' : 'New Pet';

  static String start(BuildContext context) =>
      isID(context) ? 'Mulai' : 'Start';

  static String end(BuildContext context) =>
      isID(context) ? 'Selesai' : 'End';

  static String time(BuildContext context) =>
      isID(context) ? 'Waktu' : 'Time';

  static String eventName(BuildContext context, String type) {

    if (!isID(context)) return type;

    switch (type) {

      case 'Feed':
        return 'Beri makan';

      case 'Walk':
        return 'Jalan';

      case 'Vet':
        return 'Dokter hewan';

      case 'Meds':
        return 'Obat';

      default:
        return type;
    }
  }

}

void main() {
  runApp(const PetTrackerApp());
}

/// ---------- PHOTO VIEWER (SAFE OVERLAY) ----------

void showPhotoViewer(BuildContext context, String path) {
  showDialog(
    context: context,
    barrierColor: Colors.black,
    builder: (_) => GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: InteractiveViewer(
            child: Image.file(File(path)),
          ),
        ),
      ),
    ),
  );
}

/// ---------- MODELS ----------

class Pet {
  String id;
  String name;
  String species;
  String breed;
  String sex;
  DateTime? dob;
  String weight;
  String weightUnit;
  String notes;
  int avatarColor;

  String? photoPath;

  List<Event> events;
  Event? activeWalk;

  Pet({
    required this.id,
    required this.name,
    this.species = '',
    this.breed = '',
    this.sex = '',
    this.dob,
    this.weight = '',
    this.weightUnit = 'kg',
    this.notes = '',
    this.avatarColor = 0xFF26A69A,
    this.photoPath,
    List<Event>? events,
    this.activeWalk,
  }) : events = events ?? [];

  int? get ageMonths {
    if (dob == null) return null;
    final now = DateTime.now();
    return (now.year - dob!.year) * 12 + (now.month - dob!.month);
  }

  String get ageLabel {
    if (ageMonths == null) return '';
    final y = ageMonths! ~/ 12;
    final m = ageMonths! % 12;
    if (y > 0 && m > 0) return '$y yr $m mo';
    if (y > 0) return '$y yr';
    return '$m mo';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'species': species,
        'breed': breed,
        'sex': sex,
        'dob': dob?.toIso8601String(),
        'weight': weight,
        'weightUnit': weightUnit,
        'notes': notes,
        'avatarColor': avatarColor,
        'photoPath': photoPath,
        'activeWalk': activeWalk?.toJson(),
        'events': events.map((e) => e.toJson()).toList(),
      };

  static Pet fromJson(Map<String, dynamic> json) => Pet(
        id: json['id'],
        name: json['name'],
        species: json['species'] ?? '',
        breed: json['breed'] ?? '',
        sex: json['sex'] ?? '',
        dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
        weight: json['weight'] ?? '',
        weightUnit: json['weightUnit'] ?? 'kg',
        notes: json['notes'] ?? '',
        avatarColor: json['avatarColor'] ?? 0xFF26A69A,
        photoPath: json['photoPath'],
        activeWalk:
            json['activeWalk'] != null ? Event.fromJson(json['activeWalk']) : null,
        events: (json['events'] as List? ?? [])
            .map((e) => Event.fromJson(e))
            .toList(),
      );
}

class Event {
  String type;
  DateTime start;
  DateTime? end;
  String notes;

  Event({
    required this.type,
    required this.start,
    this.end,
    this.notes = '',
  });

  int? get duration =>
      end == null ? null : end!.difference(start).inMinutes;

  Map<String, dynamic> toJson() => {
        'type': type,
        'start': start.toIso8601String(),
        'end': end?.toIso8601String(),
        'notes': notes,
      };

  static Event fromJson(Map<String, dynamic> json) => Event(
        type: json['type'],
        start: DateTime.parse(json['start']),
        end: json['end'] != null ? DateTime.parse(json['end']) : null,
        notes: json['notes'] ?? '',
      );
}

/// ---------- ICONS ----------

IconData eventIcon(String type) {
  switch (type) {
    case 'Feed':
      return Icons.restaurant;
    case 'Walk':
      return Icons.pets;
    case 'Meds':
      return Icons.medication;
    case 'Vet':
      return Icons.local_hospital;
    default:
      return Icons.pets;
  }
}

/// ---------- APP ----------

class PetTrackerApp extends StatefulWidget {
  const PetTrackerApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    final state =
        context.findAncestorStateOfType<_PetTrackerAppState>();
    state?.setLocale(locale);
  }

  @override
  State<PetTrackerApp> createState() =>
      _PetTrackerAppState();
}

class _PetTrackerAppState extends State<PetTrackerApp> {

  Locale _locale = const Locale('id');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Pet Tracker',

      debugShowCheckedModeBanner: false,

      locale: _locale,

      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),

      home: const HomeScreen(),
    );
  }
}
/// ---------- HOME ----------

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pet> pets = [];
  int selectedPet = 0;
  bool isPro = false;

  bool multiSelectMode = false;
  Set<int> multiSelectedPets = {};

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('pets');
    final pro = prefs.getBool('pro') ?? false;

    setState(() {
      isPro = pro;
      pets = raw != null
          ? (jsonDecode(raw) as List).map((e) => Pet.fromJson(e)).toList()
          : [Pet(id: '1', name: 'My Pet')];
    });
  }

 Future<void> save() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(
    'pets',
    jsonEncode(pets.map((p) => p.toJson()).toList()),
  );
  await prefs.setBool('pro', isPro);
}

void toggleMultiSelect(int index) {

  setState(() {

    if (multiSelectedPets.contains(index)) {

      multiSelectedPets.remove(index);

      if (multiSelectedPets.isEmpty) {
        multiSelectMode = false;
      }

    } else {

      multiSelectedPets.add(index);
      multiSelectMode = true;

    }

  });

}
Future<void> pickPhotoWithChoice(Pet targetPet) async {
  final choice = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (_) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
children: [

  ListTile(
    leading: const Icon(Icons.camera_alt),
    title: Text(T.takePhoto(context)),
    onTap: () => Navigator.pop(context, ImageSource.camera),
  ),

  ListTile(
    leading: const Icon(Icons.photo_library),
    title: Text(T.chooseGallery(context)),
    onTap: () => Navigator.pop(context, ImageSource.gallery),
  ),

  ListTile(
    leading: const Icon(Icons.close),
    title: Text(T.cancel(context)),
    onTap: () => Navigator.pop(context),
  ),

],
      ),
    ),
  );

  if (choice == null) return;

  final picker = ImagePicker();
  final image = await picker.pickImage(source: choice);

  if (image == null) return;

  setState(() {
    targetPet.photoPath = image.path;
  });

  save();
}

  Pet get pet => pets[selectedPet];

  void addPet() {
  if (!isPro && pets.length >= 1) {
    showUpgrade();
    return;
  }

final newPet = Pet(
  id: DateTime.now().millisecondsSinceEpoch.toString(),
  name: '',
);
  setState(() {
    pets.add(newPet);
    selectedPet = pets.length - 1;
  });

  save();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => PetProfileScreen(
        pets: pets,
        selectedIndex: selectedPet,
        onSelect: (i) {
          setState(() {
            selectedPet = i;
          });
        },
        onSave: () {
          save();
          setState(() {});
        },
        onDelete: () {
          setState(() {
            pets.removeAt(selectedPet);
            selectedPet = 0;
          });
          save();
          Navigator.pop(context);
        },
      ),
    ),
  );
}

  void showUpgrade() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pet Tracker Pro'),
        content: const Text('Unlock multiple pets and advanced features.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => isPro = true);
              save();
              Navigator.pop(context);
            },
            child: const Text('Unlock Pro (Dev)'),
          ),
        ],
      ),
    );
  }

  void addEvent(String type) {
    setState(() {
      pet.events.insert(0, Event(type: type, start: DateTime.now()));
    });
    save();
  }

  void startWalk() {
    if (pet.activeWalk != null) return;
    setState(() {
      pet.activeWalk = Event(type: 'Walk', start: DateTime.now());
    });
    save();
  }

  void endWalk() {
    final walk = pet.activeWalk;
    if (walk == null) return;

    walk.end = DateTime.now();
    setState(() {
      pet.events.insert(0, walk);
      pet.activeWalk = null;
    });
    save();
  }

  Future<DateTime?> pickTime(DateTime base) async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(base),
    );
    if (t == null) return null;
    return DateTime(base.year, base.month, base.day, t.hour, t.minute);
  }

  void showLogEditor(Event event) {
    final notesController = TextEditingController(text: event.notes);
    String type = event.type;
    DateTime start = event.start;
    DateTime? end = event.end;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: StatefulBuilder(
          builder: (context, setSheet) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
DropdownButtonFormField<String>(
  value: type,
  decoration: InputDecoration(labelText: T.type(context)),
  items: ['Feed', 'Walk', 'Meds', 'Vet']
      .map((t) => DropdownMenuItem(
            value: t,
            child: Text(T.eventName(context, t)),
          ))
      .toList(),
  onChanged: (v) => setSheet(() => type = v ?? type),
),
              if (type == 'Walk') ...[
ListTile(
  title: Text(T.start(context)),                  subtitle: Text('${start.hour}:${start.minute.toString().padLeft(2, '0')}'),
                  trailing: const Icon(Icons.schedule),
                  onTap: () async {
                    final d = await pickTime(start);
                    if (d != null) setSheet(() => start = d);
                  },
                ),
                if (end != null)
ListTile(
  title: Text(T.endTime(context)),                    subtitle: Text('${end!.hour}:${end!.minute.toString().padLeft(2, '0')}'),
                    trailing: const Icon(Icons.schedule),
                    onTap: () async {
                      final d = await pickTime(end!);
                      if (d != null) setSheet(() => end = d);
                    },
                  ),
              ],
TextField(
  controller: notesController,
  decoration: InputDecoration(labelText: T.notes(context)),
),              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() => pet.events.remove(event));
                      save();
                      Navigator.pop(context);
                    },
                    child: Text(
  T.delete(context),
  style: const TextStyle(color: Colors.red),
),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        event.type = type;
                        event.start = start;
                        event.end = end;
                        event.notes = notesController.text;
                      });
                      save();
                      Navigator.pop(context);
                    },
                    child: Text(T.save(context)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String format(DateTime d) =>
      '${d.hour}:${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final currentPet = pet;

    return GestureDetector(
  onHorizontalDragEnd: (details) {

    if (details.primaryVelocity == null) return;

    // swipe right → previous pet
    if (details.primaryVelocity! > 0) {
      if (selectedPet > 0) {
        setState(() {
          selectedPet--;
        });
      }
    }

    // swipe left → next pet
    if (details.primaryVelocity! < 0) {
      if (selectedPet < pets.length - 1) {
        setState(() {
          selectedPet++;
        });
      }
    }

  },
  child: Scaffold(
appBar: AppBar(

  leading: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PetProfileScreen(
            pets: pets,
            selectedIndex: selectedPet,
            onSelect: (i) {
              setState(() {
                selectedPet = i;
              });
            },
            onSave: () {
              save();
              setState(() {});
            },
            onDelete: () {
              setState(() {
                pets.removeAt(selectedPet);
                selectedPet = 0;
              });
              save();
              Navigator.pop(context);
            },
          ),
        ),
      );
    },
    onLongPress: () => pickPhotoWithChoice(currentPet),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        backgroundColor: Color(currentPet.avatarColor),
        backgroundImage: currentPet.photoPath != null
            ? FileImage(File(currentPet.photoPath!))
            : null,
        child: currentPet.photoPath == null
            ? const Icon(Icons.pets, color: Colors.white)
            : null,
      ),
    ),
  ),

title: Row(
  children: [

    Expanded(
      child: SizedBox(
        height: 44,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pets.length,
          itemBuilder: (context, i) {
            final p = pets[i];
            final isSelected =
    multiSelectedPets.contains(i) || i == selectedPet;

return GestureDetector(

  onTap: () {

  if (multiSelectMode) {

    toggleMultiSelect(i);

  } else {

    setState(() {
      selectedPet = i;
    });

  }

},

onLongPress: () {

  toggleMultiSelect(i);

},

  child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 10),
decoration: BoxDecoration(
  color: multiSelectedPets.contains(i)
      ? Theme.of(context).colorScheme.primary.withOpacity(0.25)
      : isSelected
          ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
          : Colors.transparent,

  borderRadius: BorderRadius.circular(20),

  border: Border.all(
    color: multiSelectedPets.contains(i)
        ? Theme.of(context).colorScheme.primary
        : isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.grey.shade300,

    width: multiSelectedPets.contains(i) ? 3 : 1,
  ),
),                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: p.photoPath != null
                          ? FileImage(File(p.photoPath!))
                          : null,
                      child: p.photoPath == null
                          ? const Icon(Icons.pets, size: 14)
                          : null,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      p.name,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),

  ],
),        

actions: [
PopupMenuButton<String>(

  icon: const Icon(Icons.language),

  onSelected: (value) {

    if (value == 'en') {
      PetTrackerApp.setLocale(context, const Locale('en'));
    }

    if (value == 'id') {
      PetTrackerApp.setLocale(context, const Locale('id'));
    }

  },

  itemBuilder: (context) => const [

    PopupMenuItem(
      value: 'en',
      child: Text('English'),
    ),

    PopupMenuItem(
      value: 'id',
      child: Text('Bahasa Indonesia'),
    ),

  ],

),
          IconButton(icon: const Icon(Icons.add), onPressed: addPet),
          IconButton(icon: const Icon(Icons.star), onPressed: showUpgrade),
        ],
      ),
      body: Column(
        children: [
          Wrap(
            spacing: 8,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.restaurant),
                label: Text(T.feed(context)),
                onPressed: () => addEvent('Feed'),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.pets),
                label: Text(T.startWalk(context)),
                onPressed: currentPet.activeWalk == null ? startWalk : null,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.stop),
                label: Text(T.endWalk(context)),
                onPressed: currentPet.activeWalk != null ? endWalk : null,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.medication),
                label: Text(T.meds(context)),
                onPressed: () => addEvent('Meds'),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.local_hospital),
                label: Text(T.vet(context)),
                onPressed: () => addEvent('Vet'),
              ),
            ],
          ),
          const Divider(),
          Expanded(
  child: ListView.builder(
    itemCount: currentPet.events.length,
    itemBuilder: (_, i) {
      final e = currentPet.events[i];

      return ListTile(
        leading: Icon(eventIcon(e.type)),
                title: Text(
  e.type == 'Walk' && e.duration != null
      ? '${T.eventName(context, e.type)} • ${e.duration} min'
      : T.eventName(context, e.type),
),
subtitle: Text(
  e.notes.isNotEmpty
      ? e.notes
      : e.end != null
          ? '${T.start(context)} ${format(e.start)} • ${T.end(context)} ${format(e.end!)}'
          : '${T.time(context)} ${format(e.start)}',
),                  onLongPress: () => showLogEditor(e),
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

/// ---------- PROFILE ----------


class PetProfileScreen extends StatefulWidget {

  final List<Pet> pets;
  final int selectedIndex;
  final Function(int) onSelect;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const PetProfileScreen({
    super.key,
    required this.pets,
    required this.selectedIndex,
    required this.onSelect,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {

  late int localSelectedIndex;

@override
void initState() {
  super.initState();
  localSelectedIndex = widget.selectedIndex;
}

Pet get pet => widget.pets[localSelectedIndex];

  @override
  Widget build(BuildContext context) {

final name = TextEditingController(
  text: pet.name.isEmpty ? '' : pet.name,
);    final breed = TextEditingController(text: pet.breed);
    final notes = TextEditingController(text: pet.notes);
    final weight = TextEditingController(text: pet.weight);

    return GestureDetector(
  onHorizontalDragEnd: (details) {

    if (details.primaryVelocity == null) return;

    // swipe right → previous pet
    if (details.primaryVelocity! > 0) {

      if (localSelectedIndex > 0) {
        setState(() {
          localSelectedIndex--;
        });
        widget.onSelect(localSelectedIndex);
      }

    }

    // swipe left → next pet
    if (details.primaryVelocity! < 0) {

      if (localSelectedIndex < widget.pets.length - 1) {
        setState(() {
          localSelectedIndex++;
        });
        widget.onSelect(localSelectedIndex);
      }

    }

  },
  child: Scaffold(

      appBar: AppBar(
title: Text(T.profile(context)),        actions: [
         IconButton(
  icon: const Icon(Icons.save),
  tooltip: T.save(context),
  onPressed: () {
              pet.name = name.text;
              pet.breed = breed.text;
              pet.notes = notes.text;
              pet.weight = weight.text;

              widget.onSave();

              setState(() {});
            },
          )
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.pets.length,
              itemBuilder: (context, i) {

                final p = widget.pets[i];
                final selected = i == localSelectedIndex;

                return GestureDetector(
                  onTap: () {
  setState(() {
    localSelectedIndex = i;
  });

  widget.onSelect(i);
},
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        width: selected ? 3 : 1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: p.photoPath != null
                          ? FileImage(File(p.photoPath!))
                          : null,
                      child: p.photoPath == null
                          ? const Icon(Icons.pets)
                          : null,
                    ),
                  ),
                );

              },
            ),
          ),

          const SizedBox(height: 20),

Center(
  child: Text(
  pet.name.isEmpty ? T.newPet(context) : pet.name,
    style: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 12),

Center(
  child: GestureDetector(
    onTap: pet.photoPath != null
        ? () => showPhotoViewer(context, pet.photoPath!)
        : null,
    onLongPress: () async {
      final choice = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (_) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
title: Text(T.takePhoto(context)),                
onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
title: Text(T.chooseFromGallery(context)),                
onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.close),
title: Text(T.cancel(context)),                
onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );

      


      if (choice == null) return;

      final picker = ImagePicker();
      final image = await picker.pickImage(source: choice);

      if (image == null) return;

      setState(() {
        pet.photoPath = image.path;
      });

      widget.onSave();
    },
    child: CircleAvatar(
      radius: 60,
      backgroundColor: Color(pet.avatarColor),
      backgroundImage:
          pet.photoPath != null ? FileImage(File(pet.photoPath!)) : null,
      child: pet.photoPath == null
          ? const Icon(Icons.pets, size: 50, color: Colors.white)
          : null,
    ),
  ),
),

const SizedBox(height: 24),

TextField(
  controller: name,
  decoration: InputDecoration(labelText: T.petName(context)),
),

DropdownButtonFormField<String>(
  value: pet.species.isEmpty ? null : pet.species,
decoration: InputDecoration(labelText: T.species(context)),  items: [
DropdownMenuItem(value: 'Dog', child: Text(T.speciesDog(context))),
DropdownMenuItem(value: 'Cat', child: Text(T.speciesCat(context))),
DropdownMenuItem(value: 'Other', child: Text(T.speciesOther(context))),  ],
  onChanged: (v) {
    pet.species = v ?? '';
    widget.onSave();
    setState(() {});
  },
),

DropdownButtonFormField<String>(
  value: pet.sex.isEmpty ? null : pet.sex,
  decoration: InputDecoration(labelText: T.sex(context)),
  items: [
DropdownMenuItem(value: 'Male', child: Text(T.sexMale(context))),
DropdownMenuItem(value: 'Female', child: Text(T.sexFemale(context))),  ],
  onChanged: (v) {
    pet.sex = v ?? '';
    widget.onSave();
    setState(() {});
  },
),

ListTile(
  title: Text(T.dateOfBirth(context)),
  subtitle: Text(
    pet.dob == null
        ? T.notSet(context)
        : '${pet.dob!.year}-${pet.dob!.month}-${pet.dob!.day} (${pet.ageLabel})',
  ),
  trailing: const Icon(Icons.calendar_today),
  onTap: () async {
    final d = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDate: pet.dob ?? DateTime.now(),
    );
    if (d != null) {
      pet.dob = d;
      widget.onSave();
      setState(() {});
    }
  },
),

TextField(
  controller: breed,
  decoration: InputDecoration(labelText: T.breed(context)),
),

Row(
  children: [
    Expanded(
      child: TextField(
        controller: weight,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: T.weight(context)),
      ),
    ),
    const SizedBox(width: 12),
    DropdownButton<String>(
      value: pet.weightUnit,
      items: const [
        DropdownMenuItem(value: 'kg', child: Text('kg')),
        DropdownMenuItem(value: 'lb', child: Text('lb')),
      ],
      onChanged: (v) {
        pet.weightUnit = v ?? 'kg';
        widget.onSave();
        setState(() {});
      },
    ),
  ],
),

TextField(
  controller: notes,
  decoration: InputDecoration(
    labelText: T.notes(context),
  ),
),
          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: widget.onDelete,
            child: Text(T.deletePet(context)),
          ),

        ],
      ),
    ),
  );
}
}