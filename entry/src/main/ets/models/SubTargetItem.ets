
@Observed
export default class  SubTargetItem {
  public name: string;
  public lastUpdateTime: string;
  public finished: Boolean;

  constructor(name: string, lastUpdateTime: string, finished: Boolean) {
    this.name = name;
    this.lastUpdateTime = lastUpdateTime;
    this.finished = finished;
  }
}