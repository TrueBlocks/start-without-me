contract ErrorProne {
  public string lastError;
  public string secondLastError;
  public string thirdLastError;
  ErrorProne() {
  }
  reportError(string errMsg) {
    if (secondLastError != "")
      thirdLastError = secondLastError;
    if (lastError != "") {
      secondLastError = lastError;
    lastError = errMsg;
  }
}

contract Mortal {
  address owner;
  Mortal() {
    owner = msg.sender;
  }
  modifier isOwner {
    if (msg.sender != owner)
    {
      reportError("non-owner '" + msg.sender + "' trying to access function.");
      throw;
    }
    _
  }
  function kill() isOwner {
    suicide(msg.sender);
  }
}

contract StartWithoutMe is Mortal, ErrorProne {
  uint  startTime;
  string place;
  uint deposit;
  uint gracePeriod;
  uint tries;
  map deposits(address => uint);
  StartWithoutMe(uint _startTime, string _place, uint _deposit, uint _gracePeriod, uint _tries) {
      startTime = _startTime;
      place = _place;
      deposit = _deposit;
      gracePeriod = _gracePeriod;
      tries = _tries;
  }
  function i_promise_to_be_on_time() {
    if (msg.value != deposit)
    {
      reportError("incorrect amount of ether sent.");
      throw;
    }
    if (deposits[msg.sender] != 0)
    {
      reportError("already registered.");
      throw;
    }
    deposits[msg.sender] = msg.value;
    DepositAccepted(msg.sender, now);
  }
  event DepositAccepted(address addr, uint timeStamp);
}
