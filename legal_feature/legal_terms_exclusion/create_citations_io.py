from glob import glob
import os
import sys

def create_citations(cases_dir = 'cases', output_dir = 'citations'):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    with open("citations_io.txt", "w") as io_list:
        for path in glob(os.path.join(cases_dir,"*.txt")):
            new_basename = os.path.splitext(os.path.basename(path))[0] + ".legislation10"
            input_path = os.path.abspath(path)
            output_path = os.path.abspath(os.path.join(output_dir, new_basename))
            io_list.write(f"{input_path};{output_path}\n")

if __name__ == "__main__":
    sys.exit(create_citations(*sys.argv[1:]))
