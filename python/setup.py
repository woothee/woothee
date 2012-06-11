from setuptools import setup

version = "0.1.0"

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
  tests_require = ['PyYAML>=3.10'],
  test_suite='tests',
  )
