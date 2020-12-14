import 'package:flutter/cupertino.dart';

class GVars {
  bool ring1 = false;
  bool ring2 = false;
  bool vial = false;
  bool elixir = false;
  static int ringHP = 1;
  static int vialHP = 2;

  String town = ' ';

  var stateImg = [
    Image.asset('images/app_style/ok.png'),
    Image.asset('images/app_style/cancel.png')
  ];

  var unitsInfo = {
    'pit_lord': 0,
    'pikeman': 0,
    'archer': 0,
    'griffin': 0,
    'swordsman': 0,
    'monk': 0,
    'centaur': 0,
    'centaur_captain': 0,
    'dwarf': 0,
    'wood_elf': 0,
    'pegasus': 0,
    'dendroid': 0,
    'gremlin': 0,
    'mage': 0,
    'arch_mage': 0,
    'genie': 0,
    'imp': 0,
    'gog': 0,
    'hell_hound': 0,
    'demon': 0,
    'troglodyte': 0,
    'infernal_troglodyte': 0,
    'harpy': 0,
    'beholder': 0,
    'medusa': 0,
    'medusa_queen': 0,
    'minotaur': 0,
    'goblin': 0,
    'wolf_rider': 0,
    'orc': 0,
    'orc_chieftain': 0,
    'ogre': 0,
    'roc': 0,
    'gnoll': 0,
    'lizzardman': 0,
    'lizzard_warrior': 0,
    'serpent_fly': 0,
    'basilisk': 0,
    'gorgon': 0,
    'pixie': 0,
    'nymph': 0,
    'crew_mate': 0,
    'pirate': 0,
    'stormbird': 0,
    'sea_witch': 0,
    'peasant': 0,
    'halfling': 0,
    'boar': 0,
    'rogue': 0,
    'leprechaun': 0,
    'nomad': 0,
    'sharpshooter': 0,
    'satyr': 0,
    'troll': 0,
    'fangarm': 0,
  };

  final formPit_LordKey = GlobalKey<FormState>();
  final formPikemanKey = GlobalKey<FormState>();
  final formArcherKey = GlobalKey<FormState>();
  final formGriffinKey = GlobalKey<FormState>();
  final formSwordsmanKey = GlobalKey<FormState>();
  final formMonkKey = GlobalKey<FormState>();
  final formCentaurKey = GlobalKey<FormState>();
  final formCentaurCaptainKey = GlobalKey<FormState>();
  final formDwarfKey = GlobalKey<FormState>();
  final formWoodElfKey = GlobalKey<FormState>();
  final formPegasusKey = GlobalKey<FormState>();
  final formDendroidKey = GlobalKey<FormState>();
  final formGremlinKey = GlobalKey<FormState>();
  final formMageKey = GlobalKey<FormState>();
  final formArchMageKey = GlobalKey<FormState>();
  final formGenieKey = GlobalKey<FormState>();
  final formImpKey = GlobalKey<FormState>();
  final formGogKey = GlobalKey<FormState>();
  final formHellHoundKey = GlobalKey<FormState>();
  final formTroglodyteKey = GlobalKey<FormState>();
  final formInfernalTroglodyteKey = GlobalKey<FormState>();
  final formHarpyKey = GlobalKey<FormState>();
  final formBeholderKey = GlobalKey<FormState>();
  final formMedusaKey = GlobalKey<FormState>();
  final formMedusaQueenKey = GlobalKey<FormState>();
  final formMinotaurKey = GlobalKey<FormState>();
  final formGoblinKey = GlobalKey<FormState>();
  final formWolfRiderKey = GlobalKey<FormState>();
  final formOrcKey = GlobalKey<FormState>();
  final formOrcChieftainKey = GlobalKey<FormState>();
  final formOgreKey = GlobalKey<FormState>();
  final formRocKey = GlobalKey<FormState>();
  final formGnollKey = GlobalKey<FormState>();
  final formLizzardmanKey = GlobalKey<FormState>();
  final formLizzardWarriorKey = GlobalKey<FormState>();
  final formSerpentFlyKey = GlobalKey<FormState>();
  final formBasiliskKey = GlobalKey<FormState>();
  final formGorgonKey = GlobalKey<FormState>();
  final formPixieKey = GlobalKey<FormState>();
  final formNymphKey = GlobalKey<FormState>();
  final formPirateKey = GlobalKey<FormState>();
  final formCreMateKey = GlobalKey<FormState>();
  final formStormbirdKey = GlobalKey<FormState>();
  final formSeaWitchKey = GlobalKey<FormState>();
  final formPeasantKey = GlobalKey<FormState>();
  final formHalflingKey = GlobalKey<FormState>();
  final formBoarKey = GlobalKey<FormState>();
  final formRogueKey = GlobalKey<FormState>();
  final formLeprechaunKey = GlobalKey<FormState>();
  final formNomadKey = GlobalKey<FormState>();
  final formSharpshooterKey = GlobalKey<FormState>();
  final formSatyrKey = GlobalKey<FormState>();
  final formTrollKey = GlobalKey<FormState>();
  final formFangarmKey = GlobalKey<FormState>();

  static int pikemanHP = 10;
  static int archerHP = 10;
  static int griffinHP = 25;
  static int swordsmanHP = 35;
  static int monkHP = 30;
  static int centaurHP = 8;
  static int centaur_captainHP = 10;
  static int dwarfHP = 20;
  static int wood_elfHP = 15;
  static int pegasusHP = 30;
  static int dendroidHP = 55;
  static int gremlinHP = 4;
  static int mageHP = 25;
  static int arch_mageHP = 30;
  static int genieHP = 40;
  static int impHP = 4;
  static int gogHP = 13;
  static int hell_houndHP = 25;
  static int demonHP = 35;
  static int troglodyteHP = 5;
  static int infernal_troglodyteHP = 6;
  static int harpyHP = 14;
  static int beholderHP = 22;
  static int medusaHP = 25;
  static int medusa_queenHP = 30;
  static int minotaurHP = 50;
  static int goblinHP = 5;
  static int wolf_riderHP = 10;
  static int orcHP = 15;
  static int orc_chieftainHP = 20;
  static int ogreHP = 40;
  static int rocHP = 60;
  static int gnollHP = 6;
  static int lizzardmanHP = 14;
  static int lizzard_warriorHP = 15;
  static int serpent_flyHP = 20;
  static int basiliskHP = 35;
  static int gorgonHP = 70;
  static int pixieHP = 3;
  static int nymphHP = 4;
  static int crew_mateHP = 15;
  static int pirateHP = 15;
  static int stormbirdHP = 30;
  static int sea_witchHP = 35;
  static int peasantHP = 1;
  static int halflingHP = 4;
  static int boarHP = 15;
  static int rogueHP = 10;
  static int leprechaunHP = 15;
  static int nomadHP = 30;
  static int sharpshooterHP = 15;
  static int satyrHP = 35;
  static int trollHP = 40;
  static int fangarmHP = 50;
}
