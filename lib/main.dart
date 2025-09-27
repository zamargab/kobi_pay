import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kobi_pay/core/routes/app_router.dart';
import 'package:kobi_pay/core/themes/theme_data.dart';
import 'package:kobi_pay/features/transactions/data/data_sources/transaction_local_data_source.dart';
import 'package:sizer/sizer.dart';
import 'features/transactions/data/repositories/transaction_repository.dart';
import 'features/transactions/logic/bloc/transaction_bloc.dart';
import 'features/transactions/logic/bloc/transaction_event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const KobiPay());
}

class KobiPay extends StatelessWidget {
  const KobiPay({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        final repository = TransactionRepository(
          localDataSource: TransactionLocalDataSource(),
        );

        return RepositoryProvider<TransactionRepository>.value(
          value: repository,
          child: BlocProvider<TransactionBloc>(
            create: (context) =>
                TransactionBloc(repository: repository)
                  ..add(LoadTransactions()),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Kobi Pay',
              theme: AppThemes.appThemeData,
              routerConfig: appRouter,
            ),
          ),
        );
      },
    );
  }
}
