# Tic-Tac-Toe #

A Tic-Tac-Toe game written in ruby as a tech-test for 8th Light.
___________

## How to:

* Run the Game:

```plain
$ git clone https://github.com/Kotauror/Tic_Tac_Toe_8th_Light
```
> If you don't have a bundler - tool to track and install gems - run
```plain
$ gem install bundler
```

```plain
$ bundle
$ cd Tic_Tac_Toe_8th_Light
$ cd lib
$ ruby setup.rb
```

* Run the tests *(74 ex, all passing)*:

```plain  
$ cd Tic_Tac_Toe_8th_Light
$ rspec -fd
```

* See test coverage *(total cov. 97.45%)*:

```plain
$ cd Tic_Tac_Toe_8th_Light/coverage
$ open index.html
```

## Features:

1. Three modes of game: Human vs Human, Human vs Computer, Computer vs Computer;

2. Human player can pick their name and sign(marker);

3. In all modes users are asked to choose who goes first;

4. Command line interface;

5. Surprise Goblet when there's a winner;

6. Colored board and error messages to make the gameflow easier to follow;

7. Computer plays on a medium level - each time it is to make a move, it:
  * randomise whether to make a random move or a best possible move;
  * makes a move selected in the step above.

## Approach

**[Planning]** Before I've started to code I've devoted a day to think about the design of code (discussed in the next paragraph).

**[Dealing with the codebase]** I've tried to use TDD to clean-up the provided codebase, starting with extracting the initial part of game (setup of mode, names, signs, order of players) to a different class, later called `Setup` and `Displayer`. The reason I wanted to work on the provided codebase instead of creating a whole new file was because I've learned at my previous job that clients usuallly want to see what was changed in their file. This idea was too hard to implement though. In order to TDD the code I would have to delete the codebase anyway, so I've decided to stop trying to tidy-up the messy code and build the Game from scratch. I've kept some parts of the initial Game in a tested and refactored form (especially the unbeatable computer logic helped me a lot!)

**[TDD]** In the process of writing the code I was trying to stick to TDD as much as possible. In some cases I've spiked the code first to get a clearer vision of what I want to achieve in a particular method and then deleted it and TDD-ed. At the end of the day, I've reached a 97.45% coverage. The missing lines are:
  * methods which use only build-in ruby methods like `.sample`;
  * `game_play` method in the `Game` class, responsible for running one round in a particular sequence. The reasons for not testing this one are:
    * I've tested all methods used in `game_play` separately;
    * This method uses many methods from many classes to run a round. Testing it would mean that I would have to mock numerous functions from other classes what - I believe - wouldn't serve the purpose of checking if the game calls all the methods and the methods return what I want.
    * Instead of mocking all of these methods, I thought that a better idea would be to write an integration test where I would require all of the files and without any mocks play a complete game. I've decided not to do it because:
      * all the methods used in `game_play` were tested;
      * each time I would change anything in my code, it would probably break this huge test;
      * lastly and the most importantly - I've never written an integration test - I would love to learn about them before I approach this problem. If I were to write this test, it would probably (considering the fact that I'm still a full time Makers Academy student that can work on this challange only on evenings and weekend) vastly postpone delivery of this code.

**[OOD]** From the beginning I've focused very hard on Object Oriented Design, especially separation of concerns. All my classes have dedicated tasks and therefore are very easy to test, understand, and extend. I the most proud of my `Displayer` class that is the only class responsible for dealing with player's input. However, I believe that the `Displayer` can be further separated into smaller classes - one dealing with checking if the input is valid and one responsible for coloring the output. As the UI is pretty well separated, the game is open for adding a more advanced interface as intended by the devs. I've  used dependency injection in case of `Board` (integral part of a particular game) and Liskov substitution principle in case of `Human` and `Computer` players.  

**[Naming]** I've used clear naming. I've also changed the board to display numbers from 1 to 9 instead from 0 to 8 - non-programmers, especially kids, usually count from 1 :)

**[Fun]** The game is meant to be for kids. Therefore I've added some colors and a picture to make it more engaging.

## Design of code:

* `Setup` - responsible for running the initial part of game -  a new instance of `Game` is created, players and their signs are picked, order is set.
* `Displayer` - responsible for getting the input from the user (+checking if the input is correct) and showing the user relevant information like current state of board and errors.
* `Game` - knows of players and board; engine which puts elements together to run the game.
* `Board` - puts signs on board, knows if a field can be picked, knows which slots are available, knows if game is over/there is a tie.
* `Player` - has a name and sign.
* `Human` - simply inherits from Player.
* `Computer` - inherits from Player + picks a move.

## Most important things I've learned:

* Improved my testing skills;
* Learned to separate Input/Output logic to a separate class;
* Learned to work on a task which required from me to cover many unhappy paths.

## Things that I think should be improved / what I want to learn:

* I would love to learn about integration test, or more generally - what is the best way to test a program like this (small methods put together in one engine);
* As a beginner I don't always feel when is the best moment to create a new class. For example my Displayer also validates an input - on the one hand it seems to be ok as validation seems to be an integral part of input, but on the other is the Displayer the right class to do it?

## User Story provided by 8th Light:

```plain
Hello,

I’m the project manager at a Command Line Games, Inc. I have a small dev team and we hired a
consulting company to help us build an app that will feature a number of games for children, one being Tic Tac Toe.

They just demoed the basic version of the Tic Tac Toe game in the console and my boss wasn’t thrilled with what he saw.
The game play was rough. It didn’t function as he expected. We’ve decided to move in a different direction and bring in someone else.  
While my boss doesn’t have a technical background, I do, and we both understand the importance of writing code that can be maintained in the future.
We would like you to improve the existing Tic Tac Toe that the previous firm worked on.
There are a number of issues with the code. Below I’ve listed some of those issues, but I’m sure there are more.

* The game does not gracefully handle bad user input.
* In its current form, it’s supposed to be played at a difficulty level of “hard”, meaning the computer
player cannot be beaten. In reality, however, the computer player can be beaten in certain
situations. This is more like a “medium” difficulty level.
* The game play left a lot to be desired. The user messages are lacking. They’re unclear. It’s
confusing to see the spot that’s selected and the board all on the screen.
It’s easy to get lost in what’s happening.
* It’s weird the way the computer picks its spot without notifying the user.

As you can tell, there are a lot of problems and from what our devs say, the code itself is a mess.
It’s untested and therefore unmaintainable. It’s poorly­written and inflexible.
This puts us in a difficultposition because we have a number of features we would like to add and we’re hoping you can help.
We hope that you’ll be able to help us get the code in a better state.
Without that, our devs don’t even think we’ll be able to implement the new features my boss has requested.
For one thing, the existing code is so coupled to the console that implementing any other UI is nearly impossible!

Below you’ll see a list of the features we’re hoping to add.
* Allow the user to choose the game type (human v. human, computer v. computer, human v.
computer).
* Allow the user to choose which player goes first.
* Allow the user to choose with what “symbol” the players will mark their selections on the board (traditionally it’s “X” and “O”).

Could you implement these features?
Thanks for your help,
Ryan
```
