// lib/presentation/appointments/book_appointment/binding/book_appointment_binding.dart

import 'package:dycare/domain/repositories/search_repository.dart';
import 'package:get/get.dart';
import 'package:dycare/presentation/appointments/book_appointment/controller/book_appointment_controller.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/domain/repositories/search_repository.dart';
import 'package:dycare/domain/repositories/user_repository.dart';

class BookAppointmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentRepository>(() => AppointmentRepositoryImpl('https://hono-on-vercel-swart-one.vercel.app/api'));
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl());
    
    Get.lazyPut<BookAppointmentController>(
      () => BookAppointmentController(
        Get.find<AppointmentRepository>(),
        Get.find<UserRepository>() as UserRepository,
        Get.find<SearchRepository>() as SearchRepository,
      ),
    );
  }
}