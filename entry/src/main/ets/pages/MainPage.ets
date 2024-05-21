import Constants from '../common/Constants';
import SubTargetItem from '../models/SubTargetItem';
import SubTargetItemView from '../views/SubTargetItemView';
import AddSubTargetDialog from '../views/AddSubTargetDialog';
import DataModel from '../viewModel/DataModel';

@Entry
@Component
struct MainPage {
  @State subTargets: SubTargetItem[] = DataModel.getData()
  @State selectionsArray: boolean[] = []
  @State selectAll: boolean = false
  @State isEditMode: boolean = false
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
      Blank()
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
        Text('05/15/2024 15:08')
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Progress({ value: 0, total: 100, type: ProgressType.Ring })
          .width($r('app.float.progress_ring_diameter'))
          .height($r('app.float.progress_ring_diameter'))
        Row() {
          Text('0')
            .fontColor(Color.Blue)
          Text('/0')
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
      if (this.subTargets.length > 0) {
        if (this.isEditMode) {
          Row() {
            Text($r('app.string.cancel'))
              .fontColor(Color.Blue)
              .onClick(() => {
                this.isEditMode = false
              })
            Text($r('app.string.select_all'))
              .fontColor(Color.Blue)
              .margin({ left: $r('app.float.margin_l') })
            Checkbox()
          }
        } else {
          Text($r('app.string.edit'))
            .fontColor(Color.Blue)
            .onClick(() => {
              this.isEditMode = true
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
            onFinishSubTarget: (index) => {
              DataModel.finishSubTarget(index)
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
        })
    } else {
      Button($r('app.string.add_sub_target'))
        .fontColor(Color.Blue)
        .backgroundColor(Color.Gray)
        .onClick(() => {
          this.dialogController.open()
        })
        .margin({ bottom: $r('app.float.margin_l') })
    }
  }

  addSubTargetAction(targetName: string) {
    if (targetName !== Constants.EMPTY_STRING) {
      DataModel.addSubTarget(targetName)
      this.subTargets = DataModel.getData()
      this.dialogController.close()
    }
  }

  deleteSelectedSubTargets() {
    DataModel.deleteData(this.selectionsArray);
    this.subTargets = DataModel.getData();
    this.isEditMode = false;
  }

  hasSelectedSubTargets(): boolean {
    return this.selectionsArray.filter((selected: boolean) => selected === true).length > 0;
  }
}