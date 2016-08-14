# Start-Without-Me
A simple Ethereum dapp that helps people keep their commitments to attending a meeting on time.

  1.	A smart contract intended to incentivize on-time attendance at a meeting.

  2.	Each attendee sends some ether to the contract prior to the meeting date.

  3.	Five minutes (gracePeriod) after start of the meeting, coordinator randomly chooses a positive integer less than 64 (‘n’). This is done publically in front of those present. Anyone present may then call a function to note ‘n’.

  4.	Each person then present has five minutes (presentPeriod) and one chance (tries) to reclaim their ether by calling a different function with the n'th character of their Ethereum address. If they send the right character, the contract returns their ether.

  5.	If they do not send the right character (either by not being present, by sending the character too late, or by sending the wrong character), they forfeit their ether.

  6.	After 'gracePeriod' plus 'presentPeriod' minutes, attendance is closed, and any ether remaining in the kitty is distributed evenly among those present. (In sum: if you’re late or not present, you lose your money).

  7.	The cost of refreshments for the meeting is split among those present.

The contract is called ‘Start Without Me.’ If you’re always on time, you will like it. If you're usually late, it might incentivize you to fix your bad habit.

##Why is it Interesting:

  1.	An important aspect of this idea is to incorporate ‘being present’ as part of the operation of a smart contract. Participant's precence is 'real-world' data. In that sense, this data is an oracle. The project models a method to incorporate real world data into the operation of a smart contract. Barring people calling their friends with the value of 'n', only those present will be able to retreive their ether.

  2.	This incentivizes action in the real world with a smart contract.

  3.	For those attendees to the meeting that don't participate (i.e. don't send ether), they end up spending potentially more on their food than those that make a commitment of being on time (as long as there are people who are late). If no one is late, then no one is late, which is the purpose of the contract
	
  


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
