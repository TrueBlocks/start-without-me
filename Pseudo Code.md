  
  


StartWithoutMe(timeStamp, place, deposit)

  The constructor allows for the start time and date of the meeting. It takes four additional parameters: (1) 'amount' the deposit amount (default 1) expected to play, (2) 'gracePeriod' (default five mins) the amount of time after the start of the meeting before the random digit is drawn; (3) 'confirmPeriod' (default five mins) the amount of time after the dice is rolled before the 'round' closes; and (4) 'tries' (default 1) the number of tries a user has to call the confirm function before failure.

, gracePeriod, confirmPeriod, tries

function i_wont_be_late()

  A user's calls this function to promise that they will attend the meeting and not be late. If msg.value != 'amount' the function throws. Subsequent calls to this function (after acceptance) will throw and return any sent ether. This function stops working at 'start_time'.

function random_character(int n)

  
IAmComing which throws unless it gets send.value == 1 ether

	RandomCharacter takes a number, ’n' between 0 and 63 which sets the random character checker. This  is called by the curator not earlier than ten minutes and not later than fifteen minutes after the supposed start of the meeting (it throws if he/she tries to enter it outside of this range).

	IAmHere which takes a single character addr[n] (that is, the nth character in the sender’s address. This must be called within ten minutes of the curator setting the character. If the nth character of the sender’s address is correctly sent in, the user can get their money back.

	GetMyShare which takes no parameters, and simply sends the sender’s original ether plus his/her portion of the ethers from those who were late or did not show up.

	SendAllEthere which is called by the curator to close out the game and pay everyone back.

It’s not well thought out, but it seems like it might work. Let me know what you think. I think it would be fun to try to develop this together as a group. I’ll wait until I hear from you and then we can make a GitHub repository.
