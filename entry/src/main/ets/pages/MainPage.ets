import Constants from '../common/Constants';

@Entry
@Component
struct MainPage {
  build() {
    Column({ space: Constants.SPACING_SMALL }) {
      Text('工作目标')
        .width(Constants.COMMON_LENGTH)
        .fontSize($r('app.float.font_size_xl'))
        .fontWeight(FontWeight.Medium)
        .margin({ top: 16 })
      this.mainTargetView()
      Text('子目标')
        .width(Constants.COMMON_LENGTH)
        .fontSize($r('app.float.font_size_xl'))
        .fontWeight(FontWeight.Medium)
      this.subTargetsView()
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
      .width(Constants.COMMON_LENGTH)
      .height('25%')
      .backgroundColor(Color.White)
  }

  @Builder mainTargetTopView() {
    Row({space:8}) {
      Image($r('app.media.target'))
        .width(120)
        .height(85)
      Column({space:8}) {
        Text('第一季度运营目标')
        Text('实现用户量与用户活跃度提升')
          .fontColor(Color.Gray)
          .fontSize(12)
      }
      .height(85)
      .alignItems(HorizontalAlign.Start)
    }
    .margin({top: 8})
  }

  @Builder mainTargetBottomView() {
    Row() {
      Column({space: 8}) {
        Text('工作目标')
        Text('更新时间')
          .fontColor(Color.Gray)
          .fontSize($r('app.float.font_size_s'))
        Text('05/15/2024 15:08')
      }
      .alignItems(HorizontalAlign.Start)
      Image($r('app.media.icon'))
        .width(40)
    }
    .height(85)
    .width(Constants.COMMON_LENGTH)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder subTargetsView() {

  }
}