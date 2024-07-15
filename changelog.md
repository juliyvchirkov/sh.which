# Changelog

This changelog includes all notable changes to the **[which.sh](https://github.com/juliyvchirkov/sh.which)** project.

## [Unreleased]

### Fixed

- The oversight in **[cleanup](dev/cleanup.sh)** script. By design if the script fails to change the working directory to **[dev](dev)** before starting the cleanup routine, it should abort with the statement *"Fatal: unable to change current working directory to dev"* on ``/dev/stderr``, but this could never happen due to the **[missing directive](dev/cleanup.sh#L18)** ``exit 1``  next to the above report
- A number of grammar typos in **[readme](readme.md)**
- Broken ``404`` link at the first sentense of **[Preamble](readme.md#preamble)**. The link has been pointing to  **[src](src)/which.sh** instead of **[src/which.classic.sh](src/which.classic.sh)** ʼcause it has been initially added to the readme upon the old project tree structure which turned obsolete on **[which on steroids](readme.md#which-on-steroids)** arrival

## [2.0.0] - 2024-07-09

### Added

- Extended edition of  **[which](readme.md#which-on-steroids)** function. Implemented as kinda successor of the classic edition which delivers the extra feature to locate command(s) among shell builtins, functions and aliases
- Option ``-i`` to ignore shell builtins, functions and aliases on lookup for extended edition of ``which`` function
- Test suite for thorough testing of both editions against the bunch of  **[23 shell interpretters](readme.md#the-coverage)** which meet ``POSIX`` specification and are available for ``Linux`` and ``Darwin`` (macOS) platforms nowadays
- Dedicated **[tests runner](dev/run-tests.sh)** to rule test suite
- **[Cleanup](dev/cleanup.sh)** script for optional use when the tests are over
- Detailed **[readme](readme.md)** covering each nuance of both editions
- **[MIT](license)** license
- Special shortcut links **[juliyvchirkov.dev/get/which.sh](https://juliyvchirkov.dev/get/which.sh)** to get the latest release of classic edition of ``which`` function and **[juliyvchirkov.dev/get/which.sh?ed=ext](https://juliyvchirkov.dev/get/which.sh?ed=ext)** to get the latest release of extended one

### Changed

- **[Initial](https://github.com/juliyvchirkov/sh.which/blob/v1.0.0/which.sh)** function has been totally revised and redesigned from scratch to mimic the external classic ``which`` command as close as possible
- A number of commands to locate at arguments has been increased from the one and only to the unlimited (one can get the actual limits of a system with **[GNU xargs](https://www.gnu.org/software/findutils/manual/html_node/find_html/xargs-options.html)** thru ``xargs -r --show-limits </dev/null``)
- Each report line for a located command is now ended with line feed ``\n``
- Option ``-a`` has been implemented to report all matches for located command(s) instead of the default first one
- Option ``-s`` has been implemented to locate command(s) silently with no report(s) to ``/dev/stdout``
- Extra exit status code ``2`` has been added to indicate an invalid option
- The corresponding detailed help is provided when the function is launched with no arguments or an invalid option is specified 

### Fixed

- The oversight at PATH parsing subroutine due to which the function has been unable to locate a command if a path of that command contains space(s) 

## [1.0.0] - 2018-04-23

### Added

- First public release of  ``which`` function (initially published as **[gist](https://gist.github.com/juliyvchirkov/d2c7ff01846157f58b1fc1f3a3b1e36c)**)

  
[unreleased]: https://github.com/juliyvchirkov/sh.which/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/juliyvchirkov/sh.which/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/juliyvchirkov/sh.which/releases/tag/v1.0.0

---
<small>The project adheres to **[Semantic Versioning](https://semver.org/spec/v2.0.0.html)**. The format of this changelog meets the guidelines of **[Keep a Changelog](https://keepachangelog.com/en/)**.</small>
