import 'package:crocs_club/application/business_logic/address/bloc/adressbloc_bloc.dart';
import 'package:crocs_club/application/presentation/adress_screen/widgets.dart/add_adress.dart';
import 'package:crocs_club/application/presentation/adress_screen/widgets.dart/adress_card.dart';
import 'package:crocs_club/application/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocs_club/domain/core/constants/constants.dart';
import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AdressScreen extends StatelessWidget {
  const AdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AdressblocBloc>(context).add(GetAddressEvent());
    return SafeArea(
      child: Scaffold(
        // appbar
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BottomNavBar()));
              },
              icon: Icon(Icons.arrow_back)),
          title: const SubHeadingTextWidget(
            textColor: kDarkGreyColour,
            textsize: 18,
            title: 'Addresses',
          ),
          centerTitle: true,
        ),
        // Body to show the adress as cards
        body: BlocConsumer<AdressblocBloc, AdressblocState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AdressblocLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: kAppPrimaryColor,
                  size: 40,
                ),
              );
            }
            if (state is AdressblocLoaded) {
              return ListView.builder(
                itemCount: state.addressModel.length,
                itemBuilder: (context, index) {
                  final address = state.addressModel[index];
                  return AdressCard(
                    address: address,
                    index: index,
                  );
                },
              );
            } else if (state is AdressblocError) {
              return const Center(
                  child: SubHeadingTextWidget(
                title: "No adress found",
                textColor: kDarkGreyColour,
              ));
            } else {
              print("the state is $state");
              return const Center(
                  child: SubHeadingTextWidget(
                title: "No adress found",
                textColor: kDarkGreyColour,
              ));
            }
          },
        ),
        // floating action bar to add new adress
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddAddressScreen(),
            ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
