import Constants from '../common/Constants';
import SubTargetItem from '../models/SubTargetItem';

export class DataModel {
  private subTargetItemData: Array<SubTargetItem> = [new SubTargetItem('子目标1', new Date().toTimeString(), false), new SubTargetItem('子目标1', new Date().toTimeString(), false)];

  getData(): Array<SubTargetItem> {
    return this.subTargetItemData;
  }

  addSubTarget(targetName: string) {

    this.subTargetItemData.push(new SubTargetItem(targetName, this.getCurrentTimeString(), false));
  }

  finishSubTarget(index: number) {
    this.subTargetItemData[index].finished = true
    this.subTargetItemData[index].lastUpdateTime = this.getCurrentTimeString()
  }

  deleteData(selectArr: Array<boolean>) {
    let dataLen = this.subTargetItemData.length - 1;
    for (let i = dataLen; i >= 0; i--) {
      if (selectArr[i]) {
        this.subTargetItemData.splice(i, 1);
      }
    }
  }

  getLatestUpdateTime(): string {
    let dateStringArray: string[] = []
    this.subTargetItemData.forEach((item) => {
      dateStringArray.push(item.lastUpdateTime)
    })
    if (dateStringArray.length === Constants.ZERO) {
      return Constants.DASH;
    }
    let latestDate = dateStringArray[0];
    for (let i = 1; i < dateStringArray.length; i++) {
      if (dateStringArray[i] > latestDate) {
        latestDate = dateStringArray[i];
      }
    }
    return latestDate;
  }

  getCompletedSubTargetsCount(): number {
    let count = 0
    this.subTargetItemData.forEach( item => {
      if (item.finished) {
        count++
      }
    })
    return count
  }

  getTotalSubTargetsCount(): number {
    let count = 0
    this.subTargetItemData.forEach( _ => {
        count++
    })
    return count
  }

  getCurrentTimeString(): string {
    let date = new Date()
    return date.toTimeString()
  }
}

export default new DataModel();
