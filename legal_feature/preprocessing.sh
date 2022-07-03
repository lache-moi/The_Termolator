#!/bin/sh

## $1 = type of issue (broad or narrow)
## $2 = issue ID

echo "The path to the json file with document classification is $1"
echo "The issue ID is: $2"

TERMOLATOR=${3:-$TERMOLATORPATH}

## Optional Step 1: Generate the text cases and classify into broad/narrow issues
# echo "Retrieve Supreme Court legal cases in folder 'cases'"
# python3 $TERMOLATOR/legal_feature/supreme_court.py
# python3 $TERMOLATOR/legal_feature/classify_fbground.py


# At this stage there must be:
## 1. A directory in legal_feature /cases which contains .txt files of all cases to be processed (including intended foreground and background)
## 2. A json in the form {issue id(str): case names/ids ([ints/str]) s.t. if you append .txt to them, that would be their filename as stored in the cases directory}
## Step 2: Generate legal term exclusion
echo "Generate legal terms to exclude: case/legislation names"
python3 $TERMOLATOR/legal_feature/legal_terms_exclusion/create_citations_io.py
cd $TERMOLATOR/legal_feature/legal_entities
python3 run_citations.py ../citations_io.txt
cd $TERMOLATOR/legal_feature
python3 $TERMOLATOR/legal_feature/legal_terms_exclusion/legal_terms_extraction.py $TERMOLATOR/legal_feature/citations
python3 $TERMOLATOR/legal_feature/legal_terms_exclusion/lower_unique_terms.py

## Step 3: Generating the foreground and background for issue ID $2 using the classification in $1
echo "Generating the foreground and background for issue ID $2"
python3 $TERMOLATOR/legal_feature/create_fbground.py $2 $1