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
