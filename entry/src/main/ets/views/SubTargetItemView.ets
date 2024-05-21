import Constants from '../common/Constants';
import SubTargetItem from '../models/SubTargetItem';
import DataModel from '../viewModel/DataModel';

@Component
export default struct SubTargetItemView {
  @State private target?: SubTargetItem = new SubTargetItem('', '', false)
  @State isExpanded: boolean = false
  @Prop isEditMode: boolean
  @Link selectionsArray: boolean[]
  private index: number
  private onFinishSubTarget: (index: number) => void

  build() {
    Column({ space: Constants.SPACING_SMALL }) {
      this.mainContent()
      if (this.isExpanded) {
        this.expandedContent()
      }
    }
    .width(Constants.COMMON_LENGTH)
    .borderRadius($r('app.float.border_radius_regular'))
    .backgroundColor(Color.White)
    .onClick(() => {
      this.isExpanded = !this.isExpanded
    })
  }

  @Builder mainContent() {
    Row({ space: Constants.SPACING_SMALL }) {
      Text(this.target.name)
        .margin({ left: $r('app.float.margin_m') })
      Row() {
        Column({ space: Constants.SPACING_EXTRA_SMALL }) {
          if (this.target.finished) {
            Text($r('app.string.sub_target_finished'))
              .fontSize($r('app.float.font_size_s'))
              .fontWeight(FontWeight.Bold)
          } else {
            Text($r('app.string.sub_target_not_finished'))
              .fontSize($r('app.float.font_size_s'))
              .fontWeight(FontWeight.Bold)
          }
          Row() {
            Text($r('app.string.update_time'))
              .fontColor(Color.Gray)
              .fontSize($r('app.float.font_size_s'))
            Text(Constants.COLON + Constants.SPACE + this.target.lastUpdateTime)
              .fontColor(Color.Gray)
              .fontSize($r('app.float.font_size_s'))
          }
        }
        .margin({ right: $r('app.float.margin_m') })
        .alignItems(HorizontalAlign.End)
        if (this.isEditMode) {
          Checkbox()
            .margin({ right: $r('app.float.margin_m') })
            .select(this.selectionsArray[this.index])
            .onChange((isCheck: boolean) => {
              this.selectionsArray[this.index] = isCheck;
            })
        }
      }
    }
    .height($r('app.float.sub_target_height'))
    .width(Constants.FULL_LENGTH)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder expandedContent() {
    Row() {
      Text($r('app.string.cancel'))
        .fontColor(Color.Blue)
        .onClick(() => {
          this.isExpanded = false
        })
      Text($r('app.string.complete'))
        .fontColor(Color.Blue)
        .onClick(() => {
          this.onFinishSubTarget(this.index)
          this.isExpanded = false
        })
    }
    .justifyContent(FlexAlign.SpaceAround)
    .width(Constants.FULL_LENGTH)
    .margin({ bottom: $r('app.float.margin_m') })
  }
}