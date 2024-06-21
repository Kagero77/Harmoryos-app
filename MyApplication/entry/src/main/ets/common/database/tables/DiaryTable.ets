import relationalStore from '@ohos.data.relationalStore';
import Diary from '../../../viewmodel/Diary';
import CommonConstants from '../../constants/CommonConstants';
import Rdb from '../rdb';

export default class DiaryTable {
  private accountTable = new Rdb(CommonConstants.DIARY_TABLE.tableName, CommonConstants.DIARY_TABLE.sqlCreate,
    CommonConstants.DIARY_TABLE.columns);

  constructor(callback: Function = () => {
  }) {
    this.accountTable.getRdbStore(callback);
  }

  getRdbStore(callback: Function = () => {
  }) {
    this.accountTable.getRdbStore(callback);
  }

  insertData(account: Diary, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(account);
    this.accountTable.insertData(valueBucket, callback);
  }

  deleteData(account: Diary, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.DIARY_TABLE.tableName);
    predicates.equalTo('id', account.id);
    this.accountTable.deleteData(predicates, callback);
  }


  deleteAllData(callback: Function) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.DIARY_TABLE.tableName);

    this.accountTable.deleteData(predicates, callback);
  }

  updateData(account: Diary, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(account);
    let predicates = new relationalStore.RdbPredicates(CommonConstants.DIARY_TABLE.tableName);
    predicates.equalTo('id', account.id);
    this.accountTable.updateData(predicates, valueBucket, callback);
  }

  query( callback: Function ) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.DIARY_TABLE.tableName);
    // if (!isAll) {
    //   predicates.equalTo('amount', amount);
    // }
    this.accountTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      let count: number = resultSet.rowCount;
      if (count === 0 || typeof count === 'string') {
        console.log(`${CommonConstants.TABLE_TAG}` + 'Query no results!');
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result: Diary[] = [];
        for (let i = 0; i < count; i++) {
          let tmp: Diary = {
            id: 0, title: '', content: '', time: ""
          };
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.title = resultSet.getString(resultSet.getColumnIndex('title'));
          tmp.content = resultSet.getString(resultSet.getColumnIndex('content'));
          tmp.time = resultSet.getString(resultSet.getColumnIndex('time'));

          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }
}

function generateBucket(account: Diary): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {};
  obj.title = account.title;
  obj.content = account.content;
  obj.time = account.time;

  return obj;
}