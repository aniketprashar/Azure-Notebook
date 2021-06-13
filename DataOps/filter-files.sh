# ------------------------------------------------------------------------------------------------------------------------------ #
#                 Bash Script To Filter Files Whose Absolute Path Is Provided At Build Time As Runtime Variables.                #
# ------------------------------------------------------------------------------------------------------------------------------ #

echo $(absolutePath) >>tmpArtifact.txt
tr -s "," "\n" <tmpArtifact.txt >out.txt               # replace comma by new line
countOfNotebooks=$(wc -l out.txt | awk '{ print $1 }') # count number of lines
echo "Number of notebooks = "$countOfNotebooks
cat out.txt
mkdir output/
while IFS= read -r out; do
    cp --parents $out output/ # copy with complete path. Will create folders if not exists
done <out.txt

# ------------------------------------------------------------------------------------------------------------------------------ #
#       Filter Out Changes Done In The In The Latest Commit In The ADF Configuration Files Stored In Collaboration Branch.       #
# ------------------------------------------------------------------------------------------------------------------------------ #

git diff --diff-filter=d --name-only HEAD~1 HEAD~0 >Artifact.txt # diff filter is deselecting deleted files
countOfJsonFiles=$(wc -l Artifact.txt | awk '{ print $1 }')      # count number of lines
echo "Number of JSON Files = "$countOfJsonFiles
echo "---JSON files with complete path---"
cat Artifact.txt
mkdir Artifact/
while IFS= read -r Artifact; do
    cp --parents $Artifact Artifact/ # copy with complete path. Will create folders if not exists
done <Artifact.txt

# ------------------------------------------------------------------------------------------------------------------------------ #
#                                    Bash Script To Filter Files By The Latest Commit Changes.                                   #
# ------------------------------------------------------------------------------------------------------------------------------ #

git diff --diff-filter=d --name-only HEAD~1 HEAD~0 >Artifact.txt # diff filter is deselecting deleted files
countOfJsonFiles=$(wc -l Artifact.txt | awk '{ print $1 }')      # count number of lines
echo "Number of JSON Files = "$countOfJsonFiles
echo "---JSON files with complete path---"
cat Artifact.txt
mkdir Artifact/
while IFS= read -r Artifact; do
    cp --parents $Artifact Artifact/ # copy with complete path. Will create folders if not exists
done <Artifact.txt

# ------------------------------------------------------------------------------------------------------------------------------ #
#                 Bash Script To Filter Files Whose Absolute Path Is Provided At Build Time As Runtime Variables.                #
# ------------------------------------------------------------------------------------------------------------------------------ #

cho $(linkedService) >>tmpArtifact.txt
echo $(dataset) >>tmpArtifact.txt
echo $(pipeline) >>tmpArtifact.txt
echo $(trigger) >>tmpArtifact.txt

tr -s "," "\n" <tmpArtifact.txt >newArtifact.txt # replace comma by new line

awk '/\.json/' newArtifact.txt >Artifact.txt

countOfJsonFiles=$(wc -l Artifact.txt | awk '{ print $1 }')
echo "Number of JSON Files = "$countOfJsonFiles
echo "---JSON files with complete path---"
cat Artifact.txt
mkdir Artifact/
while IFS= read -r Artifact; do
    cp --parents $Artifact Artifact/
done <Artifact.txt
