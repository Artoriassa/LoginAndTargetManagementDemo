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

  getCurrentTimeString(): string {
    let date = new Date()
    return date.toTimeString()
  }
}

export default new DataModel();
