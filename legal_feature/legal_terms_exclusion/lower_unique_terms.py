def unique_lowercase(source, target):
    '''
    Change all terms to lowercase, remove duplicates
    '''
    unique_terms = set()
    with open(source) as instream, open(target, 'w') as outstream:
        for line in instream:
            term = line.lower()
            if term not in unique_terms:
                outstream.write(term)
                unique_terms.add(term)


unique_lowercase("./legal_terms_exclusion/legislation_names.txt",
                 "./legal_terms_exclusion/unique_legislation_names.txt")
unique_lowercase("./legal_terms_exclusion/case_names.txt",
                 "./legal_terms_exclusion/unique_case_names.txt")
