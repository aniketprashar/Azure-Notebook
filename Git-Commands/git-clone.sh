# ------------------------------------------------------------------------------------------------------------------------------ #
#                                                      Clone Specific Branch                                                     #
# ------------------------------------------------------------------------------------------------------------------------------ #

git clone -b <branchname> <remote-repo-url>
git clone --branch <branchname> <remote-repo-url>

# With this, you fetch all the branches in the repository, checkout to the one you specified, and the specific branch becomes
# the configured local branch for git push and git pull . But you still fetched all files from each branch.

git clone --branch <branchname> --single-branch <remote-repo-url>
git clone -b <branchname> --single-branch <remote-repo-url>

# It allows you to only fetch files from the specified branch without fetching other branches.

# ------------------------------------------------------------------------------------------------------------------------------ #
#                                                          Shallow Clone                                                         #
# ------------------------------------------------------------------------------------------------------------------------------ #

git clone --depth=1 <url>
cd <Project-Name>
git fetch --unshallow