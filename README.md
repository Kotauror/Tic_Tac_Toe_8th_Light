# Tic-Tac-Toe #

A Tic-Tac-Toe game written in ruby as a tech-test for 8th Light.
___________

## How to:

#### Run the Game:

```plain
$ git clone https://github.com/Kotauror/Tic_Tac_Toe_8th_Light
```
> If you don't have a bundler - tool to track and install gems - run $ gem install bundler

```plain
$ bundle
$ cd Tic_Tac_Toe_8th_Light
$ cd lib
$ ruby setup.rb
```

#### Run the tests:

```plain  
$ cd Tic_Tac_Toe_8th_Light
$ rspec -fd
```

#### See test coverage *(97.45%)*:

```plain
$ cd Tic_Tac_Toe_8th_Light/coverage
$ open index.html
```

## Features:

1. Three modes of game: Human vs Human, Human vs Computer, Computer vs Computer;

2. Human player can pick their name and sign(marker);

3. In all modes users are asked to choose who goes first;

4. Command-line interface;

5. Goblet for the winner;

6. Colored board and error messages to make the flow of the game easier to follow;

7. Computer plays on a medium level - each time it is to make a move, it:
  * randomizes whether to make a random move or a best possible move;
  * makes a move selected in the step above.

## Approach

**[Planning]** Before I've started to code I've devoted a significant amount of time to think about the design of code (discussed in the next paragraph).

**[Dealing with the codebase]** I've tried to use TDD to clean-up the provided codebase, starting with extracting the initial part of game (setup of mode, names, signs, order of players) to a different class, later called `Setup` and `Displayer`. The reason I wanted to work on the provided codebase instead of creating a whole new file was because I've learned at my previous job that clients usually want to see how their file was modified. This idea was too hard to implement though. In order to TDD the code I would have to delete the codebase anyway, so I've decided to stop trying to tidy-up the messy code and build the Game from scratch. I've kept some parts of the initial Game in a tested and refactored form (especially the unbeatable computer logic helped me a lot!)

**[TDD]** In the process of writing the code I was trying to stick to TDD as much as possible. In some cases I spiked the code first to get a clearer vision of what I want to achieve in a particular method and then deleted it and TDD-ed. At the end of the day, I've reached a 97.45% coverage. The missing lines are:
  * methods which use only build-in ruby methods like `.sample`;
  * `game_play` method in the `Game` class, responsible for running one round in a particular sequence. The reasons for not testing this one are:
    * I've tested all methods used in `game_play` separately (but I understand that the sequence of these methods wasn't tested);
    * This method uses many methods from many classes to run a round. Testing it would mean that I would have to mock numerous functions from other classes what - I believe - wouldn't serve the purpose of checking if the game calls all the methods and the methods return what I want.
    * Instead of mocking all of these methods, I thought that a better idea would be to write an integration test where I would require all of the files and without any mocks play a complete game. I've decided not to do it because:
      * all the methods used in `game_play` were tested;
      * each time I would change anything in my code, it would probably break this huge test;
      * lastly and the most importantly - I've never written a big and complex integration test in ruby - I would love to learn about them before I approach this problem. If I were to write this test, it would probably (considering the fact that I'm still a full time Makers Academy student that can work on this challange only on evenings and during the weekends) vastly postpone delivery of this code.

**[OOD]** From the beginning I've focused very hard on Object-Oriented Design, especially separation of concerns. All my classes have dedicated tasks and therefore are very easy to test, understand, and extend. I am the most proud of my `Displayer` class that is the only class responsible for dealing with player's input. However, I believe that the `Displayer` can be further separated into smaller classes - one dealing with checking if the input is valid and one responsible for coloring the output. As the UI is pretty well separated, the game is open for adding a more advanced interface as intended by the devs. I've  used dependency injection in case of `Board` (integral part of a particular game) and inheritance in case of `Human` and `Computer` players (both extending `Player` class).  

**[Naming]** I've used clear naming. I've also changed the board to display numbers from 1 to 9 instead from 0 to 8 - non-programmers, especially kids, usually count from 1 :)

**[Fun/UX]** The game is meant to be for kids. Therefore I've added some colors and a picture to make it more engaging.

## Design of code:

* `Setup` - responsible for running the initial part of game -  a new instance of `Game` is created, players and their signs are picked, order is set.
* `Displayer` - responsible for getting the input from the user (+checking if the input is correct) and showing the user relevant information like current state of board and errors.
* `Game` - knows of players and board; engine which puts elements together to run the game.
* `Board` - puts signs on board, knows which slots are available, knows if game is over/there is a tie.
* `Player` - has a name and sign.
* `Human` - simply inherits from Player.
* `Computer` - inherits from Player + picks a move.

## Most important things I've learned:

* Improved my testing skills;
* Learned to separate Input/Output logic to a special class;
* Learned to work on a task which required from me to cover many unhappy paths.

## Things that I think should be improved / what I want to learn:

* I would love to learn about integration tests, or more generally - what is the best way to test a program like this (small methods put together in one engine);
* As a beginner I don't always feel when is the best moment to create a new class. For example my `Displayer` also validates an input - on the one hand it seems to be ok as validation seems to be an integral part of the input, but on the other is the `Displayer` the right class to do it?
