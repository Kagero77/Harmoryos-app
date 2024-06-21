import router from '@ohos.router';
import DiaryTable from '../../common/database/tables/DiaryTable';
import HintDialog from '../../common/dialog/HintDialog';
import Diary from '../../viewmodel/Diary';
import { TitleBar } from '../TitleBar';
import { Toast } from '../Toast';

@Entry
@Component
struct DiaryAddPage {
  mess_height: string | Resource = $r("app.string.title")
  mess_weight: string | Resource = $r("app.string.content")
  @State nl: number = 0
  @State value: number = 0
  @State pHeight: string = ''
  @State weight: string = ''
  @State timeDay: string = ''
  @State add: boolean = router.getParams()["add"]
  private bmiTable = new DiaryTable(() => {
  });


  // 自定义提示框 - 退出登录
  private dialogController: CustomDialogController = new CustomDialogController({
    builder: HintDialog({
      title: $r("app.string.notice"),
      content: $r("app.string.is_save"),
      cancel: () => {
      },
      confirm: () => {

        let item: Diary
        if (!this.add) {
          item = router.getParams()['item']
          item.title = this.pHeight
          item.content = this.weight

          this.bmiTable.updateData(item, (id: number) => {
            Toast.showToast($r("app.string.save_success"))
            router.back()
          });
        } else {
          item = {
            id: 0,
            title: this.pHeight,
            content: this.weight,
            time: this.timeDay
          }
          this.bmiTable.insertData(item, (id: number) => {
            Toast.showToast($r("app.string.save_success"))
            router.back()
          });

        }


      },

    }),
  })

  calAndSave() {


    if (this.pHeight == '') {
      Toast.showToast($r("app.string.input_title"))
      return
    }

    if (this.weight == '') {
      Toast.showToast($r("app.string.input_content"))
      return
    }


    this.dialogController.open()

  }

  formatDate(date) {
    var year = date.getFullYear(); // 获取年份
    var month = date.getMonth() + 1; // 获取月份
    var day = date.getDate(); // 获取日期

    // 格式化为yyyy-mm-dd格式
    var formattedDate = year + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day);
    return formattedDate;
  }

  aboutToAppear() {
    this.timeDay = this.formatDate(new Date())
    if (!this.add) {
      let item: Diary = router.getParams()['item']
      this.pHeight = item.title
      this.weight = item.content
      this.timeDay = item.time
    }

  }

  build() {
    Column() {
      TitleBar({
        title: $r("app.string.add_dariy"),
        isShowLeft: true,
        isShowRight: false,
      })


      Column() {
        Text($r("app.string.time"))
          .fontSize(20)
          .fontWeight(FontWeight.Normal)
          .alignSelf(ItemAlign.Center)
          .width("100%")
          .margin({ left: 20, top: 20 })


        Text(this.timeDay)
          .fontSize(20)
          .width('90%')
          .height(40)
          .margin({ left: 20, top: 10, right: 2, bottom: 20 })
          .alignSelf(ItemAlign.Start)
          .fontColor("#777")
          .textAlign(TextAlign.Center)
          .padding({ top: 10, bottom: 10 })
          .borderRadius(20)
          .backgroundColor("#eee")
          .onClick(e => {
            // DialogUtils.datePickerDialog(date => {
            //   this.timeDay = date
            //   Logger.error(">>>>>>>>>>>>>>>>>>" + date)
            // })
          })


      }.backgroundColor(Color.Orange).borderRadius(8).width("90%").margin({ top: 20 })


      Row() {
        Column() {
          Text(this.mess_height)
            .fontSize(20)
            .fontWeight(FontWeight.Normal)
            .alignSelf(ItemAlign.Center)
            .width("100%")
            .margin({ left: 20, top: 20 })

          TextInput({ placeholder: $r("app.string.input_title"), text: this.pHeight })
            .fontSize(25)
            .width('90%')
            .height(40)
            .textAlign(TextAlign.Center)
            .type(InputType.Number)
            .backgroundColor("#eee")
            .margin({ top: 10 })
            .onChange((value: string) => {
              this.pHeight = value
            })
        }
      }
      .height('15%')
      .width('90%')
      .backgroundColor(Color.Brown)
      .borderRadius(8)
      .margin({ top: 20 })


      Row() {
        Column() {
          Text(this.mess_weight)
            .fontSize(20)
            .fontWeight(FontWeight.Normal)
            .alignSelf(ItemAlign.Center)
            .width("100%")
            .margin({ left: 20, top: 20 })


          TextInput({ placeholder: $r("app.string.input_content"), text: this.weight })
            .fontSize(25)
            .width('90%')
            .height(145)
            .type(InputType.Number)
            .backgroundColor("#eee")
            .margin({ top: 10, bottom: 20 })
            .textAlign(TextAlign.Center)
            .onChange((value: string) => {
              this.weight = value
            })
        }
      }

      .width('90%')
      .backgroundColor(Color.Orange)
      .borderRadius(8)
      .margin({ top: 20 })


      Button($r("app.string.save"))
        .width('90%')
        .height(50)
        .backgroundColor('#FF8000')
        .margin({ top: 20 })
        .onClick(() => {
          this.calAndSave()
        })

    }

    .width('100%')
    .height("100%")
    .backgroundColor("#eef")
  }
}