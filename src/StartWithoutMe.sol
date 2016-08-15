contract Mortal {
  address owner;
  function Mortal() {
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

contract StartWithoutMe is Mortal {
  uint  startTime;
  string place;
  uint deposit;
  uint gracePeriod;
  uint tries;
  uint8 nChar;
  mapping (address => uint) public deposits;
  mapping (address => uint) public nTries;
  function StartWithoutMe(uint _startTime, string _place, uint _deposit, uint _gracePeriod, uint _tries) {
      startTime = _startTime;
      place = _place;
      deposit = _deposit;
      gracePeriod = _gracePeriod;
      tries = _tries;
      nChar = uint8(-1);
  }

  modifier noDeposit() {
    if (deposits[msg.sender] != 0)
      throw;
    _
  }
  
  modifier hasDeposit() {
    if (deposits[msg.sender] == 0)
      throw;
    _
  }
  
  function i_promise_to_be_on_time() noDeposit {

    // wrong deposit amount?
    if (msg.value != deposit)
      throw;

    deposits[msg.sender] = msg.value;
    DepositAccepted(msg.sender, now);
  }

  function setN(uint8 _n) isOwner {
    // to big?
    if (_n > 63)
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

  function i_am_here(string ch) hasDeposit {

    nTries[msg.sender] = nTries[msg.sender]+1;
    if (compareCharAt(msg.sender, ch, nChar))
    {
        // refund the users deposit
        uint amt2Send = deposits[msg.sender];
        deposits[msg.sender] = 0; // clear this out before send to avoid recursive exploit
        if (!msg.sender.send(amt2Send))
          throw;
        DepositRefunded(msg.sender,amt2Send);
        return;
    }

    // user sent wrong character
    FailedAttempt(msg.sender,ch);
  }

  function compareCharAt(address addr, string ch, uint8 at) returns (bool) {
        bytes memory a = toBytes(addr);
        return (a[at] == bytes(ch)[0]);
  }
    
  function toBytes(address x) returns (bytes b) {
    b = new bytes(20);
    for (uint i = 0; i < 20; i++)
      b[i] = byte(uint8(uint(x) / (2**(8*(19 - i)))));
  }

  event DepositAccepted(address addr, uint timeStamp);
  event FailedAttempt(address addr, string ch);
  event DepositRefunded(address addr, uint amount);
}
