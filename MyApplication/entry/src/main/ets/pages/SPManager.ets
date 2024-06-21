import preference from '@ohos.data.preferences';

export class SPManager {
  private static mInstance: SPManager;
  private pre: preference.Preferences;
  private isInitSuccess: boolean = false;

  // 防止实例化
  private constructor() {
  }

  static getInstance(): SPManager {
    if (!SPManager.mInstance) {
      SPManager.mInstance = new SPManager();
      SPManager.mInstance.init();
    }
    return SPManager.mInstance;
  }


  private init() {
    preference.getPreferences(getContext(this), "preference", (error, p) => {
      if (error) {
        console.error("preference初始化失败");
        this.isInitSuccess = false;
        return;
      }
      this.isInitSuccess = true;
      this.pre = p;
      console.error("preference初始化成功");
    })
  }


  has(key: string): boolean {
    if (this.isInitSuccess) {
      this.pre.has(key, res => {
        return res;
      })
    }
    return false;
  }

  save(key: string, value: any) {

    return this.pre.put(key, value, (err, value) => {
      if (err) {
        console.error("写入数据失败----------------->");
        return;
      }
      this.pre.flush()
      console.error("写入数据成功----------------->");
    })
  }

  async get(key: string, defaults: string) {
    return await this.pre.get(key, defaults);
  }
}