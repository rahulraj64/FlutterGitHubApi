class Member {

  String userName, profilePixUrl;

  Member(this.userName, this.profilePixUrl) {
    if(userName == null) {
      throw new ArgumentError("The user name should not be null");
    }
  }


}