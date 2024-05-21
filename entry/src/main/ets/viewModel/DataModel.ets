import SubTargetItem from '../models/SubTargetItem';

export class DataModel {
  private subTargetItemData: Array<SubTargetItem> = [new SubTargetItem('子目标1', '2024/05/01', false)];

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

  getCurrentTimeString(): string {
    let date = new Date()
    return date.toTimeString()
  }
}

export default new DataModel();
