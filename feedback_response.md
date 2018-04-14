How I approached the feedback requests:

##### Fixing the error: `Traceback (most recent call last): ruby: No such file or directory -- catpix.rb (LoadError)`.
  * Found the failing test;
  * Found the line of code which caused the error:

  ```ruby
    system "ruby catpix.rb goblet.png"
  ```

  * The error was caused because of the fact that I was calling a `system` command in my ruby code, but didn't include this fact in the test. When the test hit the `system` line, it tried to load the file, but it didn't find it as it was located in a different file.
  * I've solved this problem by stubbing the system command:

  ```ruby
    allow(displayer).to receive(:system)
  ```

##### Cleaning the terminal window after each round
  * I was already cleaning the terminal after the initial setup using the `system("clear")` method.
  * Because of this fact, following the DRY principle, I've created a `clear_terminal` method that I'm now using to both:
    - clean the terminal after the initial setup;
    - clean the terminal after each move.

##### Making the computer unbeatable
  * In the initial task I was asked to make to computer play on a **medium** level, so that people should be able to beat it in certain situations.
  * My previous computer either played a random move or an elaborate move depending on a randomiser /see the `README` file for further explanations/.
  * Right now, according to the feedback request, the computer is **unbeatable**.
  * The computer plays according to the following logic:
    - it picks the middle spot if possible;
    - it picks a winning position if possible;
    - it blocks an opponent if possible;
    - it picks a corner when possible;
    - it picks a random move.
  * Implementation of this feature was rather easy thanks to the design decision I've made in the initial version of the game.

##### Stop mocking the class under the test
  * Lastly I was requested to change the tests in which I've mocked methods of the class under test.
  * Instead of mocking the instances of class under test (`Computer`), I've mocked an instance of `Board` class on which the computer makes its moves. Example:

- Previous solution:

```ruby
it 'returns winning position when 5 is not available and winning position is' do
    allow(computer).to receive(:pick_5_when_possible).and_return nil
    ## improved part - mock of class under test
    allow(computer).to receive(:pick_winning_position).and_return "4"
    expect(computer.elaborate_move(board, "K")).to eq "4"
```

- New solution:

```ruby
  it 'returns winning position when 5 is not available and winning position is' do
    allow(board_winning_for_active).to receive(:available_numbers).and_return ["3", "6", "7", "8", "9", "7", "8", "9"]
    allow(board_winning_for_active).to receive(:put_sign_on_board).with("C", "3")
    allow(board_winning_for_active).to receive(:is_game_won?).and_return true
    allow(board_winning_for_active).to receive(:put_sign_on_board).with("3", "3")
    expect(computer.elaborate_move(board_winning_for_active, "K")).to eq "3"
  end
```
