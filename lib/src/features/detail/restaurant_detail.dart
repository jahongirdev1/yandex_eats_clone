import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';
import 'package:yandex_eats/src/common/styles/app_colors.dart';
import 'package:yandex_eats/src/features/controller/main_controller.dart';

import '../../common/data/database.dart';
import '../../common/model/restaurant_model.dart';
import 'widget/product_detail.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({
    super.key,
    required this.restaurant,
  });
  final Restaurant restaurant;
  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView>
    with SingleTickerProviderStateMixin {
  late AutoScrollController autoScrollController;
  late TabController tabController;
  late final List<Category> data;

  @override
  void initState() {
    autoScrollController = AutoScrollController();
    data = Data.divideCategory(widget.restaurant.products);
    tabController = TabController(length: data.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: VerticalScrollableTabView(
        autoScrollController: autoScrollController,
        tabController: tabController,
        listItemData: data,
        eachItemChild: (category, index) {
          return ViewCategory(
            category: category,
            restaurant: widget.restaurant,
          );
        },
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            pinned: true,
            expandedHeight: 250.0,
            centerTitle: false,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Text(
                  widget.restaurant.name,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              centerTitle: false,
              background: Image(
                image: AssetImage(widget.restaurant.restaurantImage),
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, kToolbarHeight),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
                      onTap: VerticalScrollableTabBarStatus.setIndex,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: const TextStyle(fontSize: 18),
                      unselectedLabelStyle: const TextStyle(fontSize: 18),
                      indicator: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      tabs: data
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 0,
                              ),
                              child: Tab(text: e.title),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewCategory extends StatefulWidget {
  final Category category;
  final Restaurant restaurant;

  const ViewCategory({
    super.key,
    required this.category,
    required this.restaurant,
  });

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.category.title,
            style: const TextStyle(color: Colors.black, fontSize: 30),
          ),
          GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.category.products.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 100 / 180,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SingleChildScrollView(
                        child: BottomSheet(
                          enableDrag: false,
                          showDragHandle: false,
                          onClosing: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsView(
                                  restaurant: widget.restaurant,
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          builder: (BuildContext context) => ProductDetail(
                            products: widget.category.products[index],
                            restaurant: widget.restaurant,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  child: ColoredBox(
                    color: Colors.grey.shade200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 170,
                            width: 360,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  widget.category.products[index].image,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.category.products[index].price.toInt()} Sum",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(widget.category.products[index].category),
                              Text(
                                "${widget.category.products[index].gram} g",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: widget.category.products[index].count != 0
                              ? AddMinus(
                                  increment: () {
                                    widget.category.products[index].count--;
                                    context.read<MainController>().isAvailable(
                                        widget.category.products[index]);
                                    setState(() {});
                                  },
                                  decrement: () {
                                    widget.category.products[index].count++;
                                    context.read<MainController>().isAvailable(
                                        widget.category.products[index]);
                                    setState(() {});
                                  },
                                  count: widget.category.products[index].count,
                                )
                              : Addd(
                                  onTap: () {
                                    widget.category.products[index].count++;
                                    context.read<MainController>().isAvailable(
                                        widget.category.products[index]);
                                    setState(() {});
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AddMinus extends StatefulWidget {
  const AddMinus({
    super.key,
    required this.increment,
    required this.decrement,
    required this.count,
  });
  final VoidCallback increment;
  final VoidCallback decrement;
  final int count;

  @override
  State<AddMinus> createState() => _AddMinusState();
}

class _AddMinusState extends State<AddMinus> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: widget.increment,
              icon: const Text(
                "-",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Text(
              "${widget.count}",
              style: const TextStyle(fontSize: 20),
            ),
            IconButton(
              onPressed: widget.decrement,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class Addd extends StatefulWidget {
  const Addd({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;

  @override
  State<Addd> createState() => _AdddState();
}

class _AdddState extends State<Addd> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onTap,
      style: TextButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Colors.white,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: Colors.black,
          ),
          SizedBox(width: 10),
          Text(
            'Add',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
