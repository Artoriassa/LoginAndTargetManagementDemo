export class DateHelper {
  public getCurrentTimeString(): string {
    let date = new Date()
    return date.toTimeString()
  }
}

export default new DateHelper()