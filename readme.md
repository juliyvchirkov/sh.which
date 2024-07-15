# Which

**World known regular command ``which``, implemented as fully ``POSIX`` compliant ``sh`` shell function with no dependencies**

Designed and developed in 2018 &mdash; 2024 by **[Juliy V. Chirkov](https://juliyvchirkov.dev/)** under the **[MIT license](https://juliyvchirkov.mit-license.org/2018-2024)**.

Linted and tested against the bunch of  **[23 shell interpreters](#the-coverage)** which meet ``POSIX`` specification and are available under ``Linux`` and ``Darwin`` (macOS) platforms nowadays.

The current (latest) implementation is **v2.0.0** released at **Jul 09 2024**. This release delivers the fix for the commands locator routine along with a lot of significant improvements. Please refer to the **[changelog](changelog.md)** for details.

## TOC

- **[Preamble](#preamble)**
- **[The coverage](#the-coverage)**
- **[Dependencies](#dependencies)**
- **[Install](#install)**
- **[Testing](#testing)**
- **[Benchmarks](#benchmarks)**
- **[Usage](#usage)**
   - **[Classic which](#classic-which)**
   - **[Which on steroids](#which-on-steroids)**
- **[Bugs and features](#bugs-and-features)**
- **[Support the creator](#support-the-creator)**
  
## Preamble

The proposed **[implementation](src/which.classic.sh)** of world known regular old school command ``which`` has been developed as fully ``POSIX`` compliant ``sh`` shell function with the double goal

- [x] to provide a *decent reasonable alternative* to the regular external **[which](https://man.freebsd.org/cgi/man.cgi?which(1))** command for ``sh`` shell scripts. As a rule ``sh`` shell scripts  depend on some external commands (binaries) so the best practice to avoid a script failure ʼcause of these dependencies is to check if all required external commands (binaries) exist, and the most widespread method is ``which`` command. But the thing is ``which`` command per se is external too, which inspires kinda *chicken or the egg* paradox. The proposed replica has been designed as fully ``POSIX`` compliant ``sh`` shell function with no dependencies to resolve this paradox
- [x] to cover *the lionsʼ share of interpreters* in their kinda *strict* mode, when these shells meet ``POSIX`` specification acting like ``sh``, **[the standard command language interpreter](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html)**

## The coverage

This ``which`` replica had been tested across and confirmed to run *the same brilliant way* with interpreters ``ash``, ``bash``, ``busybox sh``, ``dash``, ``ksh``, ``loksh``, ``mksh``, ``oksh``, ``pdksh``, ``posh``, ``yash`` and ``zsh``.

Each interpreter in a row has been involved for test rounds in both regular and strict ``POSIX`` modes. The last one has been achieved by launching shells thru `sh` symlink.

Interpreters from the above list running under ``sh``  name turn to act the strict ``POSIX`` way **[to be extremely close](https://www.gnu.org/software/bash/manual/html_node/Bash-POSIX-Mode.html)** to the standard **[sh interpreter](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html)** by default, thus making the testing phase much easier.

## Dependencies

No dependencies. The whole thing is built on ``POSIX`` compliant builtins.

## Install

Since ``which`` is simply a standalone ``sh`` function, thereʼs no need neither to install it nor even to make its source file executable.

- [x] just fetch the code to your local storage (**[the link below](https://juliyvchirkov.dev/get/which.sh)** will always lead you to the latest release)

```shell
curl -fsSLo "${HOME}/.local/share/which.sh" https://juliyvchirkov.dev/get/which.sh
```

- [x] source it in your scripts

```shell
#!/usr/bin/env sh

[ -z "${SHDEBUG}" ] || set -vx

. "${HOME}/.local/share/which.sh"
```

- [x] and utilize the way you like

## Testing

Test suite is  available under **[dev](dev)** subfolder. 

Use the following commands sequence to run tests. 

```shell
git clone https://github.com/juliyvchirkov/sh.which.git -b v2.0.0 sh.which
cd sh.which
sh dev/run-tests.sh
```

The suite is built upon **[Shellspec](https://shellspec.info/)** (*full-featured BDD unit testing framework for ``POSIX`` shells*) v0.28.1. Test routines have been designed to utilize **[Shellcheck](https://www.shellcheck.net/)** (*static analysis tool for shell scripts*) v0.10.0 for linting and to cover almost all of the **[shell interpreters](#the-coverage)** listed above.

To run test thereʼs no need to preinstall neither ``Shellcheck`` nor ``Shellspec``. The  **[runner](dev/run-tests.sh)** will do its best to manage required dependencies automatically keeping your system free of untracked garbage.

The basic dependency ``Shellspec``  will be fetched and installed to ``bin`` subfolder created under the **[dev](dev)**.

> [!NOTE]
> This note is dedicated to express my respect and gratitude to the author of
> ``Shellspec`` testing framework.
> 
> To select the modern test engine for this project Iʼve spent some time on
> experiments  with a number of  available frameworks focused on testing 
> stuff for ``POSIX`` shells.
> 
> And I must admit Iʼve got heavily impressed how ``Shellspec``
> benefits over others, first of all by its concept  to deliver the human (developer)
> friendly testing environment and really useful ready-made helper tools out
> of the box.
>  
> Moreover,  being focused on ``POSIX`` cross-platform shell scripts and shell
> script libraries, ``Shellspec`` is completely built on ``sh`` scripts and
> libraries itself, which makes this framework platform independent and
> extremely portable. 

The linter ``Shellcheck``  will be fetched and installed to the same subfolder as well, if possible. The binaries for fetching and install are available for ``x86_64`` and  ``arm64`` architectures of ``Linux``  or  ``Darwin``  (macOS)  platforms. If your system doesnʼt match, the runner script should try to utilize your local  ``shellcheck`` command  if youʼve got one preinstalled, and will skip the linting routine otherwise.

The runner also have been designed to utilize no shell interpreters except those you have already preinstalled. If some **[shell from the list](#the-coverage)** is not available at a system,  the corresponding tests will be skipped.

> [!IMPORTANT]
> Tests against ``loksh`` and ``pdksh`` shells have been excluded from the suite since
> these interpreters force ``Shellspec`` inner shell inspection routine stuck with
> this inspection for ages.
>
> The same glitch makes tests against ``oksh`` interpreter to be available only for
> ``Darwin`` (macOS) platform.
>
> In turn, tests against ``posh`` shell for ``Darwin`` platform have been excluded
> from the suite ʼcause the release of this interpreter delivered with 
> **[brew](https://brew.sh)** for macOS is broken. 

> [!TIP]
> Since the installed dependencies occupy about ``45Mb`` of your local space, the fair 
> desire would be to get this space back once the tests are over.
>
> Please feel free to drop the whole ``bin`` folder under the **[dev](dev)** 
> and youʼre done. 
> 
> To make it fast and easy you are welcome to utilize the **[cleanup](dev/cleanup.sh)** 
> script ``sh dev/cleanup.sh`` implemented exactly for this purpose.
> 
> If you wish to re-run the tests later, the **[runner](dev/run-tests.sh)** will 
> fetch and instal required stuff the same way once again.

## Benchmarks

The stats below have been collected at ``MacBook Air 13”, 2017`` (2.2GHz dual-core Intel Core i7 with Turbo Boost up to 3.2GHz, 256KB L2 cache on each core and 4MB shared L3 cache, Intel HD Graphics 6000 1536MB, 8GB of 1600MHz LPDDR3 RAM and 512GB NVMe Storage) under ``macOS Ventura 13.6.6`` (Darwin Kernel Version 22.6.0 Mon Feb 19 19:48:53 PST 2024).

<table>
  <thead>
    <tr>
      <th rowspan="2"></th>
      <th colspan="3" align="center">which -a which</th>
      <th colspan="3" align="center">which -s which</th>
      <th colspan="3" align="center">which -sa which</th>
    </tr>
    <tr>
      <th align="center">real</th>
      <th align="center">user</th>
      <th align="center">sys</th>
      <th align="center">real</th>
      <th align="center">user</th>
      <th align="center">sys</th>
      <th align="center">real</th>
      <th align="center">user</th>
      <th align="center">sys</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>This replica</strong></td>
      <td align="right">7.590</td>
      <td align="right">2.386</td>
      <td align="right">3.300</td>
      <td align="right">2.773</td>
      <td align="right">1.112</td>
      <td align="right">1.568</td>
      <td align="right">2.875</td>
      <td align="right">1.120</td>
      <td align="right">1.582</td>
    </tr>
    <tr>
      <td><strong><a href="https://man.freebsd.org/cgi/man.cgi?which(1)">BSD which</a></strong></td>
      <td align="right">14.006</td>
      <td align="right">2.406</td>
      <td align="right">7.178</td>
      <td align="right">5.403</td>
      <td align="right">1.537</td>
      <td align="right">3.334</td>
      <td align="right">5.599</td>
      <td align="right">1.556</td>
      <td align="right">3.509</td>
    </tr>
    <tr>
      <td><strong><a href="https://linux.die.net/man/1/which">GNU which</a></strong></td>
      <td align="right">16.803</td>
      <td align="right">2.946</td>
      <td align="right">7.091</td>
      <td align="center">&mdash;</td>
      <td align="center">&mdash;</td>
      <td align="center">&mdash;</td>
      <td align="center">&mdash;</td>
      <td align="center">&mdash;</td>
      <td align="center">&mdash;</td>
    </tr>
    <tr>
      <td><strong><a href="https://www.npmjs.com/package/which">NodeJs which</a></strong></td>
      <td align="right">205.846</td>
      <td align="right">145.041</td>
      <td align="right">38.102</td>
      <td align="right">184.100</td>
      <td align="right">132.084</td>
      <td align="right">30.539</td>
      <td align="right">184.657</td>
      <td align="right">133.711</td>
      <td align="right">30.570</td>
    </tr>
  </tbody>
</table>

> [!NOTE]
> Under ``Darwin`` (macOS) ``BSD which`` command is located at 
> ``/usr/bin/which``, ``GNU which`` command is installed with
> **[brew](https://brew.sh)**  to
> ``/usr/local/opt/gnu-which/libexec/gnubin/which``
> and ``NodeJs which`` is placed by **[npm](https://docs.npmjs.com/)** 
> to ``/usr/local/bin/which``. 
> 
> For testing purposes the whole triple have been added to ``PATH``.

As shown, the stats have been collected in three steps. On the first one (``which -a which``) this replica and the triple of ``which`` binaries have been reporting to ``/dev/stdout`` the same three lines 

```shell
/usr/local/opt/gnu-which/libexec/gnubin/which
/usr/local/bin/which
/usr/bin/which
```

The second and third steps (``which -s which`` and ``which -sa which``) have been passed with no output due to the nature of ``-s`` option.

> [!IMPORTANT]
> ``GNU which`` command has been excluded from the second and third steps 
>  since it provides no ``-s`` option.

The reported units are seconds, accurate to milliseconds. The values represent  the total time of 1000 rounds for each ``which``  on each step.  The stats have been collected by running the following commands sequence at root folder of the repository.

```shell
dev/bin/sh.bash/sh

. src/which.classic.sh

rounds="$(seq 1 1000)"

time for round in ${rounds}; do /usr/local/opt/gnu-which/libexec/gnubin/which -a which; done

for option in -a -s -sa; do
    time for round in ${rounds}; do which "${option}" which; done
    time for round in ${rounds}; do /usr/bin/which "${option}" which; done
    time for round in ${rounds}; do /usr/local/bin/which "${option}" which; done
done
```

## Usage

#### Classic which

The function has been designed to mimic the external classic ``which`` command as close as possible, so it completely meets **[the origin](https://man.freebsd.org/cgi/man.cgi?which(1))**, except for one nuance. 

The one and only significant difference and the only inconsistency of this replica vs the classic external  ``which`` command is the subroutine when  function launched with no arguments (or with an invalid option) provides much more detailed help screen than the origin does. 

``` shell
which
````

This inconsistency is necessary because unlike the external  ``which`` command the function by its nature offers no detailed manual available thru ``man 1 which``.

```help
which: locates command(s) and reports to standard output

USAGE
    which [-as] command …
OPTIONS
    -a     print all matches
    -s     silently return 0 if all commands are located or 1 otherwise
EXIT STATUS
    0      all commands are located
    1      failed to locate some command(s)
    2      an invalid option is specified
````

Thereʼs  also one more feature which being neither a difference nor an inconsistency worth to be annotated anyway. 

Unlike the lionsʼ share of common shell script functions, this replica strictly honors the double dash ``--`` option despite this fact is left behind the help screen.

The double dash option has the status of ``POSIX`` defined **[delimiter to indicate the end of options](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html)** passed to a command or a function. The definition states *Any arguments after the double dash ``--`` should be treated as operands, even if they begin with the ``-`` character* and in the field this delimiter is extremely useful thing to divide options and arguments with no doubts, especially when arguments include a file or a folder which name starts with dash ``-``.

```shell
which -s -- -a-command-name-starting-with-dash
```

The above ignites the regular flow and the function will silenly return 0 if a command named ``-a-command-name-starting-with-dash`` exists or 1 otherwise.

```shell
which -s -a-command-name-starting-with-dash
```

But the same request with no double dash ``--`` ends up with exit status 2 (mostly as a total surprise for an operator) along with a report of invald option printed on ``/dev/stderr``. 

```shell
which: invalid option — a-command-name-starting-with-dash
```

The example below, in turn, uncovers the other side of a coin when a regular routine due to the double dash ``--`` gets broken.

```shell
which -a -- -s bash
```

``-a`` is processed as usual, but ``-s`` is not treated as option anymore. The leading double dash turns it into a command along with the following ``bash``, and instead of expected silent exit status 0 on return the above construct leads to report(s) about located ``bash`` binary(ies) printed to ``/dev/stdout`` along with exit status 1, since ``-s`` command is unlikely to be located.

```shell
/usr/local/bin/bash
/bin/bash
```

The second common use case for the double dash ``--`` delimiter is to divide arguments passed to some command or function and arguments which this command or function should transfer to another one.

```shell
#!/usr/bin/env sh

[ -z "${SHDEBUG}"] || set -vx

master() {
    while [ $# -gt 0 ]; do
        if [ "${1}" = -- ]; then
            shift
            
            set -- "${@}"
            
            break
        fi
        # … processing arguments passed to the function
        
        shift
    done
    
    slave "${@}"
}

slave() {
# … 
}

master -apu -- -laz
# …
```

But the above is already kinda beyond the scope of this project.

The external classic ``which`` command also honors the double dash ``--`` delimiter, despite its manual as well has no mentions on this topic,  so for this case the replica exactly meets the origin.

All other features the function delivers and declares at the help screen vs implementations provided by origin ``which`` command are totally the same.

> [!NOTE]
> The samples below have been produced under  ``Darwin`` (macOS).
> 
> This assumes the one and only ``sh`` binary placed at ``/bin`` folder, and 
> three binaries of ``bash``, ``dash`` and ``ksh`` per folder at 
> ``/usr/local/bin`` and  ``/bin`` folders. 
> 
> The first triple is fresh releases installed with **[brew](https://brew.sh)**,
> the second one &mdash; the default shells which come along with OS. 

Long story short, the top #1 of the mostly widespread use cases is shared between a request with a single command name and no options

```shell
which sh
```

which ends up with a path of executable printed to ``/dev/stdout`` and exit status ``0`` if a command is located and exit status ``1`` otherwise

```
/bin/sh
```

and its twin with the same single command name and ``-s`` option widely utilized in non-interactive mode to verify the availability of a command and produce no output

```shell
which -s sh
```

which silently ends up with exit status ``0`` if a command is located and exit status ``1`` otherwise.

Less common case is a bulk lookup illustrated below.  

```shell
which bash dash ksh 
```

The successful response will look like 

```shell
/usr/local/bin/bash
/usr/local/bin/dash
/usr/local/bin/ksh
```

The same command with ``-s`` option silently ends up with exit status ``0`` if the triple exists at ``PATH`` or ``1`` if some binary cannot be located.

```shell
which -s bash dash ksh 
```

``-a`` option is utilized to locate all commands at ``PATH`` with certain name(s) 

```shell
which -a bash
```

and the response looks like

```shell
/usr/local/bin/bash
/bin/bash
```

The bulk lookup with ``-a`` option 

```shell
which -a bash dash ksh
```

produces the output like

```shell
/usr/local/bin/bash
/bin/bash
/usr/local/bin/dash
/bin/dash
/usr/local/bin/ksh
/bin/ksh
```

Both ``-a -s`` (``-s -a``, ``-as``, ``-sa``) options together are accepted as well, although due to the nature of ``-s`` utilizing them this way is kinda senseless.

#### Which on steroids

Although nowadays, when the quarter of XXI century is almost left behind, the old school axiom ”*command not found at ``PATH``* equals *command is not available*” is not always true.

Today many vendors follow the practice to deliver a number of useful extras along with a shell. These extras mostly are collections of vendorsʼ ``builtins`` and sometimes also of vendorsʼ ``functions``. 

Shortly, ``builtin`` is an integrated command which code is a part of code of a shell interpreter, and ``function`` is a regular function, implemented by vendor for own shell interpreter on the grounds of its features and benefits (a nice primer is the **[Fish shell stuff](https://fishshell.com/docs/current/commands.html#known-functions)**).

The collections are developed **[to implement functionality impossible or inconvenient to obtain with separate utilities](https://www.gnu.org/software/bash/manual/html_node/Shell-Builtin-Commands.html)**, and as a rule at least some vendorsʼ ``builtins`` and ``functions`` are implemented to override classic external binaries like ``:``, ``[``, ``basename``, ``cd``, ``dirname``, ``echo``, ``false``, ``id``, ``kill``, ``mkdir``, ``mkfifo``, ``mktemp``, ``printenv``, ``printf``, ``pwd``, ``realpath``, ``rm``, ``rmdir``, ``sleep``, ``sync``, ``tee``, ``test``, ``time``, ``true``, ``tty``, ``uname``, ``unlink``, ``whoami`` **[et cetera](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html)**.

The commands, integrated into a shell to override the corresponding externals, completely mimic the features of classic origins or provide at least their core functionality, used at most. Each time a command like ``printf`` is called at command line or within  a script by basename, a shell instead of executing the corresponding external binary ``/usr/bin/printf`` substitutes it with own ``builtin printf`` implementation.

The benefits are obvious and evident &mdash; as a rule, integrated commands vs classic external ones are much more lightweight,  and ``builtins`` are significantly faster vs the origins ʼcause they are modern, ʼcause for a shell itʼs a priori faster to execute a code that is part of that shell than an external binary and ʼcause to run an internal command a shell doesnʼt need  to deploy a subshell.

Thus de facto thereʼs no need to depend on external ``printf``, ``mkdir`` or ``kill`` commands in field nowadays if a shell serves the corresponding ``builtins``.

So to provide *even more reasonable alternative* to the regular external **[which](https://man.freebsd.org/cgi/man.cgi?which(1))** command for ``sh`` shell scripts, along with the replica of classic ``which`` this project also includes **[the modern extended implementation](src/which.extended.sh)**, namely *``which`` on steroids*.

To utilize this implementation at your local projects, follow the above **[install instructions](#install)** and simply replace **[the link to classic edition](https://juliyvchirkov.dev/get/which.sh)** provided there with **[the link to extended one](https://juliyvchirkov.dev/get/which.sh?ed=ext)** this way 

```shell
curl -fsSLo "${HOME}/.local/share/which.sh" https://juliyvchirkov.dev/get/which.sh?ed=ext
```

The proposed extended edition has been implemented as kinda successor of the classic one to deliver the extra feature to locate command(s) among shell builtins, functions and aliases.

In order to keep full backward compatibility with the classic edition  and the external origin this ``which`` on steroids also provides the extra option ``-i`` to ignore shell builtins, functions and aliases on lookup.

```help
which: locates command(s) and reports to standard output

USAGE
    which [-ias] command …
OPTIONS
    -i     ignore shell builtins, functions and aliases
    -a     print all matches
    -s     silently return 0 if all commands are located or 1 otherwise
EXIT STATUS
    0      all commands are located
    1      failed to locate some command(s)
    2      an invalid option is specified
````

The extended edition meets the same flow as the classic one, exept on lookup this function first of all checks if a command exists among shell builtins, functions and aliases, and after that tries to locate it at ``PATH``. 

The nuances are illustrated below. 

```shell
which pwd 
```

If ``-a`` option is not specified, the function will end up with a command located among shell builtins, functions and aliases

```shell
pwd 
```

The same is true for a silent lookup with ``-s`` option

```shell
which -s pwd 
```

If a command is located among shell builtins, functions and aliases, the function stops the lookup and silently ends up with exit status ``0``.

```shell
which -a pwd 
```

``-a`` option will lead to the response like this

```shell
pwd
/bin/pwd
```

On  a bulk lookup this behaviour is kept unchanged. 

```shell
which cd printf which 
```

The above command with no options ends up with the response like

```shell
cd
printf
which 
```

The same command with ``-a`` option

```shell
which -a cd printf which 
```

produces the report

```shell
cd
/usr/bin/cd
printf
/usr/bin/printf
which
/usr/bin/which
```

When ``-i`` option  is on, this extended edition behaves exactly the same as the classic one.

```shell
which -i pwd
```

Both the above and below commands

```shell
which -ia pwd
```

end up with the response

```shell
/bin/pwd
```

As well as this command 

```shell
which -i cd printf which 
```

and this one both

```shell
which -ia cd printf which 
```

produce the same output

```shell
/usr/bin/cd
/usr/bin/printf
/usr/bin/which
```

> [!IMPORTANT]
> If a command is located among shell builtins or functions, it is reported to 
> ``/dev/stdout`` as is with a single basename, since neither builtin nor 
> function canʼt have a path by design.
> 
> If a command is located among shell aliases, the function expands that alias
> and provides its content on report. 

## Bugs and features

If you are facing some bug or want to request a feature, please **[follow this link to create an issue or request respectively](https://github.com/juliyvchirkov/sh.which/issues)**, and thank you for your time and contribution in advance.

## Support the creator

If you like this project, you can follow the links below to support the creator 

&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;<a href="https://buymeacoffee.com/juliyvchirkov"><img src="https://cdn.juliyvchirkov.dev/svg/buymeacoffee.com.svg" style="width: 30px; height: 30px; border: 0" valign="middle"></a> <a href="https://buymeacoffee.com/juliyvchirkov">**buymeacoffee**</a>

&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;<a href="https://liberapay.com/juliyvchirkov"><img src="https://cdn.juliyvchirkov.dev/svg/ko-fi.com.svg" style="width: 30px; height: 30px; border: 0" valign="middle"></a> <a href="https://ko-fi.com/juliyvchirkov">**ko-fi**</a>

&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;<a href="https://paypal.me/juliyvchirkov"><img src="https://cdn.juliyvchirkov.dev/svg/paypal.com.svg" style="width: 30px; height: 30px; border: 0" valign="middle"></a> <a href="https://paypal.me/juliyvchirkov">**paypal**</a>

&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;<a href="https://liberapay.com/juliyvchirkov"><img src="https://cdn.juliyvchirkov.dev/svg/liberapay.com.svg" style="width: 30px; height: 30px; border: 0" valign="middle"></a> <a href="https://liberapay.com/juliyvchirkov">**liberapay**</a>

&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;<a href="https://juliyvchirkov.dev/donate#crypto"><img src="https://cdn.juliyvchirkov.dev/svg/bitcoin.svg" style="width: 30px; height: 30px; border: 0" valign="middle"></a> <a href="https://juliyvchirkov.dev/donate#crypto">**crypto**</a>

&#xa0;
Thanks from my heart <img src="https://cdn.juliyvchirkov.dev/svg/heart-ukraine-emoji.svg" style="width: 30px; height: 30px; border: 0" valign="middle"> to everyone who supports <img src="https://cdn.juliyvchirkov.dev/svg/raised-fist-emoji.svg" style="width: 30px; height: 30px; border: 0" valign="middle">

&#xa0;
<img src="https://cdn.juliyvchirkov.dev/svg/flag-ukraine-blood-n-soil-emoji.svg" style="width: 30px; height: 30px; border: 0" valign="middle"> <big>**Glory to Ukraine!**</big> <img src="https://cdn.juliyvchirkov.dev/svg/flag-ukraine-emoji.svg" style="width: 30px; height: 30px; border: 0" valign="middle">

&#xa0;
Juliy V. Chirkov,   
<a href="https://t.me/juliyvchirkov"><img src="https://cdn.juliyvchirkov.dev/svg/telegram.org.svg" style="width: 30px; height: 30px; border: 0" valign="middle"></a> <a href="https://t.me/juliyvchirkov">**juliyvchirkov**</a>

