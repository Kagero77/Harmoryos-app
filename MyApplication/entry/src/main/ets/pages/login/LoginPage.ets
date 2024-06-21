import router from '@ohos.router'
import promptAction from '@ohos.promptAction';
import { Toast } from '../Toast';
import { SPManager } from '../SPManager';
import InputDialog from '../../common/dialog/InputDialog';


@Extend(TextInput) function inputStyle() {
  .width("80%")
  .height(50)
  .margin(20)
  .borderRadius(20)
  .fontSize(30)
  .type(InputType.Normal)
  .fontColor(Color.White)
  .backgroundColor("#3fff")
}


@Entry
@Component
struct LoginPage {
  @State pwd: string = "123456";
  private isToHomePage: boolean = false;

  // 自定义提示框
  private inputDialog: CustomDialogController = new CustomDialogController({
    builder: InputDialog({
      inputValue: $pwd,
      cancel: () => {

      },
      confirm: () => {
        if(this.pwd == '') {
          Toast.showToast($r("app.string.input_pwd"))
          return
        }
        SPManager.getInstance().save("pwd", this.pwd)
        SPManager.getInstance().save("isFirstEnter", "0")
        Toast.showToast($r("app.string.set_pwd_success"))
      }
    }),
  })

  async aboutToAppear() {
    let isFirstEnter = await SPManager.getInstance().get("isFirstEnter", "1") as string
    if (isFirstEnter == '1') {
      this.inputDialog.open()
    }
  }

  async toLogin() {
    if (this.pwd.trim() == '') {
      promptAction.showToast({
        message: $r("app.string.input_pwd"),
        duration: 2000,
        bottom: 400
      })
      return;
    }

    let inputPwd = await SPManager.getInstance().get("pwd", "") as string
    Toast.showToast($r("app.string.login_success"))
    router.pushUrl({
      url: "pages/diary/DiaryListPage"
    })
  }

  onPageHide() {
    this.isToHomePage && router.clear();
  }

  build() {

    Stack() {
      Row() {
        Column() {


          Text($r("app.string.welcome_login"))
            .fontSize(30)
            .fontColor("#fff")
            .margin({
              top: 20
            })


          TextInput({ placeholder: $r("app.string.input_pwd"), text: this.pwd })
            .inputStyle()
            .type(InputType.Password)
            .onChange(value => {
              this.pwd = value;
            })


          Button($r("app.string.login"), { type: ButtonType.Capsule })
            .backgroundColor('#1296db')
            .width("75%")
            .height(55)
            .fontSize(30)
            .type(ButtonType.Normal)
            .borderRadius(8)
            .margin(30)
            .onClick(() => {
              this.toLogin();
            })
        }.width('90%')
        .margin({ left: '5%' })
        .borderRadius(8)
        .backgroundColor("#e333")

      }
      .width('100%')
      .height("100%")
      .backgroundImage($r("app.media.login_bg"))
      .backgroundImageSize({ width: '100%', height: '100%' })

    }

  }
}