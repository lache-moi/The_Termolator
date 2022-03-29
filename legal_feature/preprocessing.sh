#!/bin/sh

## $1 = type of issue (broad or narrow)
## $2 = issue ID

echo "The issue is of type: $1"
echo "The issue ID is: $2"

TERMOLATOR=${3:-$TERMOLATORPATH}

## Step 1: Generate the text cases and classify into broad/narrow issues
echo "Retrieve Supreme Court legal cases in folder 'cases'"
python3 $TERMOLATOR/legal_feature/supreme_court.py
python3 $TERMOLATOR/legal_feature/classify_fbground.py

## Step 2: Generate legal term exclusion
echo "Generate legal terms to exclude: case/legislation names"
python3 $TERMOLATOR/legal_feature/legal_terms_exclusion/create_citations_io.py
cd $TERMOLATOR/legal_feature/legal_entities
python3 run_citations.py $TERMOLATOR/legal_feature/citations_io.txt
cd $TERMOLATOR/legal_feature
python3 $TERMOLATOR/legal_feature/legal_terms_exclusion/legal_terms_extraction.py $TERMOLATOR/legal_feature/citations
python3 $TERMOLATOR/legal_feature/legal_terms_exclusion/lower_unique_terms.py

## Step 3: Generating the foreground and background for $1 issue ID $2
echo "Generating the foreground and background for $1 issue ID $2"
python3 $TERMOLATOR/legal_feature/create_fbground.py $2 $1
