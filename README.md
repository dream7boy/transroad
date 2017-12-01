# Workflow for TransRoad
## ▼Before starting new tasks
### ◎On Github
1. `git pull origin master` to get latest master
1. `bundle install` if new gem files are added
1. `rails db:migrate` if any new model created
  - If you need to create DB again, run `rails db:drop db:create db:migrate` or `rails db:reset`
1. `git branch` check which branch you are on
1. `git checkout -b "branch-name"` Create and switch the branch
1. Write codes!!!

### ◎On Trello
1. Pick the card from `User Story`
1. Move the card to `In Progress` and assign yourself (Click `M` on the card) to the card

## ▼After finishing tasks
### ◎On Github
1. Check it works properly or not on your local **(This step is really important!!)**
1. `git status` to check the files you've modified
1. `git add .` to add all the changes to the staging
1. `git commit -m “edit comments”` The comments should be easier for others to understand it.
1. `git push origin "your branchname"` to push it to origin
1. Go to [Github](https://github.com/dream7boy/transroad) and create pull request. Don't forget to assign it to @dream7boy.
1. Check the pull reqest and resolve conflict **before you leave Github**

### ◎On Trello
1. Move the card to `Review` and assign that card to `@junggunlee` for him to review it.
2. Send message with `@` to Jung on Slack so that he can know the task is done.

## ▼【Lead dev】Merge Pull Requests
### ◎On Github
1. Check the changed file and do code review for each pull requests.
  - Coding conventin is okay?
  - Indentation is okay?
  - Any suggestions or questions to improve that codes?
1. Lead dev merges codes on Github
1. Delete merged branch right after it's merged to master.

### ◎On Trello
1. Move the card to `To Deploy` when finishing code review and merge.

## ▼【Lead dev】Deploy master to heroku
### ◎On Github
1. Check what will be deployed to heroku
1. `git push heroku master` to deploy the files to heroku
1. If you need to change DB structures, run `heroku run rails db:migrate` and restart the server(dynos) on heroku
1. Go to [heroku url](https://transroad.herokuapp.com/) to check the changes are applied on heroku.

### ◎On Trello
1. Move the card to `Done` when finishing deployment.

## ▼Start another tasks
1. `git status` to check if clean before pull, checkout or merge
1. `git checkout master`
1. `git pull origin master` to pull the latest master
1. `git sweep` to clean unused branches
