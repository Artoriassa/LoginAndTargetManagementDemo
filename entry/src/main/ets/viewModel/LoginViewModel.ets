import Constants from '../common/Constants';

export class LoginViewModel {
  login(account: string, password: string): boolean {
    return account === '' || password === ''
  }
}

export default new LoginViewModel();
