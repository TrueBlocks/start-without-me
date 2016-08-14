# Start-Without-Me
A simple Ethereum dapp that helps people keep their commitments to attending a meeting on time. The contract is called ‘Start Without Me.’ If you’re always on time, you will like it. If you're usually late, it might incentivize you to fix your bad habit.

  1.	A smart contract intended to incentivize on-time attendance at a meeting.

  2.	Each attendee sends some ether to the contract prior to the meeting date.

  3.	Five minutes (*gracePeriod*) after start of the meeting, coordinator randomly chooses a positive integer, **n**, less than 64. This is done publically in front of those present. The coordinator then calls a function that notes ‘n’.

  4.	Each person then present has five minutes (*presentPeriod*) and one chance (*tries*) to reclaim their ether by calling a different function sending the n'th character of their Ethereum address to the contract. If they send the right character, the contract returns their ether.

  5.	If they do not send the right character (either by not being present, by sending the character too late, or by sending the wrong character more than *tries* times), they forfeit their ether.

  6.	After *gracePeriod* plus *presentPeriod* minutes, attendance is closed, and any ether remaining in the contract is distributed evenly among those present. (In sum: if you’re late or you don't show up, you lose your deposit).

  7.	The cost of refreshments for the meeting is split among those present as it would normally be with those present possibly benefiting from those who fail to show up.

You may view [the pseduo code for the project here](https://github.com/Great-Hill-Corporation/Start-Without-Me/blob/master/Pseudo%20Code.md).

##Why the Idea is Interesting:

  1.	An important aspect of this idea is to incorporate ‘being present’ as part of the operation of a smart contract. Participants' precence or absence is 'real-world' data. In that sense, the contract is using an oracle. The contract tries to make the point that all oracles need not be some sort of software code. 'Real-world' data can come from 'real-world' people acting together.
  
  2.	For those attendees to the meeting that do not participate (i.e. don't send ether) there is no downside, other than they may end up spending more on their refreshments than those that make a commitment of being on time (as long as there are people who are late).
  
  3.	If no one is late, then the real purpose of this contract has been met.

##Outstanding Issues
  1.	The contract may actually dis-incentivize people from attending the meeting. For these people, however, they can simply choose to not particpate. Using the contract for a meeting does not mean that someone must commit to coming. It's just that if they do commit, they might benefit from those who commit and fail to come on time.

  2.	There does not seem to be any way to protect someone from calling his/her friend and telling them the value of 'n' other than they would have to sneak off into a corner to do so. The group should watch for people who sneak off into the corner after the value of **n** is decided.

##Contributing

Please help us in any way you can. If you use the contract, let us know. We are open to any and all constructive criticism.
