import promptAction from '@ohos.promptAction'

export class Toast {
  static showToast(msg: string | Resource, duration: number = 2000, bottom: number = 400): void {
    promptAction.showToast({
      message: msg,
      duration: duration,
      bottom: bottom
    })
  }
}


