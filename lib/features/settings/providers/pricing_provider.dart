import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PricingRates {
  final int cuciGosok3Hari;
  final int cuciGosok2Hari;
  final int cuciGosok1Hari;
  final int cuciKering3Hari;
  final int cuciKering2Hari;
  final int cuciKering1Hari;
  final int expressRate;
  
  // Satuan
  final int spreiKecil;
  final int spreiBesar;
  final int selimutKecil;
  final int selimutBesar;
  final int sepatu;
  final int boneka;
  final int karpetKecil;
  final int karpetBesar;

  PricingRates({
    this.cuciGosok3Hari = 5000,
    this.cuciGosok2Hari = 6000,
    this.cuciGosok1Hari = 7000,
    this.cuciKering3Hari = 4000,
    this.cuciKering2Hari = 5000,
    this.cuciKering1Hari = 6000,
    this.expressRate = 12000,
    this.spreiKecil = 8000,
    this.spreiBesar = 15000,
    this.selimutKecil = 10000,
    this.selimutBesar = 45000,
    this.sepatu = 20000,
    this.boneka = 15000,
    this.karpetKecil = 20000,
    this.karpetBesar = 50000,
  });

  PricingRates copyWith({
    int? cuciGosok3Hari,
    int? cuciGosok2Hari,
    int? cuciGosok1Hari,
    int? cuciKering3Hari,
    int? cuciKering2Hari,
    int? cuciKering1Hari,
    int? expressRate,
    int? spreiKecil,
    int? spreiBesar,
    int? selimutKecil,
    int? selimutBesar,
    int? sepatu,
    int? boneka,
    int? karpetKecil,
    int? karpetBesar,
  }) {
    return PricingRates(
      cuciGosok3Hari: cuciGosok3Hari ?? this.cuciGosok3Hari,
      cuciGosok2Hari: cuciGosok2Hari ?? this.cuciGosok2Hari,
      cuciGosok1Hari: cuciGosok1Hari ?? this.cuciGosok1Hari,
      cuciKering3Hari: cuciKering3Hari ?? this.cuciKering3Hari,
      cuciKering2Hari: cuciKering2Hari ?? this.cuciKering2Hari,
      cuciKering1Hari: cuciKering1Hari ?? this.cuciKering1Hari,
      expressRate: expressRate ?? this.expressRate,
      spreiKecil: spreiKecil ?? this.spreiKecil,
      spreiBesar: spreiBesar ?? this.spreiBesar,
      selimutKecil: selimutKecil ?? this.selimutKecil,
      selimutBesar: selimutBesar ?? this.selimutBesar,
      sepatu: sepatu ?? this.sepatu,
      boneka: boneka ?? this.boneka,
      karpetKecil: karpetKecil ?? this.karpetKecil,
      karpetBesar: karpetBesar ?? this.karpetBesar,
    );
  }
}

class PricingNotifier extends StateNotifier<PricingRates> {
  PricingNotifier() : super(PricingRates()) {
    loadPrices();
  }

  Future<void> loadPrices() async {
    final prefs = await SharedPreferences.getInstance();
    state = PricingRates(
      cuciGosok3Hari: prefs.getInt('cuciGosok3Hari') ?? 5000,
      cuciGosok2Hari: prefs.getInt('cuciGosok2Hari') ?? 6000,
      cuciGosok1Hari: prefs.getInt('cuciGosok1Hari') ?? 7000,
      cuciKering3Hari: prefs.getInt('cuciKering3Hari') ?? 4000,
      cuciKering2Hari: prefs.getInt('cuciKering2Hari') ?? 5000,
      cuciKering1Hari: prefs.getInt('cuciKering1Hari') ?? 6000,
      expressRate: prefs.getInt('expressRate') ?? 12000,
      spreiKecil: prefs.getInt('spreiKecil') ?? 8000,
      spreiBesar: prefs.getInt('spreiBesar') ?? 15000,
      selimutKecil: prefs.getInt('selimutKecil') ?? 10000,
      selimutBesar: prefs.getInt('selimutBesar') ?? 45000,
      sepatu: prefs.getInt('sepatu') ?? 20000,
      boneka: prefs.getInt('boneka') ?? 15000,
      karpetKecil: prefs.getInt('karpetKecil') ?? 20000,
      karpetBesar: prefs.getInt('karpetBesar') ?? 50000,
    );
  }

  Future<void> savePrices(PricingRates newRates) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cuciGosok3Hari', newRates.cuciGosok3Hari);
    await prefs.setInt('cuciGosok2Hari', newRates.cuciGosok2Hari);
    await prefs.setInt('cuciGosok1Hari', newRates.cuciGosok1Hari);
    await prefs.setInt('cuciKering3Hari', newRates.cuciKering3Hari);
    await prefs.setInt('cuciKering2Hari', newRates.cuciKering2Hari);
    await prefs.setInt('cuciKering1Hari', newRates.cuciKering1Hari);
    await prefs.setInt('expressRate', newRates.expressRate);
    await prefs.setInt('spreiKecil', newRates.spreiKecil);
    await prefs.setInt('spreiBesar', newRates.spreiBesar);
    await prefs.setInt('selimutKecil', newRates.selimutKecil);
    await prefs.setInt('selimutBesar', newRates.selimutBesar);
    await prefs.setInt('sepatu', newRates.sepatu);
    await prefs.setInt('boneka', newRates.boneka);
    await prefs.setInt('karpetKecil', newRates.karpetKecil);
    await prefs.setInt('karpetBesar', newRates.karpetBesar);
    
    state = newRates;
  }
}

final pricingProvider = StateNotifierProvider<PricingNotifier, PricingRates>((ref) {
  return PricingNotifier();
});
