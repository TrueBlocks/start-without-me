#Pseduo Code for StartWithoutMe project  

This document spells out the basic workings of the smart contract. We are working on the code and will release it as soon as it is ready. In the meantime, please enjoy this pseduo-code. If you see any glaring holes, problems, or opportunities for improvement, please let us know.

##constructor StartWithoutMe(startTime, place, deposit)

  The constructor specifies the *startTime* and the *place* of the meeting along with a *deposit*. *deposit* is intended to serve as a promise from the participant that they will be on time. Various default values are chosen for other settings such as *gracePeriod* (5 minutes), *presentPeriod* (5 minutes), and *tries* (1). Only the meeting's coordinator (the **msg.sender** to the constructor) may alter these other settings. *startTime*, *place*, and *deposit* may not be altered. If a meeting's time or place is changed, the coordinator calls *cancleMeeting* which causes all accumulated ether to be returned to attendees.

##function i_promise_to_be_on_time()

  Each user calls this function to promise that they will attend the meeting and not be late. If msg.value != 'deposit' the function throws. Subsequent calls to this function (after it has been sucessfully called) will throw thereby returning incorrectly sent ether to the caller. This is intended to protect the user from promising twice, for example. This function will throw if it is called after the scheduled start of the meeting (that is, after *startTime*). The function records the user's ether mapped to his/her account.

##function random_character(int n)

  Any time after the *gracePeriod* the coordinator calls this function with a character that has been chosen by those present at the meeting. Any method may be used to choose **n**. For example, a 64-sided dice or two 8-sided dice may be rolled. Once *n* is chosen, the coordinator calls this function to inform the smart contract of the expected character each user will send in order to reclaim their deposit.

IAmComing which throws unless it gets send.value == 1 ether

	RandomCharacter takes a number, ’n' between 0 and 63 which sets the random character checker. This  is called by the curator not earlier than ten minutes and not later than fifteen minutes after the supposed start of the meeting (it throws if he/she tries to enter it outside of this range).

	IAmHere which takes a single character addr[n] (that is, the nth character in the sender’s address. This must be called within ten minutes of the curator setting the character. If the nth character of the sender’s address is correctly sent in, the user can get their money back.

	GetMyShare which takes no parameters, and simply sends the sender’s original ether plus his/her portion of the ethers from those who were late or did not show up.

	SendAllEthere which is called by the curator to close out the game and pay everyone back.

It’s not well thought out, but it seems like it might work. Let me know what you think. I think it would be fun to try to develop this together as a group. I’ll wait until I hear from you and then we can make a GitHub repository.

  allows for the start time and date of the meeting. It takes four additional parameters: (1) 'amount' the deposit amount (default 1) expected to play, (2) 'gracePeriod' (default five mins) the amount of time after the start of the meeting before the random digit is drawn; (3) 'confirmPeriod' (default five mins) the amount of time after the dice is rolled before the 'round' closes; and (4) 'tries' (default 1) the number of tries a user has to call the confirm function before failure.

, gracePeriod, confirmPeriod, tries
