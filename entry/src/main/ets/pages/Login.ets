@Entry
@Component
struct Login {
  @State accountText: string = ''
  @State passwordText: string = ''

  build() {
      Column({ space: 8 }) {
        Blank().height(60)
        Image($r('app.media.login_logo'))
          .width(100)
        Text($r('app.string.login_page'))
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
        Text($r('app.string.login_tips'))
          .fontColor(Color.Gray)
          .margin({ bottom: 20 })
        TextInput({ text: this.accountText, placeholder: '账号'})
          .backgroundColor($r('app.color.start_window_background'))
        Line()
          .width('90%')
          .height(0.5)
          .backgroundColor(Color.Gray)
        TextInput({ text: this.passwordText, placeholder: '密码'})
          .type(InputType.Password)
          .backgroundColor($r('app.color.start_window_background'))
        Line()
          .width('90%')
          .height(0.5)
          .backgroundColor(Color.Gray)
        Row() {
          Text('短信验证码登陆')
            .fontColor(Color.Blue)
          Text('忘记密码')
            .fontColor(Color.Blue)
        }
        .width('90%')
        .justifyContent(FlexAlign.SpaceBetween)
        Blank().height(60)
        Button('登陆')
          .width('90%')
        Button('注册账号')
          .width('90%')
          .fontColor(Color.Blue)
          .backgroundColor(Color.Transparent)
        if (false) {
          LoadingProgress()
            .color(Color.Black)
            .width(36)
            .height(36)
        } else {
          Blank().height(36)
        }
        Text('其他登陆方式')
          .fontColor(Color.Gray)
          .fontSize(16)
        .margin({ bottom: 8, top: 60 })
          Row() {
            Image($r('app.media.login_method1'))
              .width(50)
            Image($r('app.media.login_method2'))
              .width(50)
            Image($r('app.media.login_method3'))
              .width(50)
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')

  }
}