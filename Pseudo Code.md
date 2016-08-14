#Pseduo Code for StartWithoutMe project  

This document spells out the basic workings of the smart contract. We are working on the code and will release it as soon as it is ready. In the meantime, please enjoy this pseduo-code. If you see any glaring holes, problems, or opportunities for improvement, please let us know.

##constructor StartWithoutMe(startTime, place, deposit, gracePeriods, tries)

  The constructor specifies the *startTime* and the *place* of the meeting along with a *deposit*. The *deposit* serves as a promise from the participant that they will be on time. The remaining parameters (*gracePeriod* and *tries*) allow finer control of how the contract operates. The **msg.sender** to the constructor becomes the coordinator for the meeting.
  
  If a meeting is cancled or its time or place need to be changed, the coordinator calls *cancleMeeting* which refunds each attendee's ether and kills the contract. A new meeting can be initiated if desired. A later version of this code may allow for a meeting to be rescheduled, but this opens the possiblity of an unscrupulous meeting coordinator absconding with the funds by changing the time and place unbeknownst to the other attendees, therefore, once instantiated, a meeting cannot be altered.

##function i_promise_to_be_on_time()

  Each user calls this function to promise that they will attend the meeting on time (within the *gracePeriod*. If msg.value != 'deposit' the function throws.
  
  Subsequent calls to this function (after it has been sucessfully called) will throw thereby insuring that an attendee does not promise twice. This function will throw if it is called after the scheduled start of the meeting (that is, after *startTime*). The function records the user's ether mapped to his/her account.
  
  Note that there is no way for a user to promise to come to a meeting and then later back out. This is a possible place for improvement.

##function random_character(int n)

  After *startTime* plus *gracePeriod* the coordinator calls this function with a character that has been chosen by those present at the meeting. Those present may use any method to choose **n**. For example, a 64-sided dice or two 8-sided dice may be rolled. *n* must be between '0' and '63' inclusive. Once *n* is chosen, the coordinator calls this function to inform the smart contract of the expected character each user will be sending in order to reclaim their deposit. Note that only those present will know the value of *n*. Only the coordinator may call this function.

##function i_am_here(string char)

  Called by any participant and sent with '0' ether, the caller should send the *n*th character in his/her Ethereum account's address. If the wrong character is sent, the function throws. If the function is called by an account and fails more than *tries* times, the ether is forfeit. If the function is called later than startTime + (2 * gracePeriod) the caller's deposit is forfeit. (The first *gracePeriod* is used to decide on *n*, the second *gracePeriod* is for users to reclaim their ether.) For example, if *n* is three (3) then an Ethereum address '0xabcdefg...' would send the letter 'c' to this function. Upon sucessful completion, this function returns the caller's *deposit*.
  
##function closeAttendance()

  This function, called only by the coordinator, closes out the attendance portion of the meeting. This function may only be called after *startTime* + (2 * *gracePeriod*). It closes out the meeting's attendance and splits the remaining ether among those who sucessfully called **i_am_here**. Upon sucessful completion, the function calls 'kill' to remove the code from the blockchain.
  
##function getMyDeposit()

  This function may be called any time after *startTime* + (2 * *gracePeriod*) to return a user's deposit if they sucessfully proved they were present. This is in case the coordinator never calls **closeAttendance** for some reason.
