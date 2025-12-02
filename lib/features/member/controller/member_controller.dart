import 'package:gibas/core/app/constant.dart';
import 'package:gibas/core/utils/debouncer.dart';
import 'package:gibas/domain/models/base_model.dart';
import 'package:gibas/domain/models/base_params.dart';
import 'package:gibas/features/member/model/member.dart';
import 'package:gibas/features/member/repository/promotion_repository.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MemberController extends GetxController with StateMixin<Member> {
  late PromotionRepository promotionRepository;
  List<BaseModel> optionsFilter = [
    BaseModel(id: Constant.statusAll, name: 'Semua'),
    BaseModel(id: Constant.statusImplemented, name: 'Sudah Di Setujui'),
    BaseModel(id: Constant.statusNotImplemented, name: 'Belum Di Setujui'),
  ];
  BaseModel? selectedFilter;
  final PagingController<int, Member> pagingController = PagingController(firstPageKey: 1);
  final BaseParams params = BaseParams();
  final Debouncer debouncer = Debouncer(milliseconds: 500);

  @override
  void onInit() {
    promotionRepository = PromotionRepository();
    selectedFilter = optionsFilter.first;
    change(Get.arguments, status: RxStatus.success());
    // params.programId = state?.programId;
    pagingController.addPageRequestListener((pageKey) {
      fetchMember(pageKey);
    });
    super.onInit();
  }

  void fetchMember(int page) async {
    params.page = page;
    final members = [
      Member(
        name: 'Chairil Rafi Purnama',
        department: 'Arcamanik',
        phone: '08123456789',
      ),
      Member(
        name: 'Andi Saputra',
        department: 'Cibiru',
        phone: '08111111111',
      ),
      Member(
        name: 'Budi Santoso',
        department: 'Antapani',
        phone: '08222222222',
      ),
      Member(
        name: 'Citra Dewi',
        department: 'Lengkong',
        phone: '08333333333',
      ),
      Member(
        name: 'Dian Permata',
        department: 'Cicadas',
        phone: '08444444444',
      ),
      Member(
        name: 'Eko Pratama',
        department: 'Ujungberung',
        phone: '08555555555',
      ),
      Member(
        name: 'Fajar Hidayat',
        department: 'Sukajadi',
        phone: '08666666666',
      ),
      Member(
        name: 'Gita Anggraini',
        department: 'Cimahi',
        phone: '08777777777',
      ),
      Member(
        name: 'Hendra Gunawan',
        department: 'Dayeuhkolot',
        phone: '08888888888',
      ),
      Member(
        name: 'Indah Lestari',
        department: 'Cileunyi',
        phone: '08999999999',
      ),
    ];
    pagingController.appendLastPage(members);
  }

  void onSelectFilter(BaseModel? value) {
    selectedFilter = value;
    pagingController.refresh();
  }

  void onNavAdd() {
    // Get.to(() => const PromotionFormView())!.then(
    //   (value) {
    //     if (value ?? false) {
    //       pagingController.refresh();
    //     }
    //   },
    // );
  }

  void onClickOutlet(int index) {
    // if (pagingController.itemList?[index].isImplemented ?? false) {
    //   onNavDetail(index);
    // } else {
    //   onNavForm(index);
    // }
  }

  void onNavForm(int index) {
    // Get.to(() => const PromotionFormView(), arguments: pagingController.itemList?[index])!.then(
    //   (value) {
    //     if (value ?? false) {
    //       pagingController.refresh();
    //     }
    //   },
    // );
  }

  void onNavDetail(int index) {
    // Get.to(() => const PromotionOutletDetailView(), arguments: pagingController.itemList?[index]);
  }

  void onSearch(String? value) {
    debouncer.run(() {
      params.name = value;
      pagingController.refresh();
    });
  }
}
