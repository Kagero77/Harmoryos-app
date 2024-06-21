import router from '@ohos.router';
import CommonConstants from '../../common/constants/CommonConstants';
import { SPManager } from '../SPManager';


@Entry
@Component
struct AdvertisingPage {
  @State countDownSeconds: number = 5;
  private timeId: number;

  onPageShow() {
    SPManager.getInstance()
    this.timeId = setInterval(() => {
      if (this.countDownSeconds == 0) {
        this.jumpToAppHomePage();
      } else {
        this.countDownSeconds--;
      }
    }, 1000);
  }

  onPageHide() {
    clearInterval(this.timeId);
    router.clear()
  }

  /**
   * Jump to app home page.
   */
  jumpToAppHomePage() {
    router.pushUrl({
      url: "pages/login/LoginPage"
    }).catch((error) => {
    });
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Image("https://img2018.cnblogs.com/blog/1489963/201810/1489963-20181012000113032-1847588460.png")
        .width(CommonConstants.FULL_WIDTH)
        .height(CommonConstants.FULL_HEIGHT)
      Text($r('app.string.advertising_text_title', this.countDownSeconds))
        .fontColor(Color.White)
        .fontSize($r('app.float.advertising_text_font_size'))
        .letterSpacing(CommonConstants.ADVERTISING_TITLE_TEXT_LETTER_SPACING)
        .backgroundColor($r('app.color.advertising_text_background_color'))
        .border({
          radius: $r('app.float.advertising_text_radius'),
          width: $r('app.float.advertising_text_border_width'),
          color: Color.White
        })
        .margin({
          top: $r('app.float.advertising_title_text_margin_top'),
          left: $r('app.float.advertising_title_text_margin_left')
        })
        .padding({
          left: $r('app.float.advertising_text_padding_left'),
          top: $r('app.float.advertising_text_padding_top'),
          right: $r('app.float.advertising_text_padding_left'),
          bottom: $r('app.float.advertising_text_padding_bottom')
        })
        .onClick(() => {
          this.jumpToAppHomePage();
        })
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
  }
}
