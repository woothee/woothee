I'll be back here soon...

dataset example:

    # check -> full -> end.
    #       -> browser -> check os (for 'os' and 'category') -> end
    #       -> browser ->(unknown) -> check os -> end 
    - label: ShortNameForCodeAndTests
      name: Fullname for display
      type: 'os' or 'browser' or 'full'
      os[full]: 'mobilephone' or 'misc'
      vendor[browser/full]: 'Google/Apple/Microsoft/docomo/au/Softbank/Sony(PSP/PS3)/...'
      version[os/browser/full]: OPTIONAL (fixed value or set by code)
      category[os/full]: 'pc', 'smartphone', 'mobilephone', 'crawler', 'appliance', 'misc'
