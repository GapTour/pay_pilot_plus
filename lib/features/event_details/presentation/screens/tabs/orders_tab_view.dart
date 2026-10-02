import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_pilot_plus/features/event_details/presentation/cubits/event_details_cubit/event_details_cubit.dart';

class OrdersTabView extends StatefulWidget {
  const new({super.key});

  @override
  State<OrdersTabView> createState() => _OrdersTabViewState();
}

class _OrdersTabViewState extends State<OrdersTabView> {
  @override
  void initState() {
    super.initState();

    context.read<EventDetailsCubit>().changeTabStatus(.orders);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('بزودی'));
  }
}
