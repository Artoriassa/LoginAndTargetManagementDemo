import Constants from '../common/Constants';
import SubTargetItem from '../models/SubTargetItem';

@Component
export default struct SubTargetItemView {
  @State target: SubTargetItem = new SubTargetItem('子目标1', '2024/05/01', false)

  build() {
    Row({ space: 8 }) {
      Text(this.target.name)
        .margin({ left: 8 })
      Column({ space: 4 }) {
        if (this.target.finished) {
          Text('100%')
            .fontSize($r('app.float.font_size_s'))
            .fontWeight(FontWeight.Bold)
        } else {
          Text('0%')
            .fontSize($r('app.float.font_size_s'))
            .fontWeight(FontWeight.Bold)
        }
        Text('更新时间' + this.target.lastUpdateTime)
          .fontColor(Color.Gray)
          .fontSize($r('app.float.font_size_s'))
      }
      .margin({ right: 8 })
      .alignItems(HorizontalAlign.End)
    }
    .borderRadius(12)
    .backgroundColor(Color.White)
    .height(60)
    .width(Constants.COMMON_LENGTH)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}