from setuptools import setup, Command

version = "0.1.0"

class dataset_command(Command):
  
  description = 'generate dataset.py'
  
  user_options = []
  
  def initialize_options(self):
    pass
  
  def finalize_options(self):
    pass
  
  def run(self):
    import os, sys
    root_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    bin_dir = os.path.join(root_dir, 'bin')
    sys.path.insert(0, bin_dir)
    import dataset_yaml2py

setup(
  name = 'woothee',
  version = version,
  description = 'user-agent classificator',
  author = 'Najeira',
  author_email = 'najeira@gmail.com',
  url = 'https://github.com/tagomoris/woothee',
  license = 'http://www.apache.org/licenses/LICENSE-2.0',
  packages = ['woothee'],
  package_dir = {'': 'lib'},
  platforms = 'any',
  setup_requires = ['PyYAML>=3.10'],
  test_suite='tests',
  cmdclass={'dataset': dataset_command},
  )
