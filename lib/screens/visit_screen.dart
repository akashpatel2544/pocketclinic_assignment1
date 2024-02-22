import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pocketclinic_assignment/controller/api_controller.dart';
import 'package:pocketclinic_assignment/model/visit.dart';
import 'package:pocketclinic_assignment/utils.dart';
import 'package:provider/provider.dart';

import '../resources.dart';

class VisitScreenPage extends StatefulWidget {
  const VisitScreenPage({super.key});

  @override
  State<VisitScreenPage> createState() => _VisitScreenPageState();
}

class _VisitScreenPageState extends State<VisitScreenPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController? tabController;
  ScrollController? _allTasksscrollController;
  ScrollController? _pendingTasksscrollController;
  ScrollController? _completedTasksscrollController;
  late FToast fToast;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    _allTasksscrollController = ScrollController();
    _pendingTasksscrollController = ScrollController();
    _completedTasksscrollController = ScrollController();
    Provider.of<DataProvider>(context, listen: false).getVisits();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
    super.initState();
  }

  void changeDestination(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return getTasksTabView();
    return Scaffold(
        body: isWeb() ? visitScreenPageForWeb() : visitScreenPageForMobile());
  }

  Widget visitScreenPageForWeb() {
    // return getAllTasksView();
    // return getTasksTabView();
    // return temp1();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        getAppBar(),
        // Text('ssf'),
        Flexible(
          // SingleChildScrollView(
          child: Row(
            children: [
              getLeftNavigationView(),
              Container(
                width: MediaQuery.of(context).size.width * 0.92,
                decoration: const BoxDecoration(color: whiteColor),
                child: getTasksAndVisitsView(),
              ),
            ],
          ),
        ),

        // getLeftNavigationView(),
        // Text('aaaa'),
      ],
    );
  }

  Widget getTasksAndVisitsView() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getTasksView(),
        // getVisitsView(),
        // getVisitsView(),
      ],
    );
  }

  Widget getTasksView() {
    final visitDataProvider = Provider.of<DataProvider>(context);

    if (visitDataProvider.isLoading) {
      return Center(
          child: Container(
        child: const CircularProgressIndicator(),
      ));
    }

    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text(YOUR_TASKS, style: titleTextStyle),
          ),

          // Text('afasfsag'),
          Flexible(child: getTasksTabView(visitDataProvider))
        ],
      ),
    );
  }

  Widget getTasksTabView(DataProvider visitDataProvider) {
    // return Text('adas fsa ');
    return
        // Scaffold(
        // body:
        Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text('adas fsa '),
        // Flexible(
        //   child: getTaskTabView(visitDataProvider, TaskType.PENDING),
        // ),

        TabBar(
          unselectedLabelColor: Colors.black,
          labelColor: Colors.black,
          dividerColor: PrimaryTealColor,
          // dividerHeight: 2,
          // indicatorSize: Ta,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          tabs: const [
            Tab(
              text: ALL_TASKS,
            ),
            Tab(
              text: PENDING_TASKS,
            ),
            Tab(
              text: COMPLETED_TASKS,
              // child: Text('aad'),
            ),
          ],
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        Flexible(
          child: TabBarView(
            controller: tabController,
            children: [
              getTaskTabView(visitDataProvider, TaskType.ANY),
              getTaskTabView(visitDataProvider, TaskType.PENDING),
              getTaskTabView(visitDataProvider, TaskType.COMPLETED),
            ],
          ),
        ),
      ],
      // ),
    );
  }

  Widget getVisitsView() {
    final visitDataProvider = Provider.of<DataProvider>(context);
    Map<Tasks, Visit> visitTasksMap =
        visitDataProvider.getTasksAsPerStatus(TaskType.ANY);
    List<Tasks> tasks = visitTasksMap.keys.toList();
//     visitTasksMap.values.forEach((visit) {
// visit.visitType
//     });

    return Column(
      children: [
        Text(VISITS, style: titleTextStyle),
        taskCardView(
          visitDataProvider,
          visitTasksMap[tasks.elementAt(0)],
          tasks.elementAt(0),
        ),
      ],
    );
  }

  Widget visitScreenPageForMobile() {
    return Column(
      children: [
        getAppBar(),
      ],
    );
  }

  Widget getLeftNavigationView() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.08,
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: getNavigationView(),

      // Column(
      //   children: [
      //     getTimelineButton(),
      //     SizedBox(height: 20,),
      //     getCategoriesButton(),
      //   ],
      // ),
    );
  }

  Widget getAppBar() {
    return Card(
      elevation: 50,
      // color: whiteColor,
      shadowColor: Colors.black,
      surfaceTintColor: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 30,
            color: PrimaryDarkColor,
            onPressed: () {},
          ),
          const SizedBox(
            width: 20,
          ),
          Image.asset(
            "assets/images/logo/logo_blue.png",
            height: 50,
            width: 50,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    iconSize: 30,
                    // color: Colors.red,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.help_outline),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  getLoggedInUserIcon(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getLoggedInUserIcon() {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: SecondaryLightTealColor,
          shape: BoxShape.circle,
        ),
        child: const Text(
          'PI',
          style:
              TextStyle(color: SecondaryTealColor, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: () {
        print("tapped on getLoggedInUserIcon");
      },
    );
  }

  Widget mobileVisitScreenPage() {
    return getLoginUI();
  }

  Widget getLoginUI() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      // alignment: Alignment.center,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/images/logo/logo_blue.png",
              // height: 200,
              // width: 200,
            ),
          ),
          const Text(
            LOG_IN,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          // TextField(
          //   controller: _emailController,
          //   decoration: const InputDecoration(
          //     labelText: 'Email',
          //   ),
          // ),
          const SizedBox(height: 20.0),
          // TextField(
          //   controller: _passwordController,
          //   decoration: const InputDecoration(
          //     labelText: 'Password',
          //   ),
          //   obscureText: true,
          // ),
          const SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: const Text(FORGOT_PASSWORD),
              onPressed: () {},
            ),
          ),
          Row(
            children: [
              const Text(DO_NOT_HAVE_ACCOUNT),
              TextButton(
                child: const Text(SIGN_UP),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            width: double.infinity,
            // height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(LOG_IN),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget getTimelineButton() {
    return TextButton(
      // clipBehavior:Clip.none
      child: const Padding(
        padding: EdgeInsets.all(1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.volume_up),
            Text('Timeline'),
          ],
        ),
      ),

      onPressed: () {},
    );
  }

  Widget getCategoriesButton() {
    return TextButton(
      // clipBehavior:Clip.none
      child: const Padding(
        padding: EdgeInsets.all(1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.volume_up),
            // Icon(Image.asset('assets/images/icons/logout.png')),
            ImageIcon(
              AssetImage("images/icon_more.png"),
              color: Color(0xFF3A5A98),
            ),
            Text('Categories'),
          ],
        ),
      ),

      onPressed: () {},
    );
  }

  Widget getNavigationView() {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: changeDestination,
      labelType: NavigationRailLabelType.all,
      selectedLabelTextStyle: const TextStyle(color: PrimaryTealColor),
      unselectedLabelTextStyle: const TextStyle(color: PrimaryDarkColor),
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
          icon: ImageIcon(
            AssetImage("images/timeline_black.png"),
          ),
          selectedIcon: ImageIcon(
            AssetImage("images/timeline_blue.png"),
          ),
          label: Text('Timeline'),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        ),
        NavigationRailDestination(
          icon: ImageIcon(
            AssetImage("images/categories_black.png"),
          ),
          selectedIcon: ImageIcon(
            AssetImage("images/categories_blue.png"),
          ),
          label: Text('Categories'),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        ),
      ],
    );
  }

  Widget getTaskTabView(DataProvider visitDataProvider, TaskType taskType) {
    Map<Tasks, Visit> visitTasksMap =
        visitDataProvider.getTasksAsPerStatus(taskType);
    List<Tasks> tasks = visitTasksMap.keys.toList();
    ScrollController? scrollController;

    if (taskType == TaskType.PENDING) {
      scrollController = _pendingTasksscrollController;
    } else if (taskType == TaskType.COMPLETED) {
      scrollController = _completedTasksscrollController;
    } else {
      scrollController = _allTasksscrollController;
    }

    if (visitTasksMap.isEmpty) {
      return Container(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.file_open_outlined,
            size: 20,
            // color: isPending ? SecondaryRedColor : SecondaryGreenColor,
          ),
          SizedBox(width: 10),
          const Text(
            'Tasks list is empty!',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ));
    }

    // String taskStr
    return Scrollbar(
      // isAlwaysShown: true,
      thumbVisibility: true,
      controller: scrollController,
      child: ListView.builder(
        itemCount: visitTasksMap.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        controller: scrollController,
        itemBuilder: (context, index) {
          // final item = items[index];
          // return Card(
          //   child: Text('$index'),
          // );
          return taskCardView(visitDataProvider,
              visitTasksMap[tasks.elementAt(index)], tasks.elementAt(index));
          return ListTile(
            title: Card(
              child: Text('$index'),
            ),
            // subtitle: Text('${photo.id}'),
          );
        },
      ),
    );
    return Container();
  }

  Widget taskCardView(
      DataProvider visitDataProvider, Visit? visit, Tasks task) {
    String? status = task.status?.toUpperCase();
    bool isPending = status == PENDING;
    String date = visit?.dateStart ?? '';
    String taskStr = task.task ?? '';
    taskStr = visitDataProvider.appendEmptySpaceToNoteString(taskStr);
    // debugPrint('taskStr ${taskStr.length}');
    String doctorName = visit?.npi1 ?? '';
    String hospitalName = visit?.npi2 ?? '';

    // return Container(
    //   width: MediaQuery.of(context).size.width * 0.3,
    //   padding: EdgeInsets.all(10),
    //   child: Row(
    //     children: [
    //       getFilledColorViewInCard(),
    //       // Text('sg sdgsd gs sgd '),
    //       Column(
    //         children: [
    //           Row(
    //             children: [
    //               getTaskStatusViewInCard(isPending, status),
    //               getTaskDateViewInCard(date),
    //             ],
    //           ),
    //           const SizedBox(height: 10),
    //           Text(taskStr),
    //         ],
    //       ),
    //     ],
    //   ),
    // );

    // return Text('aaa');

    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Card(
        elevation: 50,
        // color: whiteColor,
        shadowColor: Colors.black,
        surfaceTintColor: whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTaskStatusViewInCard(isPending, status),
                  getTaskDateViewInCard(date),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                child: Text(
                  taskStr,
                  softWrap: true,
                ),
              ),

              // EditableText('${task.task}'),
              const SizedBox(height: 10),
              getAddNoteView(),
              const SizedBox(height: 10),

              getDoctorAndHospitalNameViewInCard(
                  isPending, hospitalName, doctorName),
              const SizedBox(height: 15),
              getCompleteVisitTaskButtonInCard(task?.id, visit?.sId, task?.note,
                  isPending, visitDataProvider),
            ],
          ),
        ),

        // Row(
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     getFilledColorViewInCard(),
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisSize: MainAxisSize.max,
        //       children: [
        //         Row(
        //           mainAxisSize: MainAxisSize.max,
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             getTaskStatusViewInCard(isPending, status),
        //             getTaskDateViewInCard(date),
        //           ],
        //         ),
        //         const SizedBox(height: 10),
        //         Text(taskStr),
        //         // EditableText('${task.task}'),
        //         const SizedBox(height: 10),
        //
        //         getDoctorAndHospitalNameViewInCard(
        //             isPending, hospitalName, doctorName),
        //         const SizedBox(height: 10),
        //         getCompleteVisitTaskButtonInCard(
        //             isPending, visitDataProvider),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Widget getFilledColorViewInCard() {
    return Container(
      width: 20,
      // height: 55,
      color: SecondaryRedColor,
      child:
          // Text('')
          const Column(
        children: [
          Text(''),
          // Text('def'),
        ],
      ),
    );
  }

  Widget getTaskStatusViewInCard(bool isPending, String? status) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.circle,
          size: 16,
          color: isPending ? SecondaryRedColor : SecondaryGreenColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '$status',
          style: TextStyle(
            color: isPending ? SecondaryRedColor : SecondaryGreenColor,
          ),
        ),
      ],
    );
  }

  Widget getTaskDateViewInCard(String date) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Icon(
          Icons.access_time_outlined,
          size: 16,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(date),
      ],
    );
  }

  Widget getDoctorAndHospitalNameViewInCard(
      bool isPending, String hospitalName, String doctorName) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageIcon(
              AssetImage("images/doctor.png"),
            ),
            Flexible(
              child: Text(doctorName),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Visibility(
              visible: hospitalName.isNotEmpty,
              child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.circle,
                  size: 6,
                  color: PrimaryTealColor,
                ),
              ),
            ),
            Flexible(
              child: Text('  $hospitalName'),
            ),
          ],
        ),
      ],
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ImageIcon(
          AssetImage("images/doctor.png"),
        ),
        Flexible(
          child: Text(doctorName),
        ),
        const SizedBox(
          width: 10,
        ),
        const Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.circle,
            size: 6,
            color: PrimaryTealColor,
          ),
        ),
        // const ImageIcon(
        //   AssetImage("images/doctor.png"),
        // ),
        Flexible(
          child: Text(hospitalName),
        ),
      ],
    );
  }

  Widget getAddNoteView() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        // contentPadding: EdgeInsets.only(top: 20), // add padding to adjust text
        isDense: true,
        hintText: 'Add Notes',
        prefixIcon: Icon(Icons.note_outlined),
      ),
    );
  }

  Widget getCompleteVisitTaskButtonInCard(String? taskId, String? visitId,
      String? note, bool isPending, DataProvider visitDataProvider) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: PrimaryTealColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: () async {
          // apiController.fetchAllVisits();
          bool isTaskUpdated =
              await visitDataProvider.completeVisitTask(taskId, visitId, note);
          String toastText = isTaskUpdated ? 'updated' : 'did not update';
          fToast.showToast(
            child: AppUtils().getCustomToast('Task $toastText successfully.'),
            gravity: ToastGravity.BOTTOM,
            toastDuration: Duration(seconds: 2),
          );
        },
        child: isPending
            ? const Text(
                'Mark as done',
                style: TextStyle(color: whiteColor),
              )
            : const Text(
                'Mark as pending',
                style: TextStyle(color: whiteColor),
              ),
      ),
    );
  }
}
