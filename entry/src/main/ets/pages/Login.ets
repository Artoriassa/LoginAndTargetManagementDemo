import Constants from '../Common/Constants';

@Entry
@Component
struct Login {
  @State accountText: string = ''
  @State passwordText: string = ''

  build() {
    Column({ space: Constants.SPACING_SMALL }) {
      Blank().height(Constants.LENGTH_SIXTY)
      Image($r('app.media.login_logo'))
        .width($r('app.float.logo_size_xl'))
      Text($r('app.string.login_page'))
        .fontSize($r('app.float.font_size_xl'))
        .fontWeight(FontWeight.Medium)
      Text($r('app.string.login_tips'))
        .fontColor(Color.Gray)
        .margin({ bottom: $r('app.float.margin_xl') })
      TextInput({ text: this.accountText, placeholder: $r('app.string.account') })
        .backgroundColor($r('app.color.start_window_background'))
      Line()
        .width(Constants.COMMON_LENGTH)
        .height($r('app.float.line_height_m'))
        .backgroundColor(Color.Gray)
      TextInput({ text: this.passwordText, placeholder: $r('app.string.password') })
        .type(InputType.Password)
        .backgroundColor($r('app.color.start_window_background'))
      Line()
        .width(Constants.COMMON_LENGTH)
        .height($r('app.float.line_height_m'))
        .backgroundColor(Color.Gray)
      Row() {
        Text($r('app.string.send_verification_code'))
          .fontColor(Color.Blue)
        Text($r('app.string.forget_password'))
          .fontColor(Color.Blue)
      }
      .width(Constants.COMMON_LENGTH)
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height($r('app.float.length_m'))
      Button($r('app.string.user_login'))
        .width(Constants.COMMON_LENGTH)
      Button($r('app.string.register'))
        .width(Constants.COMMON_LENGTH)
        .fontColor(Color.Blue)
        .backgroundColor(Color.Transparent)
      if (false) {
        LoadingProgress()
          .color(Color.Black)
          .width($r('app.float.loading_size'))
          .height($r('app.float.loading_size'))
      } else {
        Blank().height($r('app.float.loading_size'))
      }
      Text($r('app.string.other_login_method'))
        .fontColor(Color.Gray)
        .fontSize($r('app.float.font_size_regular'))
        .margin({ bottom: Constants.SPACING_SMALL, top: Constants.SPACING_EXTRA_LARGE })
      Row() {
        Image($r('app.media.login_method1'))
          .width($r('app.float.logo_size_m'))
        Image($r('app.media.login_method2'))
          .width($r('app.float.logo_size_m'))
        Image($r('app.media.login_method3'))
          .width($r('app.float.logo_size_m'))
      }
      .width(Constants.COMMON_LENGTH)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width(Constants.FULL_LENGTH)

  }
}