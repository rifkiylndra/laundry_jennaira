import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'business_info_provider.g.dart';

class BusinessInfo {
  final String name;
  final String address;
  final String phone;
  final String footerMessage;

  const BusinessInfo({
    required this.name,
    required this.address,
    required this.phone,
    required this.footerMessage,
  });

  BusinessInfo copyWith({
    String? name,
    String? address,
    String? phone,
    String? footerMessage,
  }) {
    return BusinessInfo(
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      footerMessage: footerMessage ?? this.footerMessage,
    );
  }
}

@riverpod
class BusinessInfoNotifier extends _$BusinessInfoNotifier {
  @override
  FutureOr<BusinessInfo> build() async {
    final prefs = await SharedPreferences.getInstance();
    
    return BusinessInfo(
      name: prefs.getString('business_name') ?? 'LAUNDRY JENNAIRA',
      address: prefs.getString('business_address') ?? 'Jl. Contoh Alamat No. 123',
      phone: prefs.getString('business_phone') ?? '081234567890',
      footerMessage: prefs.getString('business_footer') ?? 'Terima kasih!',
    );
  }

  Future<void> updateInfo(BusinessInfo info) async {
    state = const AsyncValue.loading();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('business_name', info.name);
      await prefs.setString('business_address', info.address);
      await prefs.setString('business_phone', info.phone);
      await prefs.setString('business_footer', info.footerMessage);
      
      state = AsyncValue.data(info);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
