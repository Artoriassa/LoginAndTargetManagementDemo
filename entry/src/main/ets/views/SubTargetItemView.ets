import Constants from '../common/Constants';
import SubTargetItem from '../models/SubTargetItem';

@Component
export default struct SubTargetItemView {
  private target?: SubTargetItem;

  build() {
    Row({ space: Constants.SPACING_SMALL }) {
      Text(this.target.name)
        .margin({ left: $r('app.float.margin_s') })
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
      .margin({ right: $r('app.float.margin_s') })
      .alignItems(HorizontalAlign.End)
    }
    .borderRadius($r('app.float.border_radius_regular'))
    .backgroundColor(Color.White)
    .height($r('app.float.sub_target_height'))
    .width(Constants.COMMON_LENGTH)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}