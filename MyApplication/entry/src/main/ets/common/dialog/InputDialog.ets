@CustomDialog
export default struct InputDialog {

  @Link inputValue: string
  @State title: string = "";
  notice:string='请输入正确的数据'

  controller: CustomDialogController
  // 若尝试在CustomDialog中传入多个其他的Controller，以实现在CustomDialog中打开另一个或另一些CustomDialog，那么此处需要将指向自己的controller放在最后
  cancel: () => void
  confirm: () => void

  build() {
    Column() {
      Text(this.title).fontSize(20).margin({ top: 10, bottom: 10 })
      TextInput({ placeholder: '', text: this.inputValue }).height(60).width('90%')
        .onChange((value: string) => {
          this.inputValue = value
        })
      Text($r("app.string.set_pwd")).fontSize(16).margin({ bottom: 10 })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button($r("app.string.cancel"))
          .onClick(() => {
            this.controller.close()
            this.cancel()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button($r("app.string.ok"))
          .onClick(() => {

            this.controller.close()
            this.confirm()
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
    // dialog默认的borderRadius为24vp，如果需要使用border属性，请和borderRadius属性一起使用。
  }
}

