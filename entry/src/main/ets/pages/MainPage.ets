import Constants from '../common/Constants';
import SubTargetItem from '../models/SubTargetItem';
import SubTargetItemView from '../views/SubTargetItemView';
import AddSubTargetDialog from '../views/AddSubTargetDialog';
import DataModel from '../viewModel/DataModel';
import prompt from '@ohos.promptAction';

@Entry
@Component
struct MainPage {
  @State subTargets: SubTargetItem[] = DataModel.getData()
  @State selectionsArray: boolean[] = []
  @State selectAll: boolean = false
  @State isEditMode: boolean = false
  @State latestUpdateTime: string = DataModel.getLatestUpdateTime()
  @State totalSubTargetsCount: number = DataModel.getTotalSubTargetsCount()
  @State completedSubTargetsCount: number = DataModel.getCompletedSubTargetsCount()
  @State clickIndex: number = Constants.ZERO
  dialogController: CustomDialogController = new CustomDialogController({
    builder: AddSubTargetDialog({ onClickOk: (value) => this.addSubTargetAction(value) }),
    autoCancel: true
  });

  build() {
    Column({ space: Constants.SPACING_MEDIUM }) {
      Text($r('app.string.main_target'))
        .width(Constants.COMMON_LENGTH)
        .fontSize($r('app.float.font_size_xl'))
        .fontWeight(FontWeight.Medium)
        .margin({ top: $r('app.float.margin_l') })
      this.mainTargetView()
      this.subTargetsTitle()
      this.subTargetsView()
      this.bottomView()
    }
    .backgroundColor($r('app.color.mainPage_backgroundColor'))
    .width(Constants.FULL_LENGTH)
    .height(Constants.FULL_LENGTH)
    .justifyContent(FlexAlign.Start)
  }

  @Builder mainTargetView() {
    Column({ space: Constants.SPACING_SMALL }) {
      this.mainTargetTopView()
      this.mainTargetBottomView()
    }
    .borderRadius($r('app.float.border_radius_regular'))
    .width(Constants.COMMON_LENGTH)
    .height(Constants.MAIN_TARGET_HEIGHT)
    .backgroundColor(Color.White)
  }

  @Builder mainTargetTopView() {
    Row({ space: Constants.SPACING_SMALL }) {
      Image($r('app.media.target'))
        .width($r('app.float.main_target_pic_width'))
        .height($r('app.float.main_target_pic_height'))
      Column({ space: Constants.SPACING_SMALL }) {
        Text($r('app.string.main_target_title'))
        Text($r('app.string.main_target_sub_title'))
          .fontColor(Color.Gray)
          .fontSize($r('app.float.font_size_s'))
      }
      .height($r('app.float.main_target_pic_height'))
      .alignItems(HorizontalAlign.Start)
    }
    .margin({ top: Constants.SPACING_SMALL })
  }

  @Builder mainTargetBottomView() {
    Row() {
      Column() {
        Text($r('app.string.main_target'))
        Text($r('app.string.update_time'))
          .fontColor(Color.Gray)
          .fontSize($r('app.float.font_size_s'))
        Text(this.latestUpdateTime)
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Progress({ value: this.completedSubTargetsCount, total: this.totalSubTargetsCount, type: ProgressType.Ring })
          .width($r('app.float.progress_ring_diameter'))
          .height($r('app.float.progress_ring_diameter'))
        Row() {
          Text(this.completedSubTargetsCount.toString())
            .fontColor(Color.Blue)
          Text('/' + this.totalSubTargetsCount.toString())
        }
      }
    }
    .height($r('app.float.main_target_pic_height'))
    .width(Constants.COMMON_LENGTH)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder subTargetsTitle() {
    Row() {
      Text($r('app.string.sub_targets'))
        .fontSize($r('app.float.font_size_xl'))
        .fontWeight(FontWeight.Medium)
      if (this.subTargets.length > Constants.ZERO) {
        if (this.isEditMode) {
          Row() {
            Text($r('app.string.cancel'))
              .fontColor(Color.Blue)
              .onClick(() => {
                this.isEditMode = false
                this.selectAllOrNone(false)
              })
            Text($r('app.string.select_all'))
              .fontColor(Color.Blue)
              .margin({ left: $r('app.float.margin_l') })
            Checkbox()
              .select(this.isSelectAll())
              .onClick(() => {
                this.selectAll = !this.selectAll
                this.selectAllOrNone(this.selectAll)
              })
          }
        } else {
          Text($r('app.string.edit'))
            .fontColor(Color.Blue)
            .onClick(() => {
              this.isEditMode = true
              this.selectAllOrNone(false)
            })
        }
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width(Constants.COMMON_LENGTH)
  }

  @Builder subTargetsView() {
    List({ space: Constants.SPACING_EXTRA_SMALL }) {
      ForEach(this.subTargets, (subTarget: SubTargetItem, index: number) => {
        ListItem() {
          SubTargetItemView({
            target: subTarget,
            isEditMode: this.isEditMode,
            selectionsArray: $selectionsArray,
            index: index,
            clickIndex: $clickIndex,
            onFinishSubTarget: (index) => {
              DataModel.finishSubTarget(index)
              this.latestUpdateTime = DataModel.getLatestUpdateTime()
              this.completedSubTargetsCount = DataModel.getCompletedSubTargetsCount()
              DataModel.getData()
            }
          })
        }
      })
    }
    .height(Constants.HALF_LENGTH)
    .width(Constants.FULL_LENGTH)
    .alignListItem(ListItemAlign.Center)
    .scrollBar(BarState.Auto)
  }

  @Builder bottomView() {
    if (this.isEditMode) {
      Button($r('app.string.delete'))
        .backgroundColor(Color.Gray)
        .fontColor(Color.Red)
        .enabled(this.hasSelectedSubTargets() ? true : false)
        .opacity(this.hasSelectedSubTargets() ? $r('app.float.opacity_hundred') : $r('app.float.opacity_thirty'))
        .onClick(() => {
          this.deleteSelectedSubTargets()
          this.completedSubTargetsCount = DataModel.getCompletedSubTargetsCount()
          this.totalSubTargetsCount = DataModel.getTotalSubTargetsCount()
          this.latestUpdateTime = DataModel.getData().length === Constants.ZERO ? Constants.DASH : new Date().toTimeString()
        })
    } else {
      Button($r('app.string.add_sub_target'))
        .fontColor(Color.Blue)
        .backgroundColor(Color.Gray)
        .onClick(() => {
          this.dialogController.open()
        })
    }
  }

  addSubTargetAction(targetName: string) {
    if (targetName !== Constants.EMPTY_STRING) {
      DataModel.addSubTarget(targetName)
      this.latestUpdateTime = DataModel.getLatestUpdateTime()
      this.totalSubTargetsCount = DataModel.getTotalSubTargetsCount()
      this.subTargets = DataModel.getData()
      this.dialogController.close()
      prompt.showToast({
        message: $r('app.string.add_sub_target_successful')
      })
    }
  }

  deleteSelectedSubTargets() {
    DataModel.deleteData(this.selectionsArray)
    this.subTargets = DataModel.getData()
    this.isEditMode = false
  }

  selectAllOrNone(selectStatus: boolean) {
    let newSelectionsArray: Array<boolean> = []
    this.subTargets.forEach(() => {
      newSelectionsArray.push(selectStatus)
    })
    this.selectionsArray = newSelectionsArray
  }

  isSelectAll(): boolean {
    if (this.selectionsArray.length === Constants.ZERO) {
      return false
    }
    let unSelectCount: Length = this.selectionsArray.filter((selected: boolean) => selected === false).length
    if (unSelectCount === Constants.ZERO) {
      this.selectAll = true
      return true
    }
    this.selectAll = false
    return false
  }

  hasSelectedSubTargets(): boolean {
    return this.selectionsArray.filter((selected: boolean) => selected === true).length > Constants.ZERO
  }
}