import SubTargetItem from '../models/SubTargetItem';

export class DataModel {
  private subTargetItemData: Array<SubTargetItem> = [new SubTargetItem('子目标1', '2024/05/01', false)];

  getData(): Array<SubTargetItem> {
    return this.subTargetItemData;
  }

  addData(data: SubTargetItem) {
    if (!data) {
      return;
    }
    this.subTargetItemData.push(data);
  }
}

export default new DataModel();
