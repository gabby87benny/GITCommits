# GITCommits

Given Challenge:
We’re looking forward to getting together and digging into some code. In advance of that, we would like you to do the following: 
1. Create a free GitHub account (if you do not already have one) 
2. Create a new GitHub repository 
3. Create a mobile app using Java, Swift or React Native that accomplishes the following: 
    a) Connects to the GitHub API; 
    b) Uses that API to retrieve the most recent commits (at least 25) Note: if you are using Android, try to use Dagger 
    c) Displays those commits in a list with the author, commit hash, and commit message. 
    
    As you create this app, please make frequent commits of your work in progress because we want to be able to follow the process you went through in creating the app. We would like you to provide the link to your public GitHub repo.  Please include any unit tests you performed on this app

# Solution:

1. Displayed the recent GIT commits by fetching data from GITHUB API using URLSession.
2. Implemented MVVM design with POP approach.
3. Displayed results in table view. Designed UI in storyboard using Auto layout and the same supports both orientations.
4. Added activity indicator that displays when network operations are in progress.
5. Handled error and propogated from network layer through UI.
6. Implemented unit test cases for controllers, view models and API layer using XCTestCase.
