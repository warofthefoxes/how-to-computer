==== HOW DO I USE THE COMPUTER? ====

This is a simple Powershell script to open a Powershell window with the contents of **howtocomputer.txt**
The text file can be customized via any text editor but must be saved in the \HowToComputer\ directory. The file currently includes a list of example projects.

++++++ INSTALLATION:

Download \HowToComputer\ folder and store in a safe place.
Right-click and run createScheduledTask.ps1 using Powershell to automatically display the contents of howtocomputer.txt on login.

++++++ FORMATTING:

Lines are colored based on string contents.
  
  Lines containing "++++++" or "====" will be BLUE
  
  Lines containing "USERNAME", "COMMAND", or "REPO" will be GREEN.
  
  All other text is YELLOW.

++++++ PLANNED FEATURES

  - An install script that will take input to schedule task for a time other than logon. 
  - A script to update howtocomputer.txt with a list of relevant projects, replace symbols, and update colors.
  - Possibly display text contents using a popup GUI instead of a terminal window (and give an option to toggle this).
  - Amend script to display filepath where howtocomputer.txt is stored.
