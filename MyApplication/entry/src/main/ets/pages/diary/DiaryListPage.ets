import CommonConstants from '../../common/constants/CommonConstants';
import { TitleBar } from '../TitleBar'
import router from '@ohos.router';
import Diary from '../../viewmodel/Diary';
import DiaryTable from '../../common/database/tables/DiaryTable';

@Entry
@Component
struct DiaryListPage {
  @State accounts: Array<Diary> = [];
  private bmiTable = new DiaryTable(() => {
  });

  aboutToAppear() {
    this.selectAll()
    setInterval(e => {
      this.selectAll()
    }, 2000)
  }

  selectAll() {
    this.bmiTable.getRdbStore(() => {
      this.bmiTable.query((result: Diary[]) => {
        this.accounts = result;
      });
    });
  }

  build() {
    Column() {
      TitleBar({
        title: $r("app.string.my_dariy"),
        isShowLeft: false,
        isShowRight: true,
        rightImage: $r("app.media.icon_add"),
        rightClickEvent: () => {
          router.pushUrl({
            url: "pages/diary/DiaryAddPage",
            params: {
              add: true
            }
          })
        }
      })


      Divider().width('100%').height(1).backgroundColor("#777")


      List({ space: 3 }) {
        ForEach(this.accounts, (item: Diary) => {
          ListItem() {
            Row() {
              Image($r("app.media.travel"))
                .width(60)
                .height(60)
                .borderRadius(100)
                .margin({ left: 10, right: 10 })


              Column() {

                Row() {
                  Text($r("app.string.title"))
                    .textAlign(TextAlign.Start)
                    .margin({ left: 10 })

                  Text(item.title)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .margin({ left: 10 })
                }


                Row() {
                  Text($r("app.string.time"))
                    .textAlign(TextAlign.Start)
                    .margin({ left: 10, top: 10 })


                  Text(item.time)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .margin({ left: 10, top: 10 })
                }.width('100%')

              }

            }
            .width("100%")
            .height(80)
            .margin({ top: 2 })

          }
          .width("100%")
          .margin({ top: 2 })
          .backgroundColor("#fff")
          .borderRadius(10)
          .onClick(e => {
            router.pushUrl({
              url: "pages/diary/DiaryAddPage",
              params: {
                add: false,
                item: item
              }
            })
          })
        }, item => JSON.stringify(item))
      }
      .width('95%')
      .backgroundColor("#eee")
      .margin({ top: 10 })
    }

    .width('100%')
    .height("100%")
    .backgroundImage($r("app.media.login_bg"))
    .backgroundImageSize({ width: '100%', height: '100%' })
  }
}