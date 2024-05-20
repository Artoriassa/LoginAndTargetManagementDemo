import Constants from '../common/Constants';

@CustomDialog
@Preview
export default struct AddSubTargetDialog {
  @State subTargetName: string = '';
  private controller?: CustomDialogController;
  onClickOk?: (value: string) => void;

  build() {
    Column() {
      Row() {
        Text($r('app.string.add_sub_target'))
          .margin($r('app.float.margin_m'))
          .fontSize($r('app.float.font_size_l'))
          .fontWeight(FontWeight.Bold)
        Blank()
      }
      .width(Constants.FULL_LENGTH)
      TextInput({ text: this.subTargetName, placeholder: $r('app.string.add_sub_target_placeholder') })
        .backgroundColor($r('app.color.mainPage_backgroundColor'))
        .onChange( text => {
          this.subTargetName = text
        })
      .margin({left: $r('app.float.margin_m'), right: $r('app.float.margin_m')})
      Row() {
        Text($r('app.string.cancel'))
          .fontColor(Color.Blue)
          .onClick(() => {
            this.controller?.close();
          })
        Blank().width(Constants.LENGTH_HUNDRED)
        Text($r('app.string.ok'))
          .fontColor(Color.Blue)
          .onClick(() => {
            this.onClickOk(this.subTargetName)
          })
      }
      .margin($r('app.float.margin_m'))
    }
    .backgroundColor(Color.White)
  }
}