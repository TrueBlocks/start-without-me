contract Mortal {
  address owner;
  Mortal() {
    owner = msg.sender;
  }
  modifier isOwner {
    if (msg.sender != owner)
      throw;
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
  uint8 nChar;
  map deposits(address => uint);
  StartWithoutMe(uint _startTime, string _place, uint _deposit, uint _gracePeriod, uint _tries) {
      startTime = _startTime;
      place = _place;
      deposit = _deposit;
      gracePeriod = _gracePeriod;
      tries = _tries;
      nChar = uint(-1);
  }

  modifier noDeposit() {
    if (deposits[msg.sender] != 0)
      throw;
    _
  }
  
  modifier hasDeposit() {
    if (noDeposit())
      throw;
    _
  }
  
  function i_promise_to_be_on_time() noDeposit() {

    // wrong deposit amount?
    if (msg.value != deposit)
      throw;

    deposits[msg.sender] = msg.value;
    DepositAccepted(msg.sender, now);
  }

  function setN(uint _n) isOwner() {
    // to big?
    if (n > 63)
      throw;

    // too early?
    if (now < (startTime + gracePeriod))
      throw;

    // too late?
    if (now > (startTime + (2*gracePeriod)))
      throw;

    // already set?
    if (nChar != uint8(-1))
      throw;

    nChar = _n;
  }

  function i_am_here(string ch) hasDeposit() {
    string wanted = getNthCharacter(msg.sender);
    if (ch == wanted)
    {
        // refund the users deposit
        uint amt2Send = deposits[msg.sender];
        deposits[msg.sender] = 0; // clear this out before send to avoid recursive exploit
        if (!send(msg.sender, amt2Send))
          throw;
        DepositRefunded(msg.sender,amt2Send);
    }
    // user sent wrong character
    nTries[msg.sender] = nTries[msg.sender]+1;
    FailedAttempt(msg.sender,ch);
  }

  event DepositAccepted(address addr, uint timeStamp);
  event FailedAttempt(address addr, string ch);
  event DepositRefunded(address addr, uint amount);
}
