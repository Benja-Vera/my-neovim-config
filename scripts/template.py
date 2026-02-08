import sys
import os
import pathlib
import shutil

# collect passed arguments
template = sys.argv[1]
destination = sys.argv[2]

# collect directories
templates_dir = os.path.join(pathlib.Path(__file__).parent.parent.resolve(), "templates")  # should be neovim home directory
call_dir = os.getcwd()  # should be the directory where neovim was called

# get possible templates and assert the given option is one of them
possible_templates = os.listdir(templates_dir)
assert template in possible_templates, f"invalid template {template} passed, possible options are: {possible_templates}"

# if it is, then copy into specified destination
source_dir = os.path.join(templates_dir, template)
shutil.copytree(source_dir, os.path.join(call_dir, destination))

# success message
print(f"Successfully copied {template} template into {destination}")
